import 'package:json_annotation/json_annotation.dart';
part 'HApiInfoDto.g.dart';
@JsonSerializable()
class HApiInfoDto{
  @JsonKey(name : "code")
  int code;
  @JsonKey(name : "message")
  String message;
  @JsonKey(name : "info")
  Object info;
  HApiInfoDto({required this.code, required this.message, required this.info});
  factory HApiInfoDto.fromJson(Map<String, dynamic> json) => _$HApiInfoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$HApiInfoDtoToJson(this);
}
