
import 'package:json_annotation/json_annotation.dart';

part 'HistoryApiResponse.g.dart';

@JsonSerializable()
class HistoryApiResponse {
  @JsonKey(name: "recordedTime")
  int recordedTime;
  @JsonKey(name: "uniqueID")
  int uniqueID;
  @JsonKey(name: "stress")
  double stress;
  @JsonKey(name: "heartRate")
  double heartRate;
  @JsonKey(name: "systolic")
  double systolic;
  @JsonKey(name: "diastolic")
  double diastolic;
  @JsonKey(name: "weight")
  double weight;

  HistoryApiResponse({required this.recordedTime, required this.uniqueID, required this.stress, required this.heartRate,
    required this.systolic, required this.diastolic, required this.weight});
  factory HistoryApiResponse.fromJson(Map<String, dynamic> json) => _$HistoryApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryApiResponseToJson(this);




//  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
//   Map<String, dynamic> toJson() => _$UserToJson(this);
// }
//  User({this.id, this.name, this.email,this.gender, this.status, this.created_at, this.updated_at});
//
//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
//   Map<String, dynamic> toJson() => _$UserToJson(this);
//   factory HistoryApiResponse.fromJson(Map<String, dynamic> json){
//     return HistoryApiResponse(
//       recordedTime: json['recordedTime'],
//       stress: json['stress'],
//       heartRate: json['heartRate'],
//       systolic: json['systolic'],
//       diastolic: json['diastolic'],
//       weight: json['weight'],
//       uniqueID: json['uniqueID']
//     );
//   }
//
//   Map<String, dynamic> toJson(){
//     return {
//       'recordedTime' : recordedTime,
//       'stress' : stress,
//       'heartRate' : heartRate,
//       'systolic' : systolic,
//       'diastolic' : diastolic,fd
//       'weight' : weight,
//       'uniqueID' : uniqueID
//     };
//   }
}