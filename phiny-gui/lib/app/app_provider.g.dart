// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IncomingCall)
const incomingCallProvider = IncomingCallProvider._();

final class IncomingCallProvider
    extends $NotifierProvider<IncomingCall, IncomingCallState?> {
  const IncomingCallProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingCallProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingCallHash();

  @$internal
  @override
  IncomingCall create() => IncomingCall();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IncomingCallState? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IncomingCallState?>(value),
    );
  }
}

String _$incomingCallHash() => r'db732652df1c1f6e322ec01e6580cf95979d8429';

abstract class _$IncomingCall extends $Notifier<IncomingCallState?> {
  IncomingCallState? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<IncomingCallState?, IncomingCallState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IncomingCallState?, IncomingCallState?>,
              IncomingCallState?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(sharedPreference)
const sharedPreferenceProvider = SharedPreferenceProvider._();

final class SharedPreferenceProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  const SharedPreferenceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferenceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferenceHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreference(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferenceHash() => r'0b27f237e156eda5e5bee23c0c40ba39148104dd';
