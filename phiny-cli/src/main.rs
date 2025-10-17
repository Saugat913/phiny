use std::sync::Arc;

use bytemuck::cast_slice;
use clap::Parser;
use log::LevelFilter;
use phiny_core::{
    self,
    audio::io::{InputDevice, OutputDevice},
    p2p::{Connector, Listener, Ticket},
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

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    let mut logger = env_logger::Builder::new();
    logger.filter_level(LevelFilter::Info).build();

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

async fn test_listener_and_connector() -> anyhow::Result<()> {
    let cli = Cli::parse();

    match cli.commands {
        Commands::Connect { ticket } => {
            let ticket = Ticket::decode(&ticket)?;
            let connector = Connector::init().await?;

            let input_device = Arc::new(Mutex::new(InputDevice::new()?));

            connector
                .connect(ticket.node_addrs.clone(), async move |mut sender, _| {
                    let mut input_device = input_device.lock().await;
                    input_device.init()?;

                    println!("Connected to node {}", ticket.node_addrs.node_id);

                    while let Some(data) = input_device.receive().await {
                        // Send audio data over network
                        sender.write_all(cast_slice(&data)).await?;
                    }
                    anyhow::Ok(())
                })
                .await?;

            tokio::signal::ctrl_c().await?;
        }
        Commands::Listen => {
            let listener = Listener::init().await?;
            let ticket = listener.get_ticket();

            println!("Ticket: {}", ticket.encode()?);

            let output_device = Arc::new(Mutex::new(OutputDevice::new()?));

            listener
                .listen(async move |_, mut receiver| {
                    let mut output_device = output_device.lock().await;
                    output_device.init()?;

                    // Network receive buffer
                    let mut buffer = [0u8; 4096]; // Larger buffer for efficiency

                    while let Ok(Some(mut bytes_read)) = receiver.read(&mut buffer).await {
                        if bytes_read == 0 {
                            break; // Connection closed
                        }

                        // For now lets just make buffer mod 4 forcefully
                        bytes_read = bytes_read - (bytes_read % 4);

                        output_device
                            .send(cast_slice(&buffer[..bytes_read]).to_vec())
                            .await?;
                    }

                    anyhow::Ok(())
                })
                .await;

            tokio::signal::ctrl_c().await?;
        }
    }

    Ok(())
}
