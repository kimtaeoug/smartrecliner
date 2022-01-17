import 'package:json_annotation/json_annotation.dart';

part 'DummyHistoryDto.g.dart';
@JsonSerializable()
class DummyHistoryDto{
  @JsonKey(name: 'start')
  int start;
  @JsonKey(name: 'end')
  int end;
  @JsonKey(name:'filterType')
  String filterType;
  DummyHistoryDto(this.start, this.end, this.filterType);
  factory DummyHistoryDto.fromJson(Map<String, dynamic> json) => _$DummyHistoryDtoFromJson(json);
  Map<String, dynamic> toJson() => _$DummyHistoryDtoToJson(this);
}
