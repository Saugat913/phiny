use std::io::{self, Write};
use std::sync::Arc;
use tokio::sync::Mutex;
use tokio::time::Duration;

use anyhow::anyhow;
use clap::Parser;

use phiny_core::CallManager;
use phiny_core::CallSession;

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
    let cli = Cli::parse();

    // Prompt for display name
    print!("Enter your display name: ");
    io::stdout().flush()?;
    let mut display_name = String::new();
    io::stdin().read_line(&mut display_name)?;
    let display_name = display_name.trim().to_string();
    if display_name.is_empty() {
        return Err(anyhow!("Display name cannot be empty."));
    }

    match cli.commands {
        Commands::Listen => {
            println!("📞 Listening for calls... Share your ticket with a friend to get started.");

            // This callback is executed when an incoming call is received.
            let on_call_received = async |caller_name: String| {
                print!("Incoming call from '{}'. Accept? (y/n): ", caller_name);
                io::stdout().flush().unwrap();
                let mut input = String::new();
                io::stdin().read_line(&mut input).unwrap();
                let input = input.trim().to_lowercase();
                input == "y" || input == "yes"
            };

            // This callback is executed if the user accepts the call.
            let on_call_accepted = async |call_session: CallSession| {
                println!("✅ Call accepted!");
                // Spawn a task to manage the call session's lifecycle.
                tokio::spawn(async move {
                    println!("🎙️ Call in progress. Press Ctrl+C to end the call.");
                    // Wait for the user to signal the end of the call.
                    if let Err(e) = tokio::signal::ctrl_c().await {
                        eprintln!("Failed to listen for ctrl_c signal: {}", e);
                    }
                    println!("Ending call...");
                    // End the call session.
                    call_session.end().await;
                    println!("Call ended. The application is still listening for new calls.");
                });
            };

            // Initialize the CallManager, which starts listening in the background.
            let _call_manager =
                CallManager::initialize(display_name, on_call_received, on_call_accepted).await?;

            println!("Ticket:{}", _call_manager.get_ticket()?);
            // The main function now just waits for a Ctrl+C to exit the entire application.
            println!("Press Ctrl+C to exit the application.");
            tokio::signal::ctrl_c().await?;
            println!("Exiting application.");
        }
        Commands::Connect { ticket } => {
            println!("📞 Calling peer...");

            // Use a shared flag to signal when the call attempt is finished.
            let is_call_finished = Arc::new(Mutex::new(false));

            // Clone the Arc for the 'accepted' callback.
            let is_call_finished_for_accept = is_call_finished.clone();
            let on_call_accepted = {
                move |call_session: CallSession| {
                    let is_call_finished_task = is_call_finished_for_accept.clone();

                    async move {
                        println!("✅ Call accepted!");
                        // Clone the Arc again for the new task.
                        let is_call_finished_task = is_call_finished_task.clone();
                        tokio::spawn(async move {
                            println!("🎙️ Call in progress. Press Ctrl+C to end the call.");
                            tokio::signal::ctrl_c().await.ok(); // Ignore error on shutdown
                            println!("Ending call...");
                            call_session.end().await;
                            println!("Call ended.");
                            // Signal that the call is finished.
                            *is_call_finished_task.lock().await = true;
                        });
                    }
                }
            };

            // Clone the Arc for the 'rejected' callback.
            let is_call_finished_for_reject = is_call_finished.clone();
            let on_call_rejected = {
                move || {
                    let is_call_finished_for_reject = is_call_finished_for_reject.clone();
                    async move {
                        println!("❌ Call was rejected or the peer is busy.");
                        let is_call_finished_clone = is_call_finished_for_reject.clone();
                        tokio::spawn(async move {
                            // Signal that the call attempt is finished.
                            *is_call_finished_clone.lock().await = true;
                        });
                    }
                }
            };

            // We need to initialize the CallManager to get an instance.
            let call_manager = CallManager::initialize(
                display_name.clone(),
                async |_caller_name| false, // Reject all incoming calls while we are trying to make an outbound one.
                async |_call_session| {},   // No-op for accepted calls.
            )
            .await?;

            // Now, make the outbound call.
            if let Err(e) = call_manager
                .call(ticket, on_call_accepted, on_call_rejected)
                .await
            {
                eprintln!("Failed to initiate call: {}", e);
                // If the call itself fails, we also mark it as finished.
                *is_call_finished.lock().await = true;
            }

            // Wait until the call is finished (either rejected or completed).
            println!("Waiting for call to complete or be rejected...");
            while !*is_call_finished.lock().await {
                tokio::time::sleep(Duration::from_millis(100)).await;
            }
            println!("Exiting.");
        }
    }

    Ok(())
}
