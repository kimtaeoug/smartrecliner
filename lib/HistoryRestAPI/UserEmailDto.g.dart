// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserEmailDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEmailDto _$UserEmailDtoFromJson(Map<String, dynamic> json) {
  return UserEmailDto(
    userEmail: json['UserEmail'] as String,
    requestDate: DateTime.parse(json['requestDate'] as String),
  );
}

Map<String, dynamic> _$UserEmailDtoToJson(UserEmailDto instance) =>
    <String, dynamic>{
      'UserEmail': instance.userEmail,
      'requestDate': instance.requestDate.toIso8601String(),
    };
