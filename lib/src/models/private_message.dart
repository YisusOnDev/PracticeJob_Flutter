import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:practicejob/src/models/user.dart';

import 'company.dart';

part 'private_message.g.dart';

@JsonSerializable()
class PrivateMessage {
  final int? id;
  final String? message;
  final int? studentId;
  final User? student;
  final int? companyId;
  final Company? company;
  final bool? read;

  PrivateMessage(
      {this.id,
      this.message,
      this.studentId,
      this.student,
      this.companyId,
      this.company,
      this.read});

  factory PrivateMessage.fromJson(Map<String, dynamic> json) =>
      _$PrivateMessageFromJson(json);
  Map<String, dynamic> toJson() => _$PrivateMessageToJson(this);
}

List<PrivateMessage> privateMessageListFromJson(String pData) {
  final pmJson = jsonDecode(pData);
  return List<PrivateMessage>.from(
      pmJson.map((x) => PrivateMessage.fromJson(x)));
}

String privateMessageListToJson(List<PrivateMessage> pmList) {
  final json = List<dynamic>.from(pmList.map((x) => x.toJson()));
  return jsonEncode(json);
}
