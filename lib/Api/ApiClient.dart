import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smartrecliner_flutter/Api/ApiRawDto.dart';
import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';

part 'ApiClient.g.dart';
@RestApi(baseUrl: "http://183.99.48.93:8080/")
abstract class ApiClient{
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  @POST("api/raw")
  Future<HistoryApiResponse> getResultAPI(@Body() ApiRawDto rawData);
}
//flutter pub run build_runner build --delete-conflicting-outputs


//part 'user.g.dart';
// 이 구문은 `User` 클래스가 생성된 파일의 private 멤버들을
// 접근할 수 있도록 해줍니다. 여기에는 *.g.dart 형식이 들어갑니다.
// * 에는 소스 파일의 이름이 들어갑니다
//class User {
//   final String name;
//   final String email;
//
//   User(this.name, this.email);
//
//   User.fromJson(Map<String, dynamic> json)
//       : name = json['name'],
//         email = json['email'];
//
//   Map<String, dynamic> toJson() =>
//     {
//       'name': name,
//       'email': email,
//     };
// }