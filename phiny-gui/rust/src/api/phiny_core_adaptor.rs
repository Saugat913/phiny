use flutter_rust_bridge::DartFnFuture;
use phiny_core::{call::CallManager, CallSession};
use std::sync::Arc;

pub struct CallManagerAdaptor {
    call_manager: CallManager,
}

pub struct CallSessionAdaptor {
    call_session: CallSession,
}

impl CallManagerAdaptor {
    pub async fn initialize(
        display_name: String,
        on_call_received: impl Fn(String) -> DartFnFuture<bool> + 'static + Send + Sync,
        on_call_accepted: impl Fn(CallSessionAdaptor) -> DartFnFuture<bool> + 'static + Send + Sync,
    ) -> Result<CallManagerAdaptor, String> {
        // This callback is executed when an incoming call is received.
        let on_call_received_callback = Arc::new(on_call_received);
        let on_call_accepted_callback = Arc::new(on_call_accepted);

        let call_manager = CallManager::initialize(
            display_name,
            {
                move |caller_name: String| {
                    let cb = on_call_received_callback.clone();
                    // call the Dart callback, return its future
                    async move { cb(caller_name).await }
                }
            },
            {
                let cb = on_call_accepted_callback.clone();
                move |session: CallSession| {
                    // Move `cb` into the async block.
                    let call_session_adaptor = CallSessionAdaptor {
                        call_session: session,
                    };
                    let cb2 = cb.clone();
                    async move {
                        cb2(call_session_adaptor).await;
                    }
                }
            },
        )
        .await
        .map_err(|e| e.to_string())?;
        Ok(CallManagerAdaptor { call_manager })
    }

    pub async fn call(
        &self,
        ticket: String,
        on_call_accepted: impl Fn(CallSessionAdaptor) -> DartFnFuture<bool> + 'static + Send + Sync,
        on_call_rejected: impl Fn() -> DartFnFuture<bool> + 'static + Send + Sync,
    ) {
        let on_call_accepted_callback = Arc::new(on_call_accepted);
        let on_call_rejected_callback = Arc::new(on_call_rejected);

        self.call_manager.call(
            ticket,
            {
                let cb = on_call_accepted_callback.clone();
                move |session: CallSession| {
                    // Move `cb` into the async block.
                    let call_session_adaptor = CallSessionAdaptor {
                        call_session: session,
                    };
                    let cb2 = cb.clone();
                    async move {
                        cb2(call_session_adaptor).await;
                    }
                }
            },
            {
                move || {
                    let cb = on_call_rejected_callback.clone();
                    // call the Dart callback, return its future
                    async move {
                        cb().await;
                    }
                }
            },
        );
    }

    #[flutter_rust_bridge::frb(sync)]
    pub fn get_node_address(&self) -> anyhow::Result<String> {
        self.call_manager.get_ticket()
    }
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    // env_logger::init();
    flutter_rust_bridge::setup_default_user_utils();
}
