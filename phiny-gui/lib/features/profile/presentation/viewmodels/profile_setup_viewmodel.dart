import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:phiny_gui/features/profile/presentation/providers/profile_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_setup_viewmodel.g.dart';
part 'profile_setup_viewmodel.freezed.dart';

@freezed
abstract class ProfileSetupViewModelState with _$ProfileSetupViewModelState {
  const factory ProfileSetupViewModelState({
    String? displayName,
    String? errorMsg,
    @Default(false) bool isLoading,
  }) = _ProfileSetupViewModelState;
}

@riverpod
class ProfileSetupViewModel extends _$ProfileSetupViewModel {
  @override
  ProfileSetupViewModelState build() {
    final profileNotifier = ref.watch(profileProvider);
    final displayName = profileNotifier.displayName;
    final viewModelState = ProfileSetupViewModelState(displayName: displayName);
    return viewModelState;
  }

  Future<void> setDisplayName(String displayName) async {
    if (displayName.isEmpty) {
      state = state.copyWith(errorMsg: "Please enter the display name");
      return;
    }
    state = state.copyWith(errorMsg: null, isLoading: true);
    await ref.read(displayNameProvider.notifier).setDisplayName(displayName);
    state = state.copyWith(isLoading: false, displayName: displayName);
  }
}
