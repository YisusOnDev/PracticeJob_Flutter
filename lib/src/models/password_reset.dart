import 'package:json_annotation/json_annotation.dart';

part 'password_reset.g.dart';

@JsonSerializable()
class PasswordReset {
  String email;
  String password;
  String tfaCode;

  PasswordReset(
      {required this.email, required this.password, required this.tfaCode});

  factory PasswordReset.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetFromJson(json);
  Map<String, dynamic> toJson() => _$PasswordResetToJson(this);
}
