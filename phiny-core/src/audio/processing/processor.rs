use anyhow::Context;
use bincode::Decode;
use bincode::Encode;
use std::i16;

use super::decoder;
use super::encoder;

// =================================== Utility for translation ==========================
fn convert_f32_sample_to_i16(data: &[f32]) -> Vec<i16> {
    return data
        .iter()
        .map(|sample| {
            // This ensure the amplitude is between -1 and 1
            let clamped = sample.clamp(-1.0, 1.0);
            // convert -1 to 1 range upto i16::MAX range
            return (clamped * i16::MAX as f32) as i16;
        })
        .collect();
}

fn convert_i16_sample_to_f32(data: &[i16]) -> Vec<f32> {
    return data
        .iter()
        .map(|&sample| sample as f32 / i16::MAX as f32)
        .collect();
}

#[derive(Debug, Encode, Decode)]
pub struct AudioFrame {
    pub sequence_number: u32,
    pub samples: Vec<u8>,
}

impl AudioFrame {
    fn new(sequence_number: u32, samples: Vec<u8>) -> Self {
        Self {
            sequence_number: sequence_number,
            samples: samples,
        }
    }
    fn encode(&self) -> anyhow::Result<Vec<u8>> {
        let self_encoded = bincode::encode_to_vec(self, bincode::config::standard())?;
        return Ok(self_encoded);
    }

    fn decode(data: &[u8]) -> anyhow::Result<Self> {
        let self_decoded = bincode::borrow_decode_from_slice(data, bincode::config::standard())?.0;
        return Ok(self_decoded);
    }
}

pub struct InputProcessor {
    encoder: encoder::Encoder,
    sequence_number: u32,
}
pub struct OutputProcessor {
    decoder: decoder::Decoder,
}

impl InputProcessor {
    pub fn new(sample_rate: u32, channels: u16) -> anyhow::Result<Self> {
        let encoder = encoder::Encoder::new(sample_rate, channels)?;

        return Ok(Self {
            encoder: encoder,
            sequence_number: 0,
        });
    }

    //TODO: implement proper webrtc-audio processing
    // For now we just convert to i16 format and encode using opus encoder and return
    pub fn process_stream(&mut self, data: &[f32]) -> anyhow::Result<Vec<u8>> {
        let i16_converted_data = convert_f32_sample_to_i16(data);
        let encoded_data = self
            .encoder
            .encode(&i16_converted_data)
            .context("Error while encoding the mic input")?;
        let audio_frame = AudioFrame::new(self.sequence_number, encoded_data);
        self.sequence_number = self.sequence_number + 1;
        return audio_frame.encode();
    }
}
impl OutputProcessor {
    pub fn new(sample_rate: u32, channels: u16) -> anyhow::Result<Self> {
        let decoder = decoder::Decoder::new(sample_rate, channels)?;
        return Ok(Self { decoder: decoder });
    }

    pub fn process_stream(&mut self, data: &[u8]) -> anyhow::Result<Vec<f32>> {
        // This function expect to get the full encoded data for decoding
        let audio_frame_decoded = AudioFrame::decode(data)?;
        let decoded_data = self.decoder.decode(&audio_frame_decoded.samples)?;
        let f32_converted_data = convert_i16_sample_to_f32(&decoded_data);
        return Ok(f32_converted_data);
    }
}
