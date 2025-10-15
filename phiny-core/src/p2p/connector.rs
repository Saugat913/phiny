use super::ALPN;
use iroh::{
    Endpoint, NodeAddr,
    endpoint::{RecvStream, SendStream},
};

pub struct Connector {
    endpoint: Endpoint,
}

impl Connector {
    pub async fn init() -> anyhow::Result<Self> {
        let endpoint = Endpoint::builder().discovery_n0().bind().await?;
        Ok(Self { endpoint: endpoint })
    }

    pub async fn connect<F, Fut>(&self, addr: NodeAddr, handler: F) -> anyhow::Result<()>
    where
        F: FnOnce(SendStream, RecvStream) -> Fut,
        Fut: std::future::Future<Output = anyhow::Result<()>>,
    {
        let conn = self.endpoint.connect(addr, ALPN).await?;
        let (mut send, recv) = conn.open_bi().await?;
        // Here connection side should first send data
        send.write_all(b"!").await?;
        handler(send, recv).await?;

        conn.close(0u32.into(), b"bye!");
        Ok(())
    }

    pub async fn destroy(self) {
        self.endpoint.close().await;
    }
}
