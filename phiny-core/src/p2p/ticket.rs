use data_encoding::BASE32;
use iroh::NodeAddr;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct Ticket {
    pub node_addrs: NodeAddr,
}

impl Ticket {
    pub fn new(node_addr: NodeAddr) -> Self {
        Self {
            node_addrs: node_addr,
        }
    }

    pub fn encode(&self) -> anyhow::Result<String> {
        let jsonified_self = serde_json::to_string(self)?;
        let base32_jsonified_self = BASE32.encode(jsonified_self.as_bytes());
        return Ok(base32_jsonified_self);
    }
    pub fn decode(encoded_data: &str) -> anyhow::Result<Self> {
        let base32_decoded = BASE32.decode(encoded_data.as_bytes())?;
        let decoded_self = serde_json::from_slice(&base32_decoded)?;
        return Ok(decoded_self);
    }
}
