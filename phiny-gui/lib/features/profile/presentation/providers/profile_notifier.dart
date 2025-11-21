import 'package:phiny_gui/app/app_constants.dart';
import 'package:phiny_gui/app/app_provider.dart';
import 'package:phiny_gui/features/profile/domain/profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_notifier.g.dart';

@riverpod
class DisplayName extends _$DisplayName {
  @override
  String? build() {
    final sharedPreference = ref.watch(sharedPreferenceProvider);
    return sharedPreference.getString(DISPLAY_NAME_STORING_KEY);
  }

  Future<void> setDisplayName(String displayName) async {
    state = displayName;
    await ref
        .read(sharedPreferenceProvider)
        .setString(DISPLAY_NAME_STORING_KEY, displayName);
  }

  String? getDisplayName() {
    return state;
  }

  Future<void> removeDisplayName() async {
    await ref.read(sharedPreferenceProvider).remove(DISPLAY_NAME_STORING_KEY);
    state = null;
  }
}

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Profile build() {
    final displayName = ref.watch(displayNameProvider);
    final connectionManager = ref.watch(callManagerAdoptorProvider);
    return Profile(
      displayName: displayName,
      nodeAddress: connectionManager.when(
        data: (data) => data.getNodeAddress(),
        error: (_, __) => "",
        loading: () => "Loading ...",
      ),
    );
  }
}
