// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_setup_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileSetupViewModel)
const profileSetupViewModelProvider = ProfileSetupViewModelProvider._();

final class ProfileSetupViewModelProvider
    extends
        $NotifierProvider<ProfileSetupViewModel, ProfileSetupViewModelState> {
  const ProfileSetupViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileSetupViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileSetupViewModelHash();

  @$internal
  @override
  ProfileSetupViewModel create() => ProfileSetupViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileSetupViewModelState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileSetupViewModelState>(value),
    );
  }
}

String _$profileSetupViewModelHash() =>
    r'7b42fb572db7d193817d89992a66a15dbcf37c30';

abstract class _$ProfileSetupViewModel
    extends $Notifier<ProfileSetupViewModelState> {
  ProfileSetupViewModelState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<ProfileSetupViewModelState, ProfileSetupViewModelState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ProfileSetupViewModelState,
                ProfileSetupViewModelState
              >,
              ProfileSetupViewModelState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
