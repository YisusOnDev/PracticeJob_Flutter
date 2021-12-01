import 'package:json_annotation/json_annotation.dart';
import 'package:practicejob/src/models/province.dart';
part 'user.g.dart';

/// flutter pub run build_runner build
@JsonSerializable()
class User {
  User(this.id, this.email, this.name, this.lastname, this.birthdate,
      this.provinceId, this.province, this.city, this.token);

  int? id;
  String? email;
  String? name;
  String? lastname;
  DateTime? birthdate;
  int provinceId;
  Province? province;
  String? city;
  String? token;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
