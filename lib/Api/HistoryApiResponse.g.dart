// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HistoryApiResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryApiResponse _$HistoryApiResponseFromJson(Map<String, dynamic> json) {
  return HistoryApiResponse(
    recordedTime: json['recordedTime'] as int,
    uniqueID: json['uniqueID'] as int,
    stress: (json['stress'] as num).toDouble(),
    heartRate: (json['heartRate'] as num).toDouble(),
    systolic: (json['systolic'] as num).toDouble(),
    diastolic: (json['diastolic'] as num).toDouble(),
    weight: (json['weight'] as num).toDouble(),
  );
}

Map<String, dynamic> _$HistoryApiResponseToJson(HistoryApiResponse instance) =>
    <String, dynamic>{
      'recordedTime': instance.recordedTime,
      'uniqueID': instance.uniqueID,
      'stress': instance.stress,
      'heartRate': instance.heartRate,
      'systolic': instance.systolic,
      'diastolic': instance.diastolic,
      'weight': instance.weight,
    };
