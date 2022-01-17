
import 'package:json_annotation/json_annotation.dart';

part 'OnlyUserEmailDto.g.dart';
@JsonSerializable()
class OnlyUserEmailDto{
  @JsonKey(name : "UserEmail")
  String userEmail;
  OnlyUserEmailDto({required this.userEmail});
  factory OnlyUserEmailDto.fromJson(Map<String, dynamic> json) => _$OnlyUserEmailDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OnlyUserEmailDtoToJson(this);
}
