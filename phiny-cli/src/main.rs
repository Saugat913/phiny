use std::sync::Arc;

use anyhow::anyhow;
use bincode::{Decode, Encode};
use clap::Parser;
use log::LevelFilter;

use phiny_core::{
    audio::{
        io::{InputDevice, OutputDevice},
        processing::processor::{InputProcessor, OutputProcessor},
    },
    p2p::{Message, Peer, PeerConfig, Ticket},
};
use tokio::sync::Mutex;
/// Phiny - A simple p2p audio calling application
#[derive(Debug, Parser)]
struct Cli {
    #[clap(subcommand)]
    commands: Commands,
}




#[derive(Debug, Clone, clap::Subcommand)]
enum Commands {
    /// Start the audio call listener
    Listen,

    /// Call the peer using the ticket
    Connect { ticket: String },
}

#[derive(Debug, Encode, Decode)]
struct AudioFrame {
    data: Vec<u8>,
}

impl Message for AudioFrame {
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

#[derive(Debug, Decode, Encode)]
struct TextMessage(String);

impl Message for TextMessage {
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

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    let mut logger = env_logger::Builder::new();
    logger
        .filter(Some("phiny_core::audio"), LevelFilter::Info)
        .init();

    test_listener_and_connector().await?;
    Ok(())
}

async fn test_audio_io_feedback() -> anyhow::Result<()> {
    let mut input_device = InputDevice::new()?;
    let mut output_device = OutputDevice::new()?;

    input_device.init()?;
    output_device.init()?;

    while let Some(data) = input_device.receive().await {
        output_device.send(data).await?;
    }

    Ok(())
}

async fn test_p2p_data_transfer() -> anyhow::Result<()> {
    let cli = Cli::parse();
    match cli.commands {
        Commands::Connect { ticket } => {
            let peer = Peer::new(PeerConfig::default()).await?;
            let ticket = Ticket::decode(&ticket)?;
            let mut connection = peer.connect(ticket.node_addrs.clone()).await?;

            println!("Connected to peer {}", ticket.node_addrs.node_id);
            let text_message: Option<TextMessage> = connection.receive().await?;
            match text_message {
                None => {}
                Some(msg) => {
                    println!("Received from listener:{}", msg.0);
                }
            }
            connection
                .send(TextMessage("I am connector".to_string()))
                .await?;
            tokio::signal::ctrl_c().await?;
        }
        Commands::Listen => {
            let peer = Peer::new(PeerConfig::default()).await?;
            let mut listener = peer.listen().await?;
            let self_ticket = Ticket::new(peer.address());

            println!(
                "🎟️ Share this ticket with your peer:\n{}",
                self_ticket.encode()?
            );

            if let Some(mut connection) = listener.accept().await? {
                println!("Peer connected!");
                connection
                    .send(TextMessage("I am listener".to_string()))
                    .await?;
                println!("Sent the message");

                let text_message: Option<TextMessage> = connection.receive().await?;
                match text_message {
                    None => {
                        println!("Received none");
                    }
                    Some(msg) => {
                        println!("Received from connector:{}", msg.0);
                    }
                }
            }
            tokio::signal::ctrl_c().await?;
        }
    }

    Ok(())
}

async fn test_listener_and_connector() -> anyhow::Result<()> {
    let cli = Cli::parse();

    match cli.commands {
        Commands::Connect { ticket } => {
            let peer = Peer::new(PeerConfig::default()).await?;
            let ticket = Ticket::decode(&ticket)?;
            let connection = peer.connect(ticket.node_addrs.clone()).await?;

            println!("Connected to peer {}", ticket.node_addrs.node_id);
            let input_device = Arc::new(Mutex::new(InputDevice::new()?));
            let mut processor = InputProcessor::new(48000, 1)?;

            let mut input_device = input_device.lock().await;
            if let Err(e) = input_device.init() {
                return Err(anyhow!("Input init error: {}", e));
            }

            while let Some(data) = input_device.receive().await {
                match processor.process_stream(&data) {
                    Ok(processed_data) => {
                        if let Err(e) = connection
                            .send(AudioFrame {
                                data: processed_data,
                            })
                            .await
                        {
                            eprintln!("Send error: {}", e);
                            break;
                        }
                    }
                    Err(e) => eprintln!("Processing error: {}", e),
                }
            }

            tokio::signal::ctrl_c().await?;
        }

        Commands::Listen => {
            let peer = Peer::new(PeerConfig::default()).await?;
            let mut listener = peer.listen().await?;
            let self_ticket = Ticket::new(peer.address());

            println!(
                "🎟️ Share this ticket with your peer:\n{}",
                self_ticket.encode()?
            );

            let output_device = Arc::new(Mutex::new(OutputDevice::new()?));

            if let Some(mut connection) = listener.accept().await? {
                println!("Peer connected!");

                let mut processor = OutputProcessor::new(48000, 1)?;
                let output_device = Arc::clone(&output_device);

                tokio::spawn(async move {
                    let mut output_device = output_device.lock().await;
                    if let Err(e) = output_device.init() {
                        eprintln!("Output init error: {}", e);
                        return;
                    }

                    while let Ok(Some(bytes)) = connection.receive::<AudioFrame>().await {
                        println!("Get processed data to output device");
                        match processor.process_stream(&bytes.data) {
                            Ok(processed) => {
                                if let Err(e) = output_device.send(processed).await {
                                    eprintln!("Output send error: {}", e);
                                    break;
                                }
                            }
                            Err(e) => eprintln!("Processing error: {}", e),
                        }
                    }
                });

                tokio::signal::ctrl_c().await?;
            }
        }
    }

    Ok(())
}
