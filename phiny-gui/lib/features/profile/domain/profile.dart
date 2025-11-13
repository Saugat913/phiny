import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile.freezed.dart';

@freezed
abstract class Profile with _$Profile {
  const factory Profile({String? displayName, required String nodeAddress}) =
      _Profile;
}
