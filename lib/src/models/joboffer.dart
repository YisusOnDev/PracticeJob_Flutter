import 'dart:convert';

import 'company.dart';

import 'package:json_annotation/json_annotation.dart';

import 'fp.dart';

part 'joboffer.g.dart';

@JsonSerializable()
class JobOffer {
  final int? id;
  final int? companyId;
  final Company? company;
  final String? name;
  final String? description;
  final int? remuneration;
  final String? schedule;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<FP>? fPs;

  JobOffer({
    this.id,
    this.companyId,
    this.company,
    this.name,
    this.description,
    this.remuneration,
    this.schedule,
    this.startDate,
    this.endDate,
    this.fPs,
  });

  factory JobOffer.fromJson(Map<String, dynamic> json) =>
      _$JobOfferFromJson(json);
  Map<String, dynamic> toJson() => _$JobOfferToJson(this);
}

List<JobOffer> jobOfferListFromJson(String pData) {
  final jobOfferJson = jsonDecode(pData);
  return List<JobOffer>.from(jobOfferJson.map((x) => JobOffer.fromJson(x)));
}

String jobOfferListToJson(List<JobOffer> list) {
  final json = List<dynamic>.from(list.map((x) => x.toJson()));
  return jsonEncode(json);
}
