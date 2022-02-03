import 'package:json_annotation/json_annotation.dart';
import 'package:practicejob/src/models/fp.dart';
import 'package:practicejob/src/models/province.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? email;
  String? name;
  String? lastName;
  DateTime? birthDate;
  int? provinceId;
  Province? province;
  String? city;
  String? profileImage;
  int? fpId;
  FP? fp;
  double? fpCalification;
  bool? validatedEmail;

  User(
      this.id,
      this.email,
      this.name,
      this.lastName,
      this.birthDate,
      this.provinceId,
      this.province,
      this.city,
      this.profileImage,
      this.fpId,
      this.fp,
      this.fpCalification,
      this.validatedEmail);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
