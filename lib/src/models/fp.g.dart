// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FP _$FPFromJson(Map<String, dynamic> json) => FP(
      id: json['id'] as int,
      name: json['name'] as String,
      fpGradeId: json['fpGradeId'] as int,
      fpGrade: FPGrade.fromJson(json['fpGrade'] as Map<String, dynamic>),
      fpFamilyId: json['fpFamilyId'] as int,
      fpFamily: FPFamily.fromJson(json['fpFamily'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FPToJson(FP instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fpGradeId': instance.fpGradeId,
      'fpGrade': instance.fpGrade,
      'fpFamilyId': instance.fpFamilyId,
      'fpFamily': instance.fpFamily,
    };
