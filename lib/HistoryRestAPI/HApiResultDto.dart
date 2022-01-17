
import 'package:json_annotation/json_annotation.dart';

part 'HApiResultDto.g.dart';
@JsonSerializable()
class HApiResultDto{
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
  HApiResultDto({required this.recordedTime, required this.stress, required this.heartRate, required this.systolic, required this.diastolic, required this.weight});
  factory HApiResultDto.fromJson(Map<String, dynamic> json) => _$HApiResultDtoFromJson(json);
  Map<String, dynamic> toJson() => _$HApiResultDtoToJson(this);
}

