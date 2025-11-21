use std::sync::Arc;

use bincode::Decode;
use bincode::Encode;

use crate::call::ticket::Ticket;
use crate::p2p::Message;
use crate::{
    call::call_session::CallSession,
    p2p::{Peer, PeerConfig},
};

#[derive(Debug, Decode, Encode)]
enum CallHandshake {
    CallRequest { display_name: String },
    CallAccept,
    CallReject,
    CallBusy,
}

impl Message for CallHandshake {
    fn deserialize(data: &[u8]) -> anyhow::Result<Self>
    where
        Self: Sized,
    {
        let deserialized_data = bincode::decode_from_slice(data, bincode::config::standard())?;
        return Ok(deserialized_data.0);
    }
    fn serialize(&self) -> anyhow::Result<Vec<u8>> {
        let serialized_data = bincode::encode_to_vec(self, bincode::config::standard())?;
        return Ok(serialized_data);
    }
}
pub struct CallManager {
    peer: Arc<Peer>,
    display_name: Arc<String>,
}

impl CallManager {
    // Initialize the call manager
    // initialize the connection receiver which listen to connection in background
    // when new connection is received call back is called
    pub async fn initialize<R, A, FutA, FutR>(
        display_name: String,
        on_call_received: R, // this is the function called when received the call and used to determine whether to accept or reject the call
        on_call_accepted: A, // this is the function called when accepted the call
    ) -> anyhow::Result<CallManager>
    where
        R: Fn(String) -> FutR + 'static + Send + Sync,
        FutR: Future<Output = bool> + Send,
        A: Fn(CallSession) -> FutA + 'static + Send + Sync,
        FutA: Future<Output = ()> + Send,
    {
        let peer = Arc::new(Peer::new(PeerConfig::default()).await?);
        let display_name = Arc::new(display_name);

        let mut listener = peer.clone().listen().await?;

        let display_name_cloned = display_name.clone();

        tokio::spawn(async move {
            let is_oncall = false;
            while let Ok(Some(mut connection)) = listener.accept().await {
                println!("Call received");

                //if is_oncall just send the Call::busy signal
                if is_oncall {
                    connection.send(CallHandshake::CallBusy).await?;
                }

                // receive the call request
                let handshake = connection.receive::<CallHandshake>().await?;

                match handshake {
                    Some(CallHandshake::CallRequest { display_name }) => {
                        if on_call_received(display_name).await {
                            connection.send(CallHandshake::CallAccept).await?;
                            let call_session = CallSession::start(connection).await?;
                            on_call_accepted(call_session).await;
                        } else {
                            connection.send(CallHandshake::CallReject).await?;
                            connection.close();
                        }
                    }
                    // Ignore other initial request for now
                    _ => {
                        eprintln!("Invalid protocol");
                        continue;
                    }
                }
            }
            anyhow::Ok(())
        });
        Ok(CallManager {
            peer: peer,
            display_name: display_name_cloned,
        })
    }

    // call the node address
    pub async fn call<A, R, FutA, FutR>(
        &self,
        nodeaddress_ticket: String,
        on_call_accepted: A, // this is the function called when accepted the call
        on_call_rejected: R,
    ) -> anyhow::Result<()>
    where
        A: Fn(CallSession) -> FutA + 'static + Send + Sync,
        R: Fn() -> FutR + 'static + Send + Sync,
        FutA: Future<Output = ()> + Send,
        FutR: Future<Output = ()> + Send,
    {
        let mut connection = self
            .peer
            .connect(Ticket::decode(&nodeaddress_ticket)?.node_addrs)
            .await?;

        connection
            .send(CallHandshake::CallRequest {
                display_name: self.display_name.as_ref().clone(),
            })
            .await?;

        let call_response = connection.receive::<CallHandshake>().await?;

        match call_response {
            Some(CallHandshake::CallAccept) => {
                on_call_accepted(CallSession::start(connection).await?).await;
            }
            Some(CallHandshake::CallReject) => {
                on_call_rejected().await;
                return Ok(());
            }
            _ => {
                eprintln!("Invalid protocol");
                return Ok(());
            }
        }

        Ok(())
    }

    pub fn get_ticket(&self) -> anyhow::Result<String> {
        let ticket =
            Ticket::new(self.display_name.as_ref().clone(), self.peer.address()).encode()?;
        return Ok(ticket);
    }
}
