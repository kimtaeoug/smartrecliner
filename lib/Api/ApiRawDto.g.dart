// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiRawDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiRawDto _$ApiRawDtoFromJson(Map<String, dynamic> json) {
  return ApiRawDto(
    (json['weight'] as num).toDouble(),
    json['rawData'] as String,
  );
}

Map<String, dynamic> _$ApiRawDtoToJson(ApiRawDto instance) => <String, dynamic>{
      'weight': instance.weight,
      'rawData': instance.rawData,
    };
