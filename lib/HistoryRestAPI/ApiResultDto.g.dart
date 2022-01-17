// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiResultDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResultDto _$ApiResultDtoFromJson(Map<String, dynamic> json) {
  return ApiResultDto(
    code: json['code'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ApiResultDtoToJson(ApiResultDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
