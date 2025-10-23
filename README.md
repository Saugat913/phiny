# Phiny

A minimal peer‑to‑peer audio call prototype using Rust and iroh. Includes a CLI for starting a listener and connecting via a shared ticket.

## Features
- Peer-to-peer connection using `iroh`
- Simple handshake (`PHINY_HANDSHAKE_V1`) for stream setup
- CLI with `listen` and `connect <ticket>` commands
- Audio input/output processing utilities present in core 

## Project Layout
- `phiny-core`: Core library (audio IO/processing, P2P primitives)
- `phiny-cli`: CLI tool for testing P2P connections and simple calls


## Build
- Requires Rust (`cargo`)
- Build the workspace:
  - `cargo build`
- Build CLI only:
  - `cargo build -p phiny-cli`

## Run
- Start listener (prints a ticket to share):
  - `cargo run -p phiny-cli -- listen`
- Connect to a listener using the ticket:
  - `cargo run -p phiny-cli -- connect <ticket>`

Notes:
- Run the listener first, copy the printed ticket, then start the connector.

## Usage Example
1. In terminal A:
   - `cargo run -p phiny-cli -- listen`
   - Copy the printed ticket
2. In terminal B:
   - `cargo run -p phiny-cli -- connect <ticket>`


## Implementation Details
- P2P:
  - `phiny-core::p2p::Peer` handles listen/connect
  - `Connection` wraps `iroh` send/recv streams with length-prefixed messages
- CLI:
  - `listen`: accepts connection, prints ticket, exchanges messages
  - `connect`: connects using provided ticket, exchanges messages
- Audio:
  - `phiny-core::audio::io` and `processing` exist for capture/playback

## TODO
- Add a clean `AudioSession` interface for multi-participant calls
- Per-participant controls (mute, volume) and simple mixer
- Resilience: reconnection and session state handling
- Documentation for audio device setup across platforms