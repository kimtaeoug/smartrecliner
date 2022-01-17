// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HApiInfoDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HApiInfoDto _$HApiInfoDtoFromJson(Map<String, dynamic> json) {
  return HApiInfoDto(
    code: json['code'] as int,
    message: json['message'] as String,
    info: json['info'] as Object,
  );
}

Map<String, dynamic> _$HApiInfoDtoToJson(HApiInfoDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'info': instance.info,
    };
