// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IncomingCallDecisionState {

 Completer<bool>? get completer; AudioPlayer get audioPlayer; String? get targetName;
/// Create a copy of IncomingCallDecisionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomingCallDecisionStateCopyWith<IncomingCallDecisionState> get copyWith => _$IncomingCallDecisionStateCopyWithImpl<IncomingCallDecisionState>(this as IncomingCallDecisionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomingCallDecisionState&&(identical(other.completer, completer) || other.completer == completer)&&(identical(other.audioPlayer, audioPlayer) || other.audioPlayer == audioPlayer)&&(identical(other.targetName, targetName) || other.targetName == targetName));
}


@override
int get hashCode => Object.hash(runtimeType,completer,audioPlayer,targetName);

@override
String toString() {
  return 'IncomingCallDecisionState(completer: $completer, audioPlayer: $audioPlayer, targetName: $targetName)';
}


}

/// @nodoc
abstract mixin class $IncomingCallDecisionStateCopyWith<$Res>  {
  factory $IncomingCallDecisionStateCopyWith(IncomingCallDecisionState value, $Res Function(IncomingCallDecisionState) _then) = _$IncomingCallDecisionStateCopyWithImpl;
@useResult
$Res call({
 Completer<bool>? completer, AudioPlayer audioPlayer, String? targetName
});




}
/// @nodoc
class _$IncomingCallDecisionStateCopyWithImpl<$Res>
    implements $IncomingCallDecisionStateCopyWith<$Res> {
  _$IncomingCallDecisionStateCopyWithImpl(this._self, this._then);

  final IncomingCallDecisionState _self;
  final $Res Function(IncomingCallDecisionState) _then;

/// Create a copy of IncomingCallDecisionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? completer = freezed,Object? audioPlayer = null,Object? targetName = freezed,}) {
  return _then(_self.copyWith(
completer: freezed == completer ? _self.completer : completer // ignore: cast_nullable_to_non_nullable
as Completer<bool>?,audioPlayer: null == audioPlayer ? _self.audioPlayer : audioPlayer // ignore: cast_nullable_to_non_nullable
as AudioPlayer,targetName: freezed == targetName ? _self.targetName : targetName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IncomingCallDecisionState].
extension IncomingCallDecisionStatePatterns on IncomingCallDecisionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomingCallDecisionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomingCallDecisionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomingCallDecisionState value)  $default,){
final _that = this;
switch (_that) {
case _IncomingCallDecisionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomingCallDecisionState value)?  $default,){
final _that = this;
switch (_that) {
case _IncomingCallDecisionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Completer<bool>? completer,  AudioPlayer audioPlayer,  String? targetName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomingCallDecisionState() when $default != null:
return $default(_that.completer,_that.audioPlayer,_that.targetName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Completer<bool>? completer,  AudioPlayer audioPlayer,  String? targetName)  $default,) {final _that = this;
switch (_that) {
case _IncomingCallDecisionState():
return $default(_that.completer,_that.audioPlayer,_that.targetName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Completer<bool>? completer,  AudioPlayer audioPlayer,  String? targetName)?  $default,) {final _that = this;
switch (_that) {
case _IncomingCallDecisionState() when $default != null:
return $default(_that.completer,_that.audioPlayer,_that.targetName);case _:
  return null;

}
}

}

/// @nodoc


class _IncomingCallDecisionState implements IncomingCallDecisionState {
  const _IncomingCallDecisionState({required this.completer, required this.audioPlayer, required this.targetName});
  

@override final  Completer<bool>? completer;
@override final  AudioPlayer audioPlayer;
@override final  String? targetName;

/// Create a copy of IncomingCallDecisionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomingCallDecisionStateCopyWith<_IncomingCallDecisionState> get copyWith => __$IncomingCallDecisionStateCopyWithImpl<_IncomingCallDecisionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomingCallDecisionState&&(identical(other.completer, completer) || other.completer == completer)&&(identical(other.audioPlayer, audioPlayer) || other.audioPlayer == audioPlayer)&&(identical(other.targetName, targetName) || other.targetName == targetName));
}


@override
int get hashCode => Object.hash(runtimeType,completer,audioPlayer,targetName);

@override
String toString() {
  return 'IncomingCallDecisionState(completer: $completer, audioPlayer: $audioPlayer, targetName: $targetName)';
}


}

/// @nodoc
abstract mixin class _$IncomingCallDecisionStateCopyWith<$Res> implements $IncomingCallDecisionStateCopyWith<$Res> {
  factory _$IncomingCallDecisionStateCopyWith(_IncomingCallDecisionState value, $Res Function(_IncomingCallDecisionState) _then) = __$IncomingCallDecisionStateCopyWithImpl;
@override @useResult
$Res call({
 Completer<bool>? completer, AudioPlayer audioPlayer, String? targetName
});




}
/// @nodoc
class __$IncomingCallDecisionStateCopyWithImpl<$Res>
    implements _$IncomingCallDecisionStateCopyWith<$Res> {
  __$IncomingCallDecisionStateCopyWithImpl(this._self, this._then);

  final _IncomingCallDecisionState _self;
  final $Res Function(_IncomingCallDecisionState) _then;

/// Create a copy of IncomingCallDecisionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? completer = freezed,Object? audioPlayer = null,Object? targetName = freezed,}) {
  return _then(_IncomingCallDecisionState(
completer: freezed == completer ? _self.completer : completer // ignore: cast_nullable_to_non_nullable
as Completer<bool>?,audioPlayer: null == audioPlayer ? _self.audioPlayer : audioPlayer // ignore: cast_nullable_to_non_nullable
as AudioPlayer,targetName: freezed == targetName ? _self.targetName : targetName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
