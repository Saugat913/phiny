// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_setup_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileSetupViewModelState {

 String? get displayName; String? get errorMsg; bool get isLoading;
/// Create a copy of ProfileSetupViewModelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSetupViewModelStateCopyWith<ProfileSetupViewModelState> get copyWith => _$ProfileSetupViewModelStateCopyWithImpl<ProfileSetupViewModelState>(this as ProfileSetupViewModelState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupViewModelState&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,errorMsg,isLoading);

@override
String toString() {
  return 'ProfileSetupViewModelState(displayName: $displayName, errorMsg: $errorMsg, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $ProfileSetupViewModelStateCopyWith<$Res>  {
  factory $ProfileSetupViewModelStateCopyWith(ProfileSetupViewModelState value, $Res Function(ProfileSetupViewModelState) _then) = _$ProfileSetupViewModelStateCopyWithImpl;
@useResult
$Res call({
 String? displayName, String? errorMsg, bool isLoading
});




}
/// @nodoc
class _$ProfileSetupViewModelStateCopyWithImpl<$Res>
    implements $ProfileSetupViewModelStateCopyWith<$Res> {
  _$ProfileSetupViewModelStateCopyWithImpl(this._self, this._then);

  final ProfileSetupViewModelState _self;
  final $Res Function(ProfileSetupViewModelState) _then;

/// Create a copy of ProfileSetupViewModelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = freezed,Object? errorMsg = freezed,Object? isLoading = null,}) {
  return _then(_self.copyWith(
displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,errorMsg: freezed == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileSetupViewModelState].
extension ProfileSetupViewModelStatePatterns on ProfileSetupViewModelState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileSetupViewModelState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileSetupViewModelState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileSetupViewModelState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileSetupViewModelState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileSetupViewModelState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileSetupViewModelState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? displayName,  String? errorMsg,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileSetupViewModelState() when $default != null:
return $default(_that.displayName,_that.errorMsg,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? displayName,  String? errorMsg,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _ProfileSetupViewModelState():
return $default(_that.displayName,_that.errorMsg,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? displayName,  String? errorMsg,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _ProfileSetupViewModelState() when $default != null:
return $default(_that.displayName,_that.errorMsg,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileSetupViewModelState implements ProfileSetupViewModelState {
  const _ProfileSetupViewModelState({this.displayName, this.errorMsg, this.isLoading = false});
  

@override final  String? displayName;
@override final  String? errorMsg;
@override@JsonKey() final  bool isLoading;

/// Create a copy of ProfileSetupViewModelState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileSetupViewModelStateCopyWith<_ProfileSetupViewModelState> get copyWith => __$ProfileSetupViewModelStateCopyWithImpl<_ProfileSetupViewModelState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileSetupViewModelState&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,errorMsg,isLoading);

@override
String toString() {
  return 'ProfileSetupViewModelState(displayName: $displayName, errorMsg: $errorMsg, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$ProfileSetupViewModelStateCopyWith<$Res> implements $ProfileSetupViewModelStateCopyWith<$Res> {
  factory _$ProfileSetupViewModelStateCopyWith(_ProfileSetupViewModelState value, $Res Function(_ProfileSetupViewModelState) _then) = __$ProfileSetupViewModelStateCopyWithImpl;
@override @useResult
$Res call({
 String? displayName, String? errorMsg, bool isLoading
});




}
/// @nodoc
class __$ProfileSetupViewModelStateCopyWithImpl<$Res>
    implements _$ProfileSetupViewModelStateCopyWith<$Res> {
  __$ProfileSetupViewModelStateCopyWithImpl(this._self, this._then);

  final _ProfileSetupViewModelState _self;
  final $Res Function(_ProfileSetupViewModelState) _then;

/// Create a copy of ProfileSetupViewModelState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = freezed,Object? errorMsg = freezed,Object? isLoading = null,}) {
  return _then(_ProfileSetupViewModelState(
displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,errorMsg: freezed == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
