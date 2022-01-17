import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:smartrecliner_flutter/Api/DummyHistoryDto.dart';
import 'package:smartrecliner_flutter/Api/HistoryAPI.dart';
import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';
import 'package:smartrecliner_flutter/History/History.dart';
import 'dart:isolate';

class HistoryProvider2 with ChangeNotifier{
  List<HistoryApiResponse> monthData;
  List<HistoryApiResponse> weekData;
  List<HistoryApiResponse> dayData;
  String wichDate;
  String wichMode;
  bool requestEnd;
  HistoryProvider2(this.monthData, this.weekData, this.dayData, this.wichDate, this.wichMode, this.requestEnd);

  static DateTime standardTime = DateTime.now();
  //===================================================================================================================================================//
  //Upgrade Version
  late Isolate _dayIsolate;
  late ReceivePort _dayReceivePort;
  void requestSetDayData(int start, int end) async{
    _dayReceivePort = ReceivePort();
    SendPort _sendPort = _dayReceivePort.sendPort;
    dayData = [];
    notifyListeners();
    _dayIsolate = await Isolate.spawn(requestDayDataByIsolate, [_sendPort, start, end]);
    _dayReceivePort.listen(responseDayData, onDone: (){
      print('day request done');
    });
  }
  static void requestDayDataByIsolate(List<Object> argument) async{
    SendPort sendPort = argument[0] as SendPort;
    int start = argument[1] as int;
    int end = argument[2] as int;
    await HistoryAPI(Dio(BaseOptions(contentType: "application/json"))).getHistory(start, end, "RAW").then((value){
      List<HistoryApiResponse> result = justDifferent(value);
      sendPort.send(result);
    });
  }
  void responseDayData(dynamic data){
    dayData = data;
    notifyListeners();
    _dayReceivePort.close();
    _dayIsolate.kill(priority: Isolate.immediate);
  }
  requestGetDayData() => dayData;

  late Isolate _weekIsolate;
  late ReceivePort _weekReceivePort;
  void requestSetWeekData(int start, int end) async{
    _weekReceivePort = ReceivePort();
    SendPort _sendPort = _weekReceivePort.sendPort;
    weekData = [];
    notifyListeners();
    _weekIsolate = await Isolate.spawn(requestWeekDataByIsolate, [_sendPort, start, end]);
    _weekReceivePort.listen(responseWeekData, onDone: (){
      print('week request done');
    });
  }
  static void requestWeekDataByIsolate(List<Object> argument) async{
    SendPort sendPort = argument[0] as SendPort;
    int start = argument[1] as int;
    int end = argument[2] as int;
    await HistoryAPI(Dio(BaseOptions(contentType: "application/json"))).getHistory(start, end, "RAW").then((value){
      List<HistoryApiResponse> result = justDifferent(value);
      sendPort.send(result);
    });
  }
  void responseWeekData(dynamic data){
    weekData = data;
    notifyListeners();
    _weekReceivePort.close();
    _weekIsolate.kill(priority: Isolate.immediate);
  }
  requestGetWeekData() => weekData;

  late Isolate _monthIsolate;
  late ReceivePort _monthReceivePort;
  void requestSetMonthData(int start, int end) async{
    try{
      _monthReceivePort = ReceivePort();
      SendPort sendPort = _monthReceivePort.sendPort;
      monthData = [];
      notifyListeners();
      _monthIsolate = await Isolate.spawn(requestMonthDataByIsolate, [sendPort, start, end]);
      _monthReceivePort.listen(responseMonthData, onDone: (){
        print('month request done');
      });
    }catch(e){

    }
  }
  static void requestMonthDataByIsolate(List<Object> argument) async{
    SendPort sendPort = argument[0] as SendPort;
    int start = argument[1] as int;
    int end = argument[2] as int;
    await HistoryAPI(Dio(BaseOptions(contentType: "application/json"))).getHistory(start, end, "RAW").then((value){
      List<HistoryApiResponse> result = justDifferent(value);
      print('result : $result');
      sendPort.send(result);
    });
  }
  void responseMonthData(dynamic data){
    monthData = data;
    _monthReceivePort.close();
    _monthIsolate.kill(priority: Isolate.immediate);
    notifyListeners();
  }
  requestGetMonthData() => monthData;

//===================================================================================================================================================//

  void setWichDate(String dateUnit) {
    wichDate = dateUnit;
    switch(wichDate){
      case '일':
        DateTime differ = DateTime(standardTime.year, standardTime.month, standardTime.day+1, 0);
        requestSetDayData(standardTime.millisecondsSinceEpoch, differ.millisecondsSinceEpoch);
        break;
      case '주':
        DateTime differ = DateTime(standardTime.year, standardTime.month, standardTime.day-7, 0);
        requestSetWeekData(differ.millisecondsSinceEpoch, standardTime.millisecondsSinceEpoch);
        break;
      case '월':
        DateTime differ = DateTime(standardTime.year, standardTime.month, 0, 0);
        DateTime after = DateTime(standardTime.year, standardTime.month+1, 0, 0);
        requestSetMonthData(differ.millisecondsSinceEpoch, after.millisecondsSinceEpoch);
        break;
    }
    notifyListeners();
  }

  getWichDate() => wichDate;

  void setWichMode(String mode) {
    wichMode = mode;
    notifyListeners();
  }
  getWichMode() => wichMode;


  //다른 날짜만
  static List<HistoryApiResponse> justDifferent(List<HistoryApiResponse> dataList) {
    int dummyDay = 0;
    List<HistoryApiResponse> result = [];
    for (HistoryApiResponse data in dataList) {
      int day = DateTime.fromMillisecondsSinceEpoch(data.recordedTime).day;
      if (day != dummyDay) {
        dummyDay = day;
        result.add(data);
      }
    }
    return result;
  }


  String getHealthItemImage(String _healthItemUnit, String itemName) {
    String _imgAddress = '';
    if (_healthItemUnit != itemName) {
      switch (itemName) {
        case '심박수':
          _imgAddress = 'images/blooddrop_img.png';
          break;
        case '혈압':
          _imgAddress = 'images/heartgrey_img.png';
          break;
        case '스트레스':
          _imgAddress = 'images/stress_img.png';
          break;
        case '몸무게':
          _imgAddress = 'images/weight_img.png';
          break;
      }
    } else {
      switch (itemName) {
        case '심박수':
          _imgAddress = 'images/blooddrop_black_img.png';
          break;
        case '혈압':
          _imgAddress = 'images/heart_black_img.png';
          break;
        case '스트레스':
          _imgAddress = 'images/stress_black_img.png';
          break;
        case '몸무게':
          _imgAddress = 'images/weight_black_img.png';
          break;
      }
    }
    return _imgAddress;
  }
  String getDateData() {
    String result = '';
    // DateTime now = standardTime;
    switch (wichDate) {
      case '일':
        String dayName = DateFormat('EEEE').format(standardTime);
        switch (dayName) {
          case 'Monday':
            result = '${standardTime.month}월 ${standardTime.day}일 월요일';
            break;
          case 'Tuesday':
            result = '${standardTime.month}월 ${standardTime.day}일 화요일';
            break;
          case 'Wednesday':
            result = '${standardTime.month}월 ${standardTime.day}일 수요일';
            break;
          case 'Thursday':
            result = '${standardTime.month}월 ${standardTime.day}일 목요일';
            break;
          case 'Friday':
            result = '${standardTime.month}월 ${standardTime.day}일 금요일';
            break;
          case 'Saturday':
            result = '${standardTime.month}월 ${standardTime.day}일 토요일';
            break;
          case 'Sunday':
            result = '${standardTime.month}월 ${standardTime.day}일 일요일';
            break;
        }
        break;
      case '주':
        DateTime weekago = standardTime.subtract(Duration(days: 7));
        if (standardTime.year == weekago.year) {
          if (standardTime.month == weekago.month) {
            result = '${standardTime.month}월 ${weekago.day}일-${standardTime.day}일';
          } else {
            result =
            '${weekago.month}월 ${weekago.day}일-${standardTime.month}월 ${standardTime.day}일';
          }
        } else {
          result =
          '${weekago.month}월 ${weekago.day}일-${standardTime.month}월 ${standardTime.day}일';
        }
        break;
      case '월':
        result = '${standardTime.month}월';
        break;
    }
    return result;
  }
  //HealthItemUnit -----------------------------------------------
  List<double> getHealthData(
      String healthUnit, List<HistoryApiResponse> inputData) {
    List<double> result = [];
    for (HistoryApiResponse data in inputData) {
      switch (healthUnit) {
        case '심박수':
          result.add(data.heartRate);
          break;
        case '스트레스':
          result.add(data.stress);
          break;
        case '몸무게':
          result.add(data.weight);
      }
    }
    return result;
  }

  List<double> getSystolicData(List<HistoryApiResponse> inputData) {
    List<double> result = [];
    for (HistoryApiResponse data in inputData) {
      result.add(data.systolic);
    }
    return result;
  }

  List<double> getDiastolicData(List<HistoryApiResponse> inputData) {
    List<double> result = [];
    for (HistoryApiResponse data in inputData) {
      result.add(data.diastolic);
    }
    return result;
  }
  List<String> getTimeData(
      String wichDate, List<HistoryApiResponse> inputData) {
    List<String> result = [];
    for (HistoryApiResponse data in inputData) {
      DateTime dataTime =
      DateTime.fromMillisecondsSinceEpoch(data.recordedTime);
      switch (wichDate) {
        case '일':
          result.add('${dataTime.hour}시 ${dataTime.minute}분');
          break;
        case '주':
          result.add('${dataTime.day}일');
          break;
        case '월':
          result.add('${dataTime.day}일');
          break;
      }
    }
    return result;
  }
  //--------------------------------------------------------
}