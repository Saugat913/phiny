import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:phiny_gui/features/call/presentation/viewmodels/call_viewmodels.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:phiny_gui/features/profile/presentation/providers/profile_notifier.dart';
import 'package:phiny_gui/src/rust/api/phiny_core_adaptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_provider.freezed.dart';
part 'app_provider.g.dart';

@freezed
abstract class IncomingCallDecisionState with _$IncomingCallDecisionState {
  const factory IncomingCallDecisionState({
    required Completer<bool>? completer,
    required AudioPlayer audioPlayer,
    required String? targetName,
  }) = _IncomingCallDecisionState;
}

@riverpod
class IncomingCallDecision extends _$IncomingCallDecision {
  @override
  IncomingCallDecisionState build() {
    return IncomingCallDecisionState(
      completer: null,
      audioPlayer: AudioPlayer(),
      targetName: null,
    );
  }

  Future<void> setCompleter(
    Completer<bool> completer, {
    String? targetName,
  }) async {
    await state.audioPlayer.play(AssetSource("ringtone/rockstar_dearveni.mp3"));
    print("SetCompleter: Target name: $targetName");

    state = state.copyWith(completer: completer, targetName: targetName);
  }

  Future<void> acceptIncomingCall() async {
    if (state.completer != null) state.completer!.complete(true);
    await state.audioPlayer.stop();
    state = state.copyWith(completer: null);
  }

  Future<void> rejectIncomingCall() async {
    if (state.completer != null) state.completer!.complete(false);
    await state.audioPlayer.stop();

    state = state.copyWith(completer: null, targetName: null);
  }

  String? getTargetName() => state.targetName;
}

@riverpod
SharedPreferences sharedPreference(Ref ref) => throw UnimplementedError;

final callManagerAdoptorProvider = FutureProvider((ref) async {
  final displayName = ref.watch(displayNameProvider);

  final peerNode = await CallManagerAdaptor.initialize(
    displayName: displayName ?? "",
    onCallReceived: (displayName) async {
      final completer = Completer<bool>();
      print(" on call received :Target displayName: $displayName");
      await ref
          .read(incomingCallDecisionProvider.notifier)
          .setCompleter(completer, targetName: displayName);
      return await completer.future;
    },
    onCallAccepted: (CallSessionAdaptor session) async {
      return true;
    },
  );

  print("Peer initialized ");
  return peerNode;
});
