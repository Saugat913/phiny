use anyhow::Result;
use iroh::endpoint::{RecvStream, SendStream};
use tokio::{
    select,
    sync::{mpsc, watch},
};

/// Represents a message that can be sent over the p2p connection
pub trait Message: Send + Sync + 'static {
    fn serialize(&self) -> Result<Vec<u8>>;
    fn deserialize(data: &[u8]) -> Result<Self>
    where
        Self: Sized;
}

/// Represents a p2p connection between two peers
pub struct Connection {
    sender: mpsc::Sender<Vec<u8>>,
    receiver: mpsc::Receiver<Vec<u8>>,
    _close_signal: watch::Sender<bool>,
}

impl Connection {
    pub(crate) fn new(
        send_stream: SendStream,
        recv_stream: RecvStream,
        buffer_size: usize,
    ) -> Self {
        let (sender, mut sender_rx) = mpsc::channel::<Vec<u8>>(buffer_size);
        let (receiver_tx, receiver) = mpsc::channel(buffer_size);
        let (close_tx, close_rx) = watch::channel(false);

        let mut close_rx_cloned = close_rx.clone();
        //Now lets spawn the task for sending and receiving from the network
        //sending loop
        tokio::spawn(async move {
            let mut send_stream = send_stream;
            let mut shutdown_rx = close_rx.clone();
            loop {
                select! {
                 Some(data) = sender_rx.recv()=> {

                    let len = data.len() as u32;

                    if let Err(e) = send_stream.write_all(&len.to_be_bytes()).await {
                        eprintln!("Error while sending message length : {}", e);
                    }

                    if let Err(e) = send_stream.write_all(&data).await {
                        eprintln!("Error while sending the message : {}", e);
                    }
                },
                 _ = shutdown_rx.changed() => break,
                }
            }
        });
        //receiving loop
        tokio::spawn(async move {
            let mut recv_stream = recv_stream;

            loop {
                let mut len_buffer = [0u8; 4];

                select! {
                _ = close_rx_cloned.changed() => break,
                   result= recv_stream.read_exact(&mut len_buffer)=>{
                   match result{
                           Err(e) => {
                              eprintln!("Error while reading the message length : {}", e);
                              break;
                          }
                          Ok(_) => {
                              let len = u32::from_be_bytes(len_buffer) as usize;
                              let mut buffer = vec![0u8; len];

                              match recv_stream.read_exact(buffer.as_mut_slice()).await {
                                  Err(e) => {
                                      eprintln!("Error while reading the message data : {}", e);
                                      break;
                                  }
                                  Ok(_) => {
                                      if receiver_tx.send(buffer).await.is_err() {
                                          // It means receiver channel is dropped and hence connection closed
                                          break;
                                      }
                                  }
                              }
                          }
                              }
                           }
                      }
            }
        });

        Self {
            sender,
            receiver,
            _close_signal: close_tx,
        }
    }

    /// Send a message to the peer
    pub async fn send<M: Message>(&self, message: M) -> Result<()> {
        let data = message.serialize()?;
        self.sender.send(data).await?;
        Ok(())
    }

    /// Receive a message from the peer
    pub async fn receive<M: Message>(&mut self) -> Result<Option<M>> {
        if let Some(data) = self.receiver.recv().await {
            println!("Received at connection level");
            let message = M::deserialize(&data)?;
            Ok(Some(message))
        } else {
            Ok(None) // Connection closed
        }
    }

    pub fn split(self) -> (ConnectionWriter, ConnectionReader) {
        let sender = self.sender;
        let receiver = self.receiver;
        let shutdown = self._close_signal;
        let shutdown_cloned = shutdown.clone();
        (
            ConnectionWriter { sender, shutdown },
            ConnectionReader {
                receiver,
                shutdown: shutdown_cloned,
            },
        )
    }

    /// Close the connection
    pub fn close(self) {
        // Dropping the close_signal will signal the background task to shut down
        let _ = self._close_signal.send(true);
    }
}

pub struct ConnectionWriter {
    sender: mpsc::Sender<Vec<u8>>,
    shutdown: watch::Sender<bool>,
}

pub struct ConnectionReader {
    receiver: mpsc::Receiver<Vec<u8>>,
    shutdown: watch::Sender<bool>,
}

impl ConnectionReader {
    /// Receive a message from the peer
    pub async fn receive<M: Message>(&mut self) -> Result<Option<M>> {
        if let Some(data) = self.receiver.recv().await {
            println!("Received at connection level");
            let message = M::deserialize(&data)?;
            Ok(Some(message))
        } else {
            Ok(None) // Connection closed
        }
    }
}

impl ConnectionWriter {
    /// Send a message to the peer
    pub async fn send<M: Message>(&self, message: M) -> Result<()> {
        let data = message.serialize()?;
        self.sender.send(data).await?;
        Ok(())
    }
}

impl Drop for ConnectionReader {
    fn drop(&mut self) {
        let _ = self.shutdown.send(true);
    }
}

impl Drop for ConnectionWriter {
    fn drop(&mut self) {
        let _ = self.shutdown.send(true);
    }
}
