// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joboffer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobOffer _$JobOfferFromJson(Map<String, dynamic> json) => JobOffer(
      id: json['id'] as int?,
      companyId: json['companyId'] as int?,
      company: json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
      name: json['name'] as String?,
      description: json['description'] as String?,
      remuneration: json['remuneration'] as int?,
      schedule: json['schedule'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      fPs: (json['fPs'] as List<dynamic>?)
          ?.map((e) => FP.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobApplications: (json['jobApplications'] as List<dynamic>?)
          ?.map((e) => JobApplication.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JobOfferToJson(JobOffer instance) => <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'company': instance.company,
      'name': instance.name,
      'description': instance.description,
      'remuneration': instance.remuneration,
      'schedule': instance.schedule,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'fPs': instance.fPs,
      'jobApplications': instance.jobApplications,
    };
