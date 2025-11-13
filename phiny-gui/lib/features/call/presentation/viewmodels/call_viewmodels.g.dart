// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_viewmodels.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CallViewModel)
const callViewModelProvider = CallViewModelProvider._();

final class CallViewModelProvider
    extends $NotifierProvider<CallViewModel, CallViewModelState> {
  const CallViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callViewModelHash();

  @$internal
  @override
  CallViewModel create() => CallViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallViewModelState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallViewModelState>(value),
    );
  }
}

String _$callViewModelHash() => r'73fcad99a8befa41e709cabf05953eeacc955582';

abstract class _$CallViewModel extends $Notifier<CallViewModelState> {
  CallViewModelState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CallViewModelState, CallViewModelState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CallViewModelState, CallViewModelState>,
              CallViewModelState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
