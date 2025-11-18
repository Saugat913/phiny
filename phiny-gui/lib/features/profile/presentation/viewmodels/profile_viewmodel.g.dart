// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileViewModel)
const profileViewModelProvider = ProfileViewModelProvider._();

final class ProfileViewModelProvider
    extends $NotifierProvider<ProfileViewModel, ProfileViewModelState> {
  const ProfileViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileViewModelHash();

  @$internal
  @override
  ProfileViewModel create() => ProfileViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileViewModelState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileViewModelState>(value),
    );
  }
}

String _$profileViewModelHash() => r'0cf77f944388e9d2f69c48a9ee8535272888def5';

abstract class _$ProfileViewModel extends $Notifier<ProfileViewModelState> {
  ProfileViewModelState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ProfileViewModelState, ProfileViewModelState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProfileViewModelState, ProfileViewModelState>,
              ProfileViewModelState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
