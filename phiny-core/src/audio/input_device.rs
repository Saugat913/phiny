use log::{info, warn};
use tokio::sync::mpsc::{self, Receiver};

use anyhow::Context;
use cpal::{
    Device, Stream, SupportedStreamConfig,
    traits::{DeviceTrait, HostTrait, StreamTrait},
};

pub struct InputDevice {
    device: Device,
    config: SupportedStreamConfig,
    receiver: Option<Receiver<Vec<f32>>>,
    stream: Option<Stream>,
}

impl InputDevice {
    pub fn new() -> anyhow::Result<Self> {
        let host = cpal::default_host();
        let device = host
            .default_input_device()
            .context("No input device is available")?;
        let config = device.default_input_config()?;

        Ok(Self {
            device: device,
            config: config,
            receiver: None,
            stream: None,
        })
    }

    pub fn init(&mut self) -> anyhow::Result<()> {
        let (stream_tx, stream_rx) = mpsc::channel::<Vec<f32>>(50);
        let config = self.config.clone().into();

        let stream = self.device.build_input_stream(
            &config,
            move |data: &[f32], _: &cpal::InputCallbackInfo| {
                info!("[Input device]:{}", data.len());
                stream_tx.blocking_send(data.to_vec()).unwrap();
            },
            move |err| {
                warn!("Error occured at input audio device stream: {}", err);
            },
            None,
        )?;

        stream.play()?;

        self.stream = Some(stream);
        self.receiver = Some(stream_rx);
        Ok(())
    }

    pub async fn receive(&mut self) -> Option<Vec<f32>> {
        if let Some(receiver) = self.receiver.as_mut() {
            if let Some(data) = receiver.recv().await {
                return Some(data);
            }
        }
        return None;
    }
}
