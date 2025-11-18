use bincode::{Decode, Encode};
use flutter_rust_bridge::{frb, DartFnFuture};
use phiny_core::p2p::{Connection, Message, Peer, PeerConfig, Ticket};
use tokio::sync::mpsc;

pub struct PeerAdaptor {
    pub node_address: String,
    pub display_name: String,
    peer: Peer,
}

// This is opaque type for transfering the connection object throughout the task
pub struct ConnectionAdaptor {
    _internal_connection: mpsc::Receiver<Connection>,
    connection: Option<Connection>,
}

impl ConnectionAdaptor {
    #[frb]
    pub async fn accept(&mut self) -> Option<Connection> {
        self._internal_connection.recv().await
    }
}

#[derive(Debug, Encode, Decode)]
pub enum CallHandshake {
    DisplayName(String),
    // This represent the calle reject the call
    Rejection,
    // This represent the some warning like on another call or other things
    Message(String),
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

// This is basic utilization of the application which each node have to do it
pub async fn initialize(display_name: String) -> Result<PeerAdaptor, String> {
    let peer = Peer::new(PeerConfig::default())
        .await
        .map_err(|e| e.to_string())?;

    let self_ticket = Ticket::new(peer.address());
    Ok(PeerAdaptor {
        node_address: self_ticket.encode().map_err(|e| e.to_string())?,
        display_name: display_name,
        peer: peer,
    })
}

impl PeerAdaptor {
    #[flutter_rust_bridge::frb(sync)]
    pub fn get_node_address(&self) -> String {
        self.node_address.clone()
    }

    pub async fn listen(
        &self,
        on_received_connection: impl Fn(String) -> DartFnFuture<bool> + 'static + Send,
    ) -> Result<ConnectionAdaptor, String> {
        let mut listener = self.peer.listen().await.map_err(|e| e.to_string())?;
        let my_display_name = self.display_name.clone();

        let (send, recv) = mpsc::channel(1);
        let connection = ConnectionAdaptor {
            _internal_connection: recv,
            connection: None,
        };
        flutter_rust_bridge::spawn(async move {
            while let Ok(Some(mut peer)) = listener.accept().await {
                let my_display_name = my_display_name.clone();
                log::info!("Accepted low level peer connection");

                let call_handshake_optional: Option<CallHandshake> = peer.receive().await.unwrap();
                log::info!("Received the handshake");
                if let Some(handeshake_frame) = call_handshake_optional {
                    match handeshake_frame {
                        CallHandshake::DisplayName(displayname) => {
                            if on_received_connection(displayname).await {
                                log::info!("Send the displayName {}", my_display_name);
                                peer.send(CallHandshake::DisplayName(my_display_name))
                                    .await
                                    .unwrap();
                                send.send(peer).await.unwrap();
                            } else {
                                peer.send(CallHandshake::Rejection).await.unwrap();
                            }
                        }
                        // Ignore others
                        _ => {}
                    }
                }
            }
        });

        Ok(connection)
    }
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    env_logger::init();
    flutter_rust_bridge::setup_default_user_utils();
}
