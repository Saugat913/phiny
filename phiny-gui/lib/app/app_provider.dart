import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phiny_gui/app/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:phiny_gui/features/profile/presentation/providers/profile_notifier.dart';
import 'package:phiny_gui/src/rust/api/phiny_core_adaptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
part 'app_provider.g.dart';

class IncomingCallState {
  final String callerName;
  final Completer<bool> decision;
  IncomingCallState(this.callerName, this.decision);
}

@riverpod
class IncomingCall extends _$IncomingCall {
  @override
  IncomingCallState? build() => null;
}

@riverpod
SharedPreferences sharedPreference(Ref ref) => throw UnimplementedError;

final peerNodeProvider = FutureProvider((ref) async {
  final sharedPreference = ref.watch(sharedPreferenceProvider);
  final displayName = sharedPreference.getString(DISPLAY_NAME_STORING_KEY);
  final peerNode = await initialize(displayName: displayName ?? "");

  print("Peer initialized ");
  return peerNode;
});

final connectionAdaptorProvider = FutureProvider<ConnectionAdaptor>((
  ref,
) async {
  final peerNode = await ref.watch(peerNodeProvider.future);
  return peerNode.listen(
    onReceivedConnection: (displayName) async {
      final completer = Completer<bool>();
      ref.read(incomingCallProvider.notifier).state = IncomingCallState(
        displayName,
        completer,
      );
      return completer.future;
    },
  );
});
