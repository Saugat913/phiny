use bincode::{Decode, Encode};

use crate::{
    audio::{
        io::{InputDevice, OutputDevice},
        processing::processor::{InputProcessor, OutputProcessor},
    },
    p2p::{Connection, Message},
};

// Represent the dto of the audio data
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

pub struct CallSession {}

impl CallSession {
    // Take the low level peer connection
    // internally start audio devive and processor
    pub async fn start(connection: Connection) -> anyhow::Result<CallSession> {
        println!("Created the processor");

        let (writer, mut reader) = connection.split();

        tokio::spawn(async move {
            let mut output_device = OutputDevice::new()?;
            println!("Output device created");

            output_device.init()?;
            println!("Output device initialized");

            let mut processor = OutputProcessor::new(48000, 1)?;

            while let Some(data) = reader.receive::<AudioFrame>().await? {
                match processor.process_stream(&data.data) {
                    Ok(processed) => {
                        println!("Get processed data to output device");
                        if let Err(e) = output_device.send(processed).await {
                            eprintln!("Output send error: {}", e);
                            break;
                        }
                    }
                    Err(e) => eprintln!("Processing error: {}", e),
                }
            }

            anyhow::Ok(())
        });

        tokio::spawn(async move {
            let mut input_device = InputDevice::new()?;
            println!("Created the input device");

            input_device.init()?;
            println!("Input device initialized");

            let mut processor = InputProcessor::new(48000, 1)?;

            while let Some(data) = input_device.receive().await {
                match processor.process_stream(&data) {
                    Ok(processed_data) => {
                        if let Err(e) = writer
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

            anyhow::Ok(())
        });
        Ok(CallSession {})
    }

    pub async fn mute_me(&self) {
        // let mut muted = self.is_muted.lock().await;
        // *muted = true;
    }

    pub async fn unmute_me(&self) {
        // let mut muted = self.is_muted.lock().await;
        // *muted = false;
    }

    pub async fn toggle_mute(&self) -> bool {
        // let mut muted = self.is_muted.lock().await;
        // *muted = !*muted;
        // *muted
        true
    }

    pub async fn is_muted(&self) -> bool {
        // let muted = self.is_muted.lock().await;
        // *muted
        true
    }

    pub async fn end(self) {
        // Mark the call as inactive, which will cause the spawned tasks to exit
        // let mut active = self.is_active.lock().await;
        // *active = false;

        // // Close the connection
        // let connection = self.connection.lock().await;

        // Note: The Connection struct would need a close method
        // For now, we'll just drop it when it goes out of scope
    }
}
