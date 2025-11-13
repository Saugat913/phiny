import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/call_viewmodels_state.dart';
part 'call_viewmodels.g.dart';

@riverpod
class CallViewModel extends _$CallViewModel {
  @override
  CallViewModelState build() {
    return CallViewModelState(
      callState: CallViewState.ringing,
      callDuration: Duration.zero,
      isMuted: false,
      isSpeakerOn: false,
    );
  }

  void acceptCall() {
    state = state.copyWith(callState: CallViewState.connecting);

    // Simulate connection delay
    Future.delayed(const Duration(seconds: 1), () {
      state = state.copyWith(callState: CallViewState.connected);
      _startCallTimer();
    });
  }

  void _startCallTimer() {
    // Implementation for call timer
  }

  void endCall() {
    // Implementation for ending call
  }

  void toggleMute() {
    state = state.copyWith(isMuted: !state.isMuted);
  }

  void toggleSpeaker() {
    state = state.copyWith(isSpeakerOn: !state.isSpeakerOn);
  }
}
