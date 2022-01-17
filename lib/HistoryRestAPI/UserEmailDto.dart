import 'package:json_annotation/json_annotation.dart';

part 'UserEmailDto.g.dart';
@JsonSerializable()
class UserEmailDto{
  @JsonKey(name : "UserEmail")
  String userEmail;
  @JsonKey(name : "requestDate")
  DateTime requestDate;
  UserEmailDto({required this.userEmail, required this.requestDate});
  factory UserEmailDto.fromJson(Map<String, dynamic> json) => _$UserEmailDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserEmailDtoToJson(this);
}