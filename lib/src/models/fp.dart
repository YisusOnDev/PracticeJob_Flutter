import 'dart:convert';
import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:practicejob/src/models/fp_family.dart';
import 'package:practicejob/src/models/fp_grade.dart';

part 'fp.g.dart';

@JsonSerializable()
class FP {
  int id;
  String name;
  int fpGradeId;
  FPGrade fpGrade;
  int fpFamilyId;
  FPFamily fpFamily;

  FP(
      {required this.id,
      required this.name,
      required this.fpGradeId,
      required this.fpGrade,
      required this.fpFamilyId,
      required this.fpFamily});

  factory FP.fromJson(Map<String, dynamic> json) => _$FPFromJson(json);
  Map<String, dynamic> toJson() => _$FPToJson(this);

  @override
  bool operator ==(Object other) => other is FP && id == other.id;

  @override
  int get hashCode => hashValues(id, id);
}

List<FP> fpListFromJson(String pData) {
  final fpJson = jsonDecode(pData);
  return List<FP>.from(fpJson.map((x) => FP.fromJson(x)));
}

String fpListToJson(List<FP> fpList) {
  final json = List<dynamic>.from(fpList.map((x) => x.toJson()));
  return jsonEncode(json);
}
