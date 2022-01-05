import 'package:json_annotation/json_annotation.dart';

part 'jobapplication.g.dart';

@JsonSerializable()
class JobApplication {
  final int id;
  final int studentId;
  final int jobOfferId;
  final DateTime applicationDate;
  final ApplicationStatus applicationStatus;

  JobApplication({
    required this.id,
    required this.studentId,
    required this.jobOfferId,
    required this.applicationDate,
    required this.applicationStatus,
  });

  factory JobApplication.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationFromJson(json);
  Map<String, dynamic> toJson() => _$JobApplicationToJson(this);
}

enum ApplicationStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  accepted,
  @JsonValue(2)
  declined,
}
