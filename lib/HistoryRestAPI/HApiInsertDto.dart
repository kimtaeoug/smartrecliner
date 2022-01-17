import 'package:json_annotation/json_annotation.dart';

part 'HApiInsertDto.g.dart';
@JsonSerializable()
class HApiInsertDto{
  @JsonKey(name : "UserEmail")
  String userEmail;
  @JsonKey(name : "recordedTime")
  String recordedTime;
  @JsonKey(name : "stress")
  double stress;
  @JsonKey(name : "heartRate")
  double heartRate;
  @JsonKey(name : "systolic")
  double systolic;
  @JsonKey(name : "diastolic")
  double diastolic;
  @JsonKey(name : "weight")
  double weight;
  HApiInsertDto({required this.userEmail, required this.recordedTime, required this.stress, required this.heartRate, required this.systolic, required this.diastolic, required this.weight});
  factory HApiInsertDto.fromJson(Map<String, dynamic> json) => _$HApiInsertDtoFromJson(json);
  Map<String, dynamic> toJson() => _$HApiInsertDtoToJson(this);
}