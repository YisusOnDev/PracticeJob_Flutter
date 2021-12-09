import 'dart:convert';
import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
part 'province.g.dart';

@JsonSerializable()
class Province {
  int id;
  String name;

  Province({required this.id, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) =>
      _$ProvinceFromJson(json);
  Map<String, dynamic> toJson() => _$ProvinceToJson(this);

  @override
  bool operator ==(Object other) => other is Province && id == other.id;

  @override
  int get hashCode => hashValues(id, id);
}

List<Province> provinceListFromJson(String pData) {
  final provincesJson = jsonDecode(pData);
  return List<Province>.from(provincesJson.map((x) => Province.fromJson(x)));
}

String provinceListToJson(List<Province> provinceList) {
  final json = List<dynamic>.from(provinceList.map((x) => x.toJson()));
  return jsonEncode(json);
}
