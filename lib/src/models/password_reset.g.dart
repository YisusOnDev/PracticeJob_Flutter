// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordReset _$PasswordResetFromJson(Map<String, dynamic> json) =>
    PasswordReset(
      email: json['email'] as String,
      password: json['password'] as String,
      tfaCode: json['tfaCode'] as String,
    );

Map<String, dynamic> _$PasswordResetToJson(PasswordReset instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'tfaCode': instance.tfaCode,
    };
