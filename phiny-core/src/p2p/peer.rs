use super::ALPN;
use crate::p2p::connection::Connection;
use anyhow::{Context as _, Result};
use iroh::{Endpoint, NodeAddr};
use tokio::sync::{mpsc, oneshot};

#[derive(Debug, Clone)]
pub struct PeerConfig {
    pub buffer_size: usize,
    pub max_connections: usize,
}

impl Default for PeerConfig {
    fn default() -> Self {
        PeerConfig {
            buffer_size: 40,
            max_connections: 1,
        }
    }
}

/// Represents a peer in the p2p network
pub struct Peer {
    endpoint: Endpoint,
    config: PeerConfig,
}

impl Peer {
    /// Create a new peer with the given configuration
    pub async fn new(config: PeerConfig) -> Result<Self> {
        let endpoint = Endpoint::builder()
            .discovery_n0()
            .alpns(vec![super::ALPN.to_vec()])
            .bind()
            .await?;

        Ok(Self { endpoint, config })
    }

    /// Get the address of this peer
    pub fn address(&self) -> NodeAddr {
        self.endpoint.node_addr()
    }

    /// Connect to another peer
    pub async fn connect(&self, addr: NodeAddr) -> Result<Connection> {
        let conn = self
            .endpoint
            .connect(addr, ALPN)
            .await
            .context("Failed to connect to peer")?;

        let (mut send, recv) = conn
            .open_bi()
            .await
            .context("Failed to open bidirectional stream")?;

        send.write_all(b"PHINY_HANDSHAKE_V1")
            .await
            .context("Failed to send handshake")?;

        Ok(Connection::new(send, recv, self.config.buffer_size))
    }

    /// Listen for incoming connections
    pub async fn listen(&self) -> Result<ConnectionListener> {
        let (connections_tx, connections_rx) = mpsc::channel(self.config.max_connections);
        let (close_tx, mut close_rx) = oneshot::channel();

        // Clone the endpoint for the background task
        let endpoint = self.endpoint.clone();
        let buffer_size = self.config.buffer_size;

        // Spawn a task to accept incoming connections
        tokio::spawn(async move {
            loop {
                tokio::select! {
                    Some(incoming) = endpoint.accept() => {
                        let connections_tx = connections_tx.clone();

                        tokio::spawn(async move {
                            match incoming.await {
                                Ok(connection) => {
                                    // Accept a bidirectional stream
                                    match connection.accept_bi().await {
                                        Ok((send, mut recv)) => {
                                            let mut handshake = [0u8; 18]; // "PHINY_HANDSHAKE_V1"
                                            match recv.read_exact(&mut handshake).await {
                                                Ok(_) => {
                                                    // Create a Connection object
                                                    let connection = Connection::new(send, recv, buffer_size);

                                                    // Send the connection through the channel
                                                    if connections_tx.send(Ok(connection)).await.is_err() {
                                                        // Channel closed, listener was dropped
                                                        return;
                                                    }
                                                },
                                                Err(e) => {
                                                    // Failed to read handshake
                                                    let _ = connections_tx.send(Err(anyhow::anyhow!("Failed to read handshake: {}", e))).await;
                                                }
                                            }
                                        },
                                        Err(e) => {
                                            // Failed to accept bidirectional stream
                                            let _ = connections_tx.send(Err(anyhow::anyhow!("Failed to accept bidirectional stream: {}", e))).await;
                                        }
                                    }
                                },
                                Err(e) => {
                                    // Failed to accept connection
                                    let _ = connections_tx.send(Err(anyhow::anyhow!("Failed to accept connection: {}", e))).await;
                                }
                            }
                        });
                    },
                    _ = &mut close_rx => {
                        break;
                    }
                }
            }
        });

        Ok(ConnectionListener {
            connections: connections_rx,
            _close_signal: close_tx,
        })
    }
}

/// Listener for incoming connections
pub struct ConnectionListener {
    connections: mpsc::Receiver<Result<Connection>>,
    _close_signal: oneshot::Sender<()>,
}

impl ConnectionListener {
    /// Accept the next incoming connection
    pub async fn accept(&mut self) -> Result<Option<Connection>> {
        match self.connections.recv().await {
            Some(result) => result.map(Some),
            None => Ok(None),
        }
    }

    /// Stop listening for connections
    pub fn close(self) {
        // Dropping the close_signal will signal the background task to shut down
    }
}
