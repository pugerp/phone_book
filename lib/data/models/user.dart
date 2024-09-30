import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    String? id,
    required String username,
    required String passowrd
}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}