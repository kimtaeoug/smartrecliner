import 'dart:developer';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:smartrecliner_flutter/HistoryRestAPI/HApi.dart';
import 'package:smartrecliner_flutter/HistoryRestAPI/HApiResultDto.dart';
import 'package:smartrecliner_flutter/HistoryRestAPI/OnlyUserEmailDto.dart';
import 'package:smartrecliner_flutter/HistoryRestAPI/UserEmailDto.dart';

class NewHistoryProvider with ChangeNotifier{
  final tag = 'NewHistoryProvider';
  HApiResultDto? recentData;
  List<HApiResultDto> monthData;
  DateTime monthTime;
  List<HApiResultDto> weekData;
  DateTime weekTime;
  List<HApiResultDto> dayData;
  DateTime dayTime;
  String wichDate;
  String wichMode;
  bool requestEnd;
  NewHistoryProvider(this.recentData, this.monthData, this.monthTime, this.weekData, this.weekTime, this.dayData, this.dayTime, this.wichDate, this.wichMode, this.requestEnd);
  //일 데이터
  late Isolate _dayIsolate;
  late ReceivePort _dayReceivePort;
  void setDayData(String userEmail, DateTime requestTime) async{
    _dayReceivePort = ReceivePort();
    SendPort _sendPort = _dayReceivePort.sendPort;
    _dayIsolate = await Isolate.spawn(requestSetDayDataByIsolate, [_sendPort, userEmail, requestTime]);
    dayTime = requestTime;
    notifyListeners();
    _dayReceivePort.listen(listenDayData, onDone: (){
      log('Day Data requested', name: tag);
    });
  }
  static void requestSetDayDataByIsolate(List<Object> arguments)async{
    SendPort sendPort = arguments[0] as SendPort;
    String userEmail = arguments[1] as String;
    DateTime time = arguments[2] as DateTime;
    UserEmailDto dummy = UserEmailDto(userEmail: userEmail, requestDate: time);
    List<HApiResultDto> dummyList = [];
    await HApi(Dio(BaseOptions(contentType: "application/json"))).requestHistoryMonth(dummy).then((value){
      List<dynamic> info = value.info as List<dynamic>;
      for(var item in info){
        dummyList.add(HApiResultDto.fromJson(Map<String, dynamic>.from(item)));
      }
      sendPort.send(dummyList);
      dummyList.clear();
    });
  }
  // //_InternalLinkedHashMap<String, dynamic> -> Map<String, dynamic>으로 변환해야함.
  void listenDayData(dynamic data){
    dayData = data as List<HApiResultDto>;
    notifyListeners();
    _dayReceivePort.close();
    _dayIsolate.kill(priority: Isolate.immediate);
  }
  getDayData() => dayData;

  //주 데이터
  late Isolate _weekIsolate;
  late ReceivePort _weekReceivePort;
  void setWeekData(String userEmial, DateTime requestTime) async{
    _weekReceivePort = ReceivePort();
    SendPort _sendPort = _weekReceivePort.sendPort;
    _weekIsolate = await Isolate.spawn(requestSetWeekDataByIsolate, [_sendPort, userEmial, requestTime]);
    weekTime = requestTime;
    notifyListeners();
    _weekReceivePort.listen(listenWeekData, onDone: (){
      log('Week Data requested', name : tag);
    });
  }
  static void requestSetWeekDataByIsolate(List<Object> arguments) async {
    SendPort sendPort = arguments[0] as SendPort;
    String userEmail = arguments[1] as String;
    DateTime time = arguments[2] as DateTime;
    UserEmailDto dummy = UserEmailDto(userEmail: userEmail, requestDate: time);
    List<HApiResultDto> dummyList = [];
    await HApi(Dio(BaseOptions(contentType: "application/json"))).requestHistoryWeek(dummy).then((value){
      List<dynamic> info = value.info as List<dynamic>;
      for(var item in info){
        dummyList.add(HApiResultDto.fromJson(Map<String, dynamic>.from(item)));
      }
      sendPort.send(dummyList);
      dummyList.clear();
    });
  }
  void listenWeekData(dynamic data){
    weekData = data as List<HApiResultDto>;
    notifyListeners();
    _weekReceivePort.close();
    _weekIsolate.kill(priority: Isolate.immediate);
  }
  getWeekData() => weekData;

  //월 데이터
  late Isolate _monthIsolate;
  late ReceivePort _monthReceivePort;
  void setMonthData(String userEmail, DateTime requestTime) async{
    _monthReceivePort = ReceivePort();
    SendPort _sendPort = _monthReceivePort.sendPort;
    _monthIsolate = await Isolate.spawn(requestSetMonthDataByIsolate, [_sendPort, userEmail, requestTime]);
    monthTime = requestTime;
    notifyListeners();
    _monthReceivePort.listen(listenMonthData, onDone: (){
      log('Month Data requested', name: tag);
    });
  }
  static void requestSetMonthDataByIsolate(List<Object> argument) async {
    SendPort sendPort = argument[0] as SendPort;
    String userEmail = argument[1] as String;
    DateTime time = argument[2] as DateTime;
    UserEmailDto dummy = UserEmailDto(userEmail: userEmail, requestDate: time);
    List<HApiResultDto> dummyList = [];
    await HApi(Dio(BaseOptions(contentType: "application/json"))).requestHistoryMonth(dummy).then((value){
      List<dynamic> info = value.info as List<dynamic>;
      for(var item in info){
        dummyList.add(HApiResultDto.fromJson(Map<String, dynamic>.from(item)));
      }
      sendPort.send(dummyList);
      dummyList.clear();
    });
  }
  void listenMonthData(dynamic data){
    monthData = data as List<HApiResultDto>;
    notifyListeners();
    _monthReceivePort.close();
    _monthIsolate.kill(priority: Isolate.immediate);
  }
  getMonthData() => monthData;

  //최신 데이터
  late Isolate _recentIsolate;
  late ReceivePort _recentReceivePort;
  void setRecentData(String userEmail) async{
    _recentReceivePort = ReceivePort();
    SendPort _sendPort = _recentReceivePort.sendPort;
    _recentIsolate = await Isolate.spawn(requestRecentDataByIsolate, [_sendPort, userEmail]);
    _recentReceivePort.listen(listenRecentData, onDone: (){
      log('Recent Data requested', name: tag);
    });
  }
  static void requestRecentDataByIsolate(List<Object> argument)async{
    SendPort sendPort = argument[0] as SendPort;
    String userEmail = argument[1] as String;
    OnlyUserEmailDto dummy = OnlyUserEmailDto(userEmail: userEmail);
    List<HApiResultDto> dummyList = [];
    await HApi(Dio(BaseOptions(contentType: "application/json"))).requestHistoryRecent(dummy).then((value){
      List<dynamic> info = value.info as List<dynamic>;
      for(var item in info){
        dummyList.add(HApiResultDto.fromJson(Map<String, dynamic>.from(item)));
      }
      sendPort.send(dummyList[0]);
      dummyList.clear();
    });
  }
  void listenRecentData(dynamic data){
    recentData = data as HApiResultDto;
    notifyListeners();
    _recentReceivePort.close();
    _recentIsolate.kill(priority: Isolate.immediate);
  }
  getRecentData() => recentData;

  void setWichDate(String dateUnit){
    wichDate = dateUnit;
    notifyListeners();
  }
  getWichDate() => wichDate;

  void setWichMode(String mode){
    wichMode = mode;
    notifyListeners();
  }
  getWichMode() => wichMode;

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
  String getDateData(DateTime _showDateTime) {
    String result = '';
    DateTime now = _showDateTime;
    switch (wichDate) {
      case '일':
        String dayName = DateFormat('EEEE').format(now);
        switch (dayName) {
          case 'Monday':
            result = '${now.month}월 ${now.day}일 월요일';
            break;
          case 'Tuesday':
            result = '${now.month}월 ${now.day}일 화요일';
            break;
          case 'Wednesday':
            result = '${now.month}월 ${now.day}일 수요일';
            break;
          case 'Thursday':
            result = '${now.month}월 ${now.day}일 목요일';
            break;
          case 'Friday':
            result = '${now.month}월 ${now.day}일 금요일';
            break;
          case 'Saturday':
            result = '${now.month}월 ${now.day}일 토요일';
            break;
          case 'Sunday':
            result = '${now.month}월 ${now.day}일 일요일';
            break;
        }
        break;
      case '주':
        DateTime weekago = now.subtract(Duration(days: 7));
        if (now.year == weekago.year) {
          if (now.month == weekago.month) {
            result = '${now.month}월 ${weekago.day}일-${now.day}일';
          } else {
            result =
            '${weekago.month}월 ${weekago.day}일-${now.month}월 ${now.day}일';
          }
        } else {
          result =
          '${weekago.month}월 ${weekago.day}일-${now.month}월 ${now.day}일';
        }
        break;
      case '월':
        result = '${now.month}월';
        break;
    }
    return result;
  }
  List<double> getHealthData(
      String healthUnit, List<HApiResultDto> inputData) {
    List<double> result = [];
    for (HApiResultDto data in inputData) {
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

  List<double> getSystolicData(List<HApiResultDto> inputData) {
    List<double> result = [];
    for (HApiResultDto data in inputData) {
      result.add(data.systolic);
    }
    return result;
  }

  List<double> getDiastolicData(List<HApiResultDto> inputData) {
    List<double> result = [];
    for (HApiResultDto data in inputData) {
      result.add(data.diastolic);
    }
    return result;
  }
  //recent - 2021-06-16T23:28:32.000Z
  //day, week, month - > 2021 5 24
  List<String> getTimeData(String wichDate, List<HApiResultDto> inputData){
    List<String> result = [];
    for(HApiResultDto data in inputData){
      if(wichDate == '일'){
        result.add('${data.recordedTime}시');
      }else{
        List<String> dummy = data.recordedTime.split(' ');
        String day = dummy[2];
        if(wichDate == '월'){
          result.add('$day일');
        }else{
          result.add('$day일');
        }
      }
    }
    return result;
  }
}

