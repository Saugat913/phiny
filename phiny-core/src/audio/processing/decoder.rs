use anyhow::Context as _;

pub struct Decoder {
    decoder_internal: audiopus::coder::Decoder,
}

impl Decoder {
    pub fn new(sample_rate: u32, channels: u16) -> anyhow::Result<Self> {
        let sample_rate =
            <audiopus::SampleRate as audiopus::TryFrom<i32>>::try_from(sample_rate as i32)
                .context("Error invalid sample rate not supported ")?;
        let channels = <audiopus::Channels as audiopus::TryFrom<i32>>::try_from(channels as i32)
            .context("Invalid channels it support only mono(1) and stereo (2)")?;
        let decoder = audiopus::coder::Decoder::new(sample_rate, channels)?;

        Ok(Self {
            decoder_internal: decoder,
        })
    }

    pub fn decode(&mut self, data: &[u8]) -> anyhow::Result<Vec<i16>> {
        let mut decoded = vec![0i16; 960];
        let decoded_data = self
            .decoder_internal
            .decode(Some(data), &mut decoded, false)?;
        Ok(decoded[..decoded_data].to_vec())
    }
}
