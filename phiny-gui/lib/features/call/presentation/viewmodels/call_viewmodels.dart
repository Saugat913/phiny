import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/call_viewmodels_state.dart';
part 'call_viewmodels.g.dart';

@riverpod
class CallViewModel extends _$CallViewModel {
  Timer? _callTimer;

  @override
  CallViewModelState build() {
    // Cleanup timer when provider is disposed
    ref.onDispose(() {
      _callTimer?.cancel();
    });

    return const CallViewModelState(
      callState: CallViewState.idle,
      callDuration: Duration.zero,
      isMuted: false,
      isSpeakerOn: false,
    );
  }

  void startCall() {
    state = state.copyWith(callState: CallViewState.connecting);

    // Simulate connection delay
    Future.delayed(const Duration(seconds: 2), () {
      if (state.callState == CallViewState.connecting) {
        state = state.copyWith(callState: CallViewState.connected);
        _startCallTimer();
      }
    });
  }

  void _startCallTimer() {
    _callTimer?.cancel();
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.callState == CallViewState.connected) {
        state = state.copyWith(
          callDuration: state.callDuration + const Duration(seconds: 1),
        );
      } else {
        timer.cancel();
      }
    });
  }

  void endCall() {
    _callTimer?.cancel();
    state = state.copyWith(
      callState: CallViewState.idle,
      callDuration: Duration.zero,
    );
  }

  void toggleMute() {
    state = state.copyWith(isMuted: !state.isMuted);
  }

  void toggleSpeaker() {
    state = state.copyWith(isSpeakerOn: !state.isSpeakerOn);
  }
}
