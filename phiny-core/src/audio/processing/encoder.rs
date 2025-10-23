use anyhow::Context;
use audiopus::coder;
pub struct Encoder {
    encoder_internal: coder::Encoder,
}

impl Encoder {
    pub fn new(sample_rate: u32, channels: u16) -> anyhow::Result<Self> {
        let sample_rate =
            <audiopus::SampleRate as audiopus::TryFrom<i32>>::try_from(sample_rate as i32)
                .context("Error invalid sample rate not supported ")?;
        let channels = <audiopus::Channels as audiopus::TryFrom<i32>>::try_from(channels as i32)
            .context("Invalid channels it support only mono(1) and stereo (2)")?;
        let internal_encoder =
            coder::Encoder::new(sample_rate, channels, audiopus::Application::Voip)?;

        Ok(Self {
            encoder_internal: internal_encoder,
        })
    }

    pub fn encode(&self, data: &[i16]) -> anyhow::Result<Vec<u8>> {
        let mut encoded = vec![0u8; 4000];
        let encoded_size = self.encoder_internal.encode(data, &mut encoded)?;
        Ok(encoded[..encoded_size].to_vec())
    }
}
