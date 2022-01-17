// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HApiInsertDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HApiInsertDto _$HApiInsertDtoFromJson(Map<String, dynamic> json) {
  return HApiInsertDto(
    userEmail: json['UserEmail'] as String,
    recordedTime: json['recordedTime'] as String,
    stress: (json['stress'] as num).toDouble(),
    heartRate: (json['heartRate'] as num).toDouble(),
    systolic: (json['systolic'] as num).toDouble(),
    diastolic: (json['diastolic'] as num).toDouble(),
    weight: (json['weight'] as num).toDouble(),
  );
}

Map<String, dynamic> _$HApiInsertDtoToJson(HApiInsertDto instance) =>
    <String, dynamic>{
      'UserEmail': instance.userEmail,
      'recordedTime': instance.recordedTime,
      'stress': instance.stress,
      'heartRate': instance.heartRate,
      'systolic': instance.systolic,
      'diastolic': instance.diastolic,
      'weight': instance.weight,
    };
