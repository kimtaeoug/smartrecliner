import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:smartrecliner_flutter/Api/APIResultDto.dart';
import 'package:smartrecliner_flutter/HistoryRestAPI/ApiResultDto.dart';
import 'package:smartrecliner_flutter/HistoryRestAPI/HApiInfoDto.dart';
import 'package:smartrecliner_flutter/HistoryRestAPI/HApiInsertDto.dart';
import 'package:smartrecliner_flutter/HistoryRestAPI/OnlyUserEmailDto.dart';
import 'package:smartrecliner_flutter/HistoryRestAPI/UserEmailDto.dart';

part 'HApi.g.dart';
@RestApi(baseUrl : "http://183.99.48.93:3310/")
abstract class HApi{
  factory HApi(Dio dio, {String baseUrl}) = _HApi;
  @POST("historyInsert")
  Future<ApiResultDto> insertHistoryData(@Body() HApiInsertDto insertDto);
  @POST("historyRecent")
  Future<HApiInfoDto> requestHistoryRecent(@Body() OnlyUserEmailDto onlyUserEmailDto);
  @POST("historyDay")
  Future<HApiInfoDto> requestHistoryDay(@Body() UserEmailDto userEmailDto);
  @POST("historyWeek")
  Future<HApiInfoDto> requestHistoryWeek(@Body() UserEmailDto userEmailDto);
  @POST("historyMonth")
  Future<HApiInfoDto> requestHistoryMonth(@Body() UserEmailDto userEmailDto);
}


//historyInsert
//historyRecent
//historyDay
//historyWeek
//historyMonth


//membershipJoin
//membershipEmailCheck
//membershipLogin
//membershipModify
//membershipDelete