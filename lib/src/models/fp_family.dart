import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

part 'fp_family.g.dart';

@JsonSerializable()
class FPFamily {
  int id;
  String name;

  FPFamily({required this.id, required this.name});

  factory FPFamily.fromJson(Map<String, dynamic> json) =>
      _$FPFamilyFromJson(json);
  Map<String, dynamic> toJson() => _$FPFamilyToJson(this);

  @override
  bool operator ==(Object other) => other is FPFamily && id == other.id;

  @override
  int get hashCode => hashValues(id, id);
}
