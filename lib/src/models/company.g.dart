// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: json['id'] as int?,
      email: json['email'] as String?,
      profileImage: json['profileImage'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      provinceId: json['provinceId'] as int?,
      province: json['province'] == null
          ? null
          : Province.fromJson(json['province'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'name': instance.name,
      'address': instance.address,
      'provinceId': instance.provinceId,
      'province': instance.province,
    };
