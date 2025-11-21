import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:phiny_gui/features/profile/presentation/providers/profile_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_viewmodel.freezed.dart';
part 'profile_viewmodel.g.dart';

@freezed
abstract class ProfileViewModelState with _$ProfileViewModelState {
  const factory ProfileViewModelState({
    required String displayName,
    required String nodeAddress,
    String? successMsg,
    String? errorMsg,
  }) = _ProfileViewModelState;
}

@riverpod
class ProfileViewModel extends _$ProfileViewModel {
  @override
  ProfileViewModelState build() {
    final profileData = ref.watch(profileProvider);
    return ProfileViewModelState(
      displayName: profileData.displayName ?? "",
      nodeAddress: profileData.nodeAddress,
    );
  }

  Future<void> copyNodeId() async {
    await Clipboard.setData(ClipboardData(text: state.nodeAddress));
    state = state.copyWith(successMsg: 'Node ID copied to clipboard');

    // Clear the error msg
    Future.delayed(Duration(seconds: 2), () {
      state = state.copyWith(successMsg: null);
    });
  }

  Future<void> logout() async {
    await ref.read(displayNameProvider.notifier).removeDisplayName();
  }
}
