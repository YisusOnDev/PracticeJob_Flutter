// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobapplication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobApplication _$JobApplicationFromJson(Map<String, dynamic> json) =>
    JobApplication(
      id: json['id'] as int,
      studentId: json['studentId'] as int,
      jobOfferId: json['jobOfferId'] as int,
      applicationDate: DateTime.parse(json['applicationDate'] as String),
      applicationStatus:
          $enumDecode(_$ApplicationStatusEnumMap, json['applicationStatus']),
    );

Map<String, dynamic> _$JobApplicationToJson(JobApplication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'jobOfferId': instance.jobOfferId,
      'applicationDate': instance.applicationDate.toIso8601String(),
      'applicationStatus':
          _$ApplicationStatusEnumMap[instance.applicationStatus],
    };

const _$ApplicationStatusEnumMap = {
  ApplicationStatus.pending: 0,
  ApplicationStatus.accepted: 1,
  ApplicationStatus.declined: 2,
};
