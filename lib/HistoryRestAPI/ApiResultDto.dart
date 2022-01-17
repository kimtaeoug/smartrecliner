import 'package:json_annotation/json_annotation.dart';

part 'ApiResultDto.g.dart';
@JsonSerializable()
class ApiResultDto{
  @JsonKey(name:"code")
  int code;
  @JsonKey(name : "message")
  String message;
  ApiResultDto({required this.code, required this.message});
  factory ApiResultDto.fromJson(Map<String, dynamic> json) => _$ApiResultDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResultDtoToJson(this);
}
