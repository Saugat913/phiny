import 'package:freezed_annotation/freezed_annotation.dart';
part 'call_viewmodels_state.freezed.dart';

enum CallViewState { connecting, connected, idle }

@freezed
abstract class CallViewModelState with _$CallViewModelState {
  const factory CallViewModelState({
    required CallViewState callState,
    required Duration callDuration,
    required bool isMuted,
    required bool isSpeakerOn,
  }) = _CallViewModelState;
}
