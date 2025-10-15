use clap::Parser;
use log::LevelFilter;
use phiny_core::{
    self,
    audio::{InputDevice, OutputDevice},
};
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
        Commands::Connect { ticket } => {}
        Commands::Listen => {}
    }

    Ok(())
}
