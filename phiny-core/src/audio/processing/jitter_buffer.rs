/*
What is jitter buffer? It is the buffering mechanism which store the frame of about specified time and rearrange it
and push to playback
*/

use std::collections::BTreeMap;

//Temporary packet type for internal usage
struct JitterBufferPacket {}
pub struct JitterBuffer {
    buffer: BTreeMap<u32, JitterBufferPacket>,
}
