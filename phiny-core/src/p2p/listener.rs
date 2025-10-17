use iroh::endpoint::{RecvStream, SendStream};
use iroh::{Endpoint, NodeAddr};

use crate::p2p::Ticket;

use super::ALPN;

pub struct Listener {
    endpoint: Endpoint,
}

impl Listener {
    pub async fn init() -> anyhow::Result<Self> {
        let endpoint = Endpoint::builder()
            .discovery_n0()
            .alpns(vec![ALPN.to_vec()])
            .bind()
            .await?;

        return Ok(Self { endpoint: endpoint });
    }

    pub async fn listen<F, Fut>(&self, handler: F)
    where
        F: FnOnce(SendStream, RecvStream) -> Fut + Send + Sync + 'static,
        Fut: std::future::Future<Output = anyhow::Result<()>> + Send + Sync + 'static,
    {
        tokio::spawn({
            let endpoint = self.endpoint.clone();
            let handler = handler;
            async move {
                while let Some(incoming) = endpoint.accept().await {
                    let handler = handler;
                    tokio::spawn(async move {
                        let connection = incoming.await?;
                        let (send, mut recv) = connection.accept_bi().await?;
                        let mut handshake = [0u8; 1];
                        recv.read_exact(&mut handshake).await?;
                        handler(send, recv).await?;
                        anyhow::Ok(())
                    });
                    //Why? we want only one accept only for now;
                    break;
                }
            }
        });
    }

    pub fn node_addr(&self) -> NodeAddr {
        self.endpoint.node_addr()
    }
    pub fn get_ticket(&self) -> Ticket {
        let ticket = Ticket::new(self.node_addr());
        return ticket;
    }
}
