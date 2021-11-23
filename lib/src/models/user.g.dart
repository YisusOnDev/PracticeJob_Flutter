// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int?,
      json['email'] as String?,
      json['name'] as String?,
      json['lastname'] as String?,
      json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      json['province'] == null
          ? null
          : Province.fromJson(json['province'] as Map<String, dynamic>),
      json['city'] as String?,
      json['token'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'lastname': instance.lastname,
      'birthdate': instance.birthdate?.toIso8601String(),
      'province': instance.province,
      'city': instance.city,
      'token': instance.token,
    };
