// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DummyHistoryDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DummyHistoryDto _$DummyHistoryDtoFromJson(Map<String, dynamic> json) {
  return DummyHistoryDto(
    json['start'] as int,
    json['end'] as int,
    json['filterType'] as String,
  );
}

Map<String, dynamic> _$DummyHistoryDtoToJson(DummyHistoryDto instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'filterType': instance.filterType,
    };
