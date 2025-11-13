// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileViewModelState {

 String get displayName; String get nodeAddress; String? get successMsg; String? get errorMsg;
/// Create a copy of ProfileViewModelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileViewModelStateCopyWith<ProfileViewModelState> get copyWith => _$ProfileViewModelStateCopyWithImpl<ProfileViewModelState>(this as ProfileViewModelState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileViewModelState&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.nodeAddress, nodeAddress) || other.nodeAddress == nodeAddress)&&(identical(other.successMsg, successMsg) || other.successMsg == successMsg)&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,nodeAddress,successMsg,errorMsg);

@override
String toString() {
  return 'ProfileViewModelState(displayName: $displayName, nodeAddress: $nodeAddress, successMsg: $successMsg, errorMsg: $errorMsg)';
}


}

/// @nodoc
abstract mixin class $ProfileViewModelStateCopyWith<$Res>  {
  factory $ProfileViewModelStateCopyWith(ProfileViewModelState value, $Res Function(ProfileViewModelState) _then) = _$ProfileViewModelStateCopyWithImpl;
@useResult
$Res call({
 String displayName, String nodeAddress, String? successMsg, String? errorMsg
});




}
/// @nodoc
class _$ProfileViewModelStateCopyWithImpl<$Res>
    implements $ProfileViewModelStateCopyWith<$Res> {
  _$ProfileViewModelStateCopyWithImpl(this._self, this._then);

  final ProfileViewModelState _self;
  final $Res Function(ProfileViewModelState) _then;

/// Create a copy of ProfileViewModelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? nodeAddress = null,Object? successMsg = freezed,Object? errorMsg = freezed,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,nodeAddress: null == nodeAddress ? _self.nodeAddress : nodeAddress // ignore: cast_nullable_to_non_nullable
as String,successMsg: freezed == successMsg ? _self.successMsg : successMsg // ignore: cast_nullable_to_non_nullable
as String?,errorMsg: freezed == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileViewModelState].
extension ProfileViewModelStatePatterns on ProfileViewModelState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileViewModelState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileViewModelState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileViewModelState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileViewModelState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileViewModelState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileViewModelState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String nodeAddress,  String? successMsg,  String? errorMsg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileViewModelState() when $default != null:
return $default(_that.displayName,_that.nodeAddress,_that.successMsg,_that.errorMsg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String nodeAddress,  String? successMsg,  String? errorMsg)  $default,) {final _that = this;
switch (_that) {
case _ProfileViewModelState():
return $default(_that.displayName,_that.nodeAddress,_that.successMsg,_that.errorMsg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String nodeAddress,  String? successMsg,  String? errorMsg)?  $default,) {final _that = this;
switch (_that) {
case _ProfileViewModelState() when $default != null:
return $default(_that.displayName,_that.nodeAddress,_that.successMsg,_that.errorMsg);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileViewModelState implements ProfileViewModelState {
  const _ProfileViewModelState({required this.displayName, required this.nodeAddress, this.successMsg, this.errorMsg});
  

@override final  String displayName;
@override final  String nodeAddress;
@override final  String? successMsg;
@override final  String? errorMsg;

/// Create a copy of ProfileViewModelState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileViewModelStateCopyWith<_ProfileViewModelState> get copyWith => __$ProfileViewModelStateCopyWithImpl<_ProfileViewModelState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileViewModelState&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.nodeAddress, nodeAddress) || other.nodeAddress == nodeAddress)&&(identical(other.successMsg, successMsg) || other.successMsg == successMsg)&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,nodeAddress,successMsg,errorMsg);

@override
String toString() {
  return 'ProfileViewModelState(displayName: $displayName, nodeAddress: $nodeAddress, successMsg: $successMsg, errorMsg: $errorMsg)';
}


}

/// @nodoc
abstract mixin class _$ProfileViewModelStateCopyWith<$Res> implements $ProfileViewModelStateCopyWith<$Res> {
  factory _$ProfileViewModelStateCopyWith(_ProfileViewModelState value, $Res Function(_ProfileViewModelState) _then) = __$ProfileViewModelStateCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String nodeAddress, String? successMsg, String? errorMsg
});




}
/// @nodoc
class __$ProfileViewModelStateCopyWithImpl<$Res>
    implements _$ProfileViewModelStateCopyWith<$Res> {
  __$ProfileViewModelStateCopyWithImpl(this._self, this._then);

  final _ProfileViewModelState _self;
  final $Res Function(_ProfileViewModelState) _then;

/// Create a copy of ProfileViewModelState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? nodeAddress = null,Object? successMsg = freezed,Object? errorMsg = freezed,}) {
  return _then(_ProfileViewModelState(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,nodeAddress: null == nodeAddress ? _self.nodeAddress : nodeAddress // ignore: cast_nullable_to_non_nullable
as String,successMsg: freezed == successMsg ? _self.successMsg : successMsg // ignore: cast_nullable_to_non_nullable
as String?,errorMsg: freezed == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
