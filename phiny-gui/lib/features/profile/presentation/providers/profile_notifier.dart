import 'package:phiny_gui/app/app_constants.dart';
import 'package:phiny_gui/app/app_provider.dart';
import 'package:phiny_gui/features/profile/domain/profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_notifier.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Profile build() {
    final sharedPreference = ref.watch(sharedPreferenceProvider);
    final nodeAddress = ref.watch(peerNodeProvider);
    return Profile(
      displayName: sharedPreference.getString(DISPLAY_NAME_STORING_KEY),
      nodeAddress: nodeAddress.when(
        data: (data) => data.getNodeAddress(),
        error: (error, stack) => "",
        loading: () => "",
      ),
    );
  }

  Future<void> setDisplayName(String displayName) async {
    state = state.copyWith(displayName: displayName);
    await ref
        .read(sharedPreferenceProvider)
        .setString(DISPLAY_NAME_STORING_KEY, displayName);
  }

  String? getDisplayName() {
    return state.displayName;
  }

  Future<void> removeDisplayName() async {
    await ref.read(sharedPreferenceProvider).remove(DISPLAY_NAME_STORING_KEY);
    state = state.copyWith(displayName: null);
  }
}
