use log::{info, warn};
use tokio::sync::broadcast::{self, Sender};

use anyhow::Context;
use cpal::{
    Device, Stream, SupportedStreamConfig,
    traits::{DeviceTrait, HostTrait, StreamTrait},
};

//  Mic → Capture Buffer → Frame Buffer(Encoder buffer) → Send Queue → Network Socket
//          |-> Provided by CPAL
//                              |-> TODO: Implement for encoder and framing(implement in audio processing)
//                                                          |-> Channel we use to transfer data to external module(TODO: Use ring buffer for effieciency)

pub struct InputDevice {
    device: Device,
    config: SupportedStreamConfig,
    // Why sender stored at broadcast ? Because it can be cloned and can retreive receiver from sender
    // just using sender.subscribe()
    sender: Option<Sender<Vec<f32>>>,
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
            sender: None,
            stream: None,
        })
    }

    pub fn init(&mut self) -> anyhow::Result<()> {
        if self.stream.is_some() {
            return Ok(());
        }
        let (stream_tx, _) = broadcast::channel::<Vec<f32>>(50);
        let config = self.config.clone().into();

        let stream_tx_cloned = stream_tx.clone();
        let stream = self.device.build_input_stream(
            &config,
            move |data: &[f32], _: &cpal::InputCallbackInfo| {
                info!("[Input device]:{}", data.len());
                stream_tx_cloned.send(data.to_vec()).unwrap();
            },
            move |err| {
                warn!("Error occured at input audio device stream: {}", err);
            },
            None,
        )?;

        stream.play()?;

        self.stream = Some(stream);
        self.sender = Some(stream_tx);
        Ok(())
    }

    pub async fn receive(&mut self) -> Option<Vec<f32>> {
        if let Some(sender) = self.sender.as_ref() {
            let mut receiver = sender.subscribe();
            if let Ok(data) = receiver.recv().await {
                return Some(data);
            }
        }
        return None;
    }
}
