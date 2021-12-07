import 'package:json_annotation/json_annotation.dart';

part 'fp_grade.g.dart';

@JsonSerializable()
class FPGrade {
  int id;
  String name;

  FPGrade({required this.id, required this.name});

  factory FPGrade.fromJson(Map<String, dynamic> json) =>
      _$FPGradeFromJson(json);
  Map<String, dynamic> toJson() => _$FPGradeToJson(this);
}
