use iroh::Endpoint;
use iroh::endpoint::{RecvStream, SendStream};

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
                        let (send, recv) = connection.accept_bi().await?;
                        handler(send, recv).await?;
                        anyhow::Ok(())
                    });
                    //Why? we want only one accept only for now;
                    break;
                }
            }
        });
    }
}
