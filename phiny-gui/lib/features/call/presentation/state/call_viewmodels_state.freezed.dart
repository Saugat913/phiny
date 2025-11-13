// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_viewmodels_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallViewModelState {

 CallViewState get callState; Duration get callDuration; bool get isMuted; bool get isSpeakerOn;
/// Create a copy of CallViewModelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallViewModelStateCopyWith<CallViewModelState> get copyWith => _$CallViewModelStateCopyWithImpl<CallViewModelState>(this as CallViewModelState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallViewModelState&&(identical(other.callState, callState) || other.callState == callState)&&(identical(other.callDuration, callDuration) || other.callDuration == callDuration)&&(identical(other.isMuted, isMuted) || other.isMuted == isMuted)&&(identical(other.isSpeakerOn, isSpeakerOn) || other.isSpeakerOn == isSpeakerOn));
}


@override
int get hashCode => Object.hash(runtimeType,callState,callDuration,isMuted,isSpeakerOn);

@override
String toString() {
  return 'CallViewModelState(callState: $callState, callDuration: $callDuration, isMuted: $isMuted, isSpeakerOn: $isSpeakerOn)';
}


}

/// @nodoc
abstract mixin class $CallViewModelStateCopyWith<$Res>  {
  factory $CallViewModelStateCopyWith(CallViewModelState value, $Res Function(CallViewModelState) _then) = _$CallViewModelStateCopyWithImpl;
@useResult
$Res call({
 CallViewState callState, Duration callDuration, bool isMuted, bool isSpeakerOn
});




}
/// @nodoc
class _$CallViewModelStateCopyWithImpl<$Res>
    implements $CallViewModelStateCopyWith<$Res> {
  _$CallViewModelStateCopyWithImpl(this._self, this._then);

  final CallViewModelState _self;
  final $Res Function(CallViewModelState) _then;

/// Create a copy of CallViewModelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callState = null,Object? callDuration = null,Object? isMuted = null,Object? isSpeakerOn = null,}) {
  return _then(_self.copyWith(
callState: null == callState ? _self.callState : callState // ignore: cast_nullable_to_non_nullable
as CallViewState,callDuration: null == callDuration ? _self.callDuration : callDuration // ignore: cast_nullable_to_non_nullable
as Duration,isMuted: null == isMuted ? _self.isMuted : isMuted // ignore: cast_nullable_to_non_nullable
as bool,isSpeakerOn: null == isSpeakerOn ? _self.isSpeakerOn : isSpeakerOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CallViewModelState].
extension CallViewModelStatePatterns on CallViewModelState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallViewModelState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallViewModelState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallViewModelState value)  $default,){
final _that = this;
switch (_that) {
case _CallViewModelState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallViewModelState value)?  $default,){
final _that = this;
switch (_that) {
case _CallViewModelState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CallViewState callState,  Duration callDuration,  bool isMuted,  bool isSpeakerOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallViewModelState() when $default != null:
return $default(_that.callState,_that.callDuration,_that.isMuted,_that.isSpeakerOn);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CallViewState callState,  Duration callDuration,  bool isMuted,  bool isSpeakerOn)  $default,) {final _that = this;
switch (_that) {
case _CallViewModelState():
return $default(_that.callState,_that.callDuration,_that.isMuted,_that.isSpeakerOn);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CallViewState callState,  Duration callDuration,  bool isMuted,  bool isSpeakerOn)?  $default,) {final _that = this;
switch (_that) {
case _CallViewModelState() when $default != null:
return $default(_that.callState,_that.callDuration,_that.isMuted,_that.isSpeakerOn);case _:
  return null;

}
}

}

/// @nodoc


class _CallViewModelState implements CallViewModelState {
  const _CallViewModelState({required this.callState, required this.callDuration, required this.isMuted, required this.isSpeakerOn});
  

@override final  CallViewState callState;
@override final  Duration callDuration;
@override final  bool isMuted;
@override final  bool isSpeakerOn;

/// Create a copy of CallViewModelState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallViewModelStateCopyWith<_CallViewModelState> get copyWith => __$CallViewModelStateCopyWithImpl<_CallViewModelState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallViewModelState&&(identical(other.callState, callState) || other.callState == callState)&&(identical(other.callDuration, callDuration) || other.callDuration == callDuration)&&(identical(other.isMuted, isMuted) || other.isMuted == isMuted)&&(identical(other.isSpeakerOn, isSpeakerOn) || other.isSpeakerOn == isSpeakerOn));
}


@override
int get hashCode => Object.hash(runtimeType,callState,callDuration,isMuted,isSpeakerOn);

@override
String toString() {
  return 'CallViewModelState(callState: $callState, callDuration: $callDuration, isMuted: $isMuted, isSpeakerOn: $isSpeakerOn)';
}


}

/// @nodoc
abstract mixin class _$CallViewModelStateCopyWith<$Res> implements $CallViewModelStateCopyWith<$Res> {
  factory _$CallViewModelStateCopyWith(_CallViewModelState value, $Res Function(_CallViewModelState) _then) = __$CallViewModelStateCopyWithImpl;
@override @useResult
$Res call({
 CallViewState callState, Duration callDuration, bool isMuted, bool isSpeakerOn
});




}
/// @nodoc
class __$CallViewModelStateCopyWithImpl<$Res>
    implements _$CallViewModelStateCopyWith<$Res> {
  __$CallViewModelStateCopyWithImpl(this._self, this._then);

  final _CallViewModelState _self;
  final $Res Function(_CallViewModelState) _then;

/// Create a copy of CallViewModelState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callState = null,Object? callDuration = null,Object? isMuted = null,Object? isSpeakerOn = null,}) {
  return _then(_CallViewModelState(
callState: null == callState ? _self.callState : callState // ignore: cast_nullable_to_non_nullable
as CallViewState,callDuration: null == callDuration ? _self.callDuration : callDuration // ignore: cast_nullable_to_non_nullable
as Duration,isMuted: null == isMuted ? _self.isMuted : isMuted // ignore: cast_nullable_to_non_nullable
as bool,isSpeakerOn: null == isSpeakerOn ? _self.isSpeakerOn : isSpeakerOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
