// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateMessage _$PrivateMessageFromJson(Map<String, dynamic> json) =>
    PrivateMessage(
      id: json['id'] as int?,
      message: json['message'] as String?,
      studentId: json['studentId'] as int?,
      student: json['student'] == null
          ? null
          : User.fromJson(json['student'] as Map<String, dynamic>),
      companyId: json['companyId'] as int?,
      company: json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
      read: json['read'] as bool?,
    );

Map<String, dynamic> _$PrivateMessageToJson(PrivateMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'studentId': instance.studentId,
      'student': instance.student,
      'companyId': instance.companyId,
      'company': instance.company,
      'read': instance.read,
    };
