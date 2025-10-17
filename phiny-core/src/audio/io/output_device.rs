use log::{info, warn};
use tokio::sync::mpsc::{self, Sender};

use anyhow::{Context, anyhow};
use cpal::{
    Device, Stream, SupportedStreamConfig,
    traits::{DeviceTrait, HostTrait, StreamTrait},
};

//  Network Socket → Jitter Buffer → (Decoder Buffer if needed) → Output Device
//                      |->TODO: Rearranging buffer according to timestamp
//                                          |-> TODO: Decoder buffer (implement it in audio processing)
pub struct OutputDevice {
    device: Device,
    config: SupportedStreamConfig,
    sender: Option<Sender<Vec<f32>>>,
    stream: Option<Stream>,
}

impl OutputDevice {
    pub fn new() -> anyhow::Result<Self> {
        let host = cpal::default_host();
        let device = host
            .default_output_device()
            .context("No output device is available")?;
        let config = device.default_output_config()?;

        Ok(Self {
            device: device,
            config: config,
            sender: None,
            stream: None,
        })
    }

    pub fn init(&mut self) -> anyhow::Result<()> {
        let (stream_tx, mut stream_rx) = mpsc::channel::<Vec<f32>>(50);
        let config = self.config.clone().into();

        let stream = self.device.build_output_stream(
            &config,
            move |data: &mut [f32], _: &cpal::OutputCallbackInfo| {
                if let Ok(received_data) = stream_rx.try_recv() {
                    info!("[Output device]:{}", received_data.len());
                    for (sample, data) in data.iter_mut().zip(received_data) {
                        *sample = data;
                    }
                }
            },
            move |err| {
                warn!("Error occured at output audio device stream: {}", err);
            },
            None,
        )?;
        stream.play()?;

        self.stream = Some(stream);
        self.sender = Some(stream_tx);
        Ok(())
    }

    pub async fn send(&mut self, data: Vec<f32>) -> anyhow::Result<()> {
        if let Some(sender) = self.sender.as_ref() {
            sender.send(data).await?;
            return Ok(());
        }
        Err(anyhow!("Output device is not initialized"))
    }
}
