import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

/// flutter pub run build_runner build
@JsonSerializable()
class User {
  User(this.id, this.email, this.password);

  int? id;
  String email;
  String password;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
