// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IncomingCallDecision)
const incomingCallDecisionProvider = IncomingCallDecisionProvider._();

final class IncomingCallDecisionProvider
    extends $NotifierProvider<IncomingCallDecision, IncomingCallDecisionState> {
  const IncomingCallDecisionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingCallDecisionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingCallDecisionHash();

  @$internal
  @override
  IncomingCallDecision create() => IncomingCallDecision();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IncomingCallDecisionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IncomingCallDecisionState>(value),
    );
  }
}

String _$incomingCallDecisionHash() =>
    r'2f06d92727d885146b9a076a6f0f50f6d29d2b09';

abstract class _$IncomingCallDecision
    extends $Notifier<IncomingCallDecisionState> {
  IncomingCallDecisionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<IncomingCallDecisionState, IncomingCallDecisionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IncomingCallDecisionState, IncomingCallDecisionState>,
              IncomingCallDecisionState,
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

String _$sharedPreferenceHash() => r'b3229ee3f41e700171174e09baa7bb0987e73b04';
