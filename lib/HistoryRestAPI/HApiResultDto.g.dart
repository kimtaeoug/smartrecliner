// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HApiResultDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HApiResultDto _$HApiResultDtoFromJson(Map<String, dynamic> json) {
  return HApiResultDto(
    recordedTime: json['recordedTime'] as String,
    stress: (json['stress'] as num).toDouble(),
    heartRate: (json['heartRate'] as num).toDouble(),
    systolic: (json['systolic'] as num).toDouble(),
    diastolic: (json['diastolic'] as num).toDouble(),
    weight: (json['weight'] as num).toDouble(),
  );
}

Map<String, dynamic> _$HApiResultDtoToJson(HApiResultDto instance) =>
    <String, dynamic>{
      'recordedTime': instance.recordedTime,
      'stress': instance.stress,
      'heartRate': instance.heartRate,
      'systolic': instance.systolic,
      'diastolic': instance.diastolic,
      'weight': instance.weight,
    };
