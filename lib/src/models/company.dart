import 'package:practicejob/src/models/province.dart';

import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
class Company {
  final int? id;
  final String? email;
  final String? name;
  final String? address;
  final int? provinceId;
  final Province? province;

  Company({
    this.id,
    this.email,
    this.name,
    this.address,
    this.provinceId,
    this.province,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
