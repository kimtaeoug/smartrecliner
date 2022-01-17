import 'package:json_annotation/json_annotation.dart';

part 'ApiRawDto.g.dart';
@JsonSerializable()
class ApiRawDto{
  @JsonKey(name: "weight")
  double weight;
  @JsonKey(name: "rawData")
  String rawData;
  ApiRawDto(this.weight, this.rawData);
  factory ApiRawDto.fromJson(Map<String, dynamic> json) => _$ApiRawDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ApiRawDtoToJson(this);
}

