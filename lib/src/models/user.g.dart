// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int?,
      json['email'] as String?,
      json['name'] as String?,
      json['lastName'] as String?,
      json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      json['provinceId'] as int?,
      json['province'] == null
          ? null
          : Province.fromJson(json['province'] as Map<String, dynamic>),
      json['city'] as String?,
      json['profileImage'] as String?,
      json['fpId'] as int?,
      json['fp'] == null
          ? null
          : FP.fromJson(json['fp'] as Map<String, dynamic>),
      (json['fpCalification'] as num?)?.toDouble(),
      json['validatedEmail'] as bool?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate?.toIso8601String(),
      'provinceId': instance.provinceId,
      'province': instance.province,
      'city': instance.city,
      'profileImage': instance.profileImage,
      'fpId': instance.fpId,
      'fp': instance.fp,
      'fpCalification': instance.fpCalification,
      'validatedEmail': instance.validatedEmail,
    };
