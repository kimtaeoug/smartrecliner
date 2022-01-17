import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'DummyHistoryDto.dart';
import 'HistoryApiResponse.dart';

part 'HistoryAPI.g.dart';
@RestApi(baseUrl: "http://183.99.48.93:8080/")
abstract class HistoryAPI {
  factory HistoryAPI(Dio dio, {String baseUrl}) = _HistoryAPI;
  @GET("/api/history")
  // Future<List<HistoryApiResponse>> getHistory(@Query("start")start,@Query("end")end,@Query("filterType")filterType);
  // Future<List<HistoryApiResponse>> getHistory(DummyHistoryDto dummyHistoryDto);
  Future<List<HistoryApiResponse>> getHistory(@Query("start")start, @Query("end")end, @Query("filterType")filterType);
  @GET("/api/recent")
  Future<HistoryApiResponse> getRecent();
}
//flutter pub run build_runner build --delete-conflicting-outputs

//  @POST("historyInsert")
//   Future<ApiResultDto> insertHistoryData(@Body() HApiInsertDto insertDto);