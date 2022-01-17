import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';
class HistoryProvider with ChangeNotifier {
  List<HistoryApiResponse> data;
  String wichDate;
  String wichMode;
  List<HistoryApiResponse> monthData;
  List<HistoryApiResponse> weekData;
  List<HistoryApiResponse> dayData;

  HistoryProvider(this.data, this.wichDate, this.wichMode, this.monthData,
      this.weekData, this.dayData);

  void requestSetMonthData(List<HistoryApiResponse> inputData) {
    monthData = inputData;
    notifyListeners();
  }

  requestGetMonthData() => monthData;

  void requestSetWeekData(List<HistoryApiResponse> inputData) {
    weekData = inputData;
    notifyListeners();
  }

  requestGetWeekData() => weekData;

  void requestSetDayData(List<HistoryApiResponse> inputData) {
    dayData = inputData;
    notifyListeners();
  }

  requestGetDayData() => dayData;

  void setHistoryData(List<HistoryApiResponse> inputData) {
    data = inputData;
    notifyListeners();
  }

  getHistoryData() => data;

  void setWichDate(String dateUnit) {
    wichDate = dateUnit;
    notifyListeners();
  }

  getWichDate() => wichDate;

  void setWichMode(String mode) {
    wichMode = mode;
    notifyListeners();
  }

  getWichMode() => wichMode;

  List<HistoryApiResponse> getMonthData(List<HistoryApiResponse> inputData) {
    return justDifferent(inputData);
  }

  List<HistoryApiResponse> getWeekData(
      List<HistoryApiResponse> inputData, DateTime comDate) {
    List<HistoryApiResponse> result = [];
    // DateTime now = DateTime.now();
    List<HistoryApiResponse> processedData = justDifferent(inputData);
    for (HistoryApiResponse data in processedData) {
      DateTime dataTime =
          DateTime.fromMillisecondsSinceEpoch(data.recordedTime);
      if (comDate.difference(dataTime).inDays <= 7) {
        result.add(data);
      }
    }
    return result;
  }

  List<HistoryApiResponse> getDayData(
      List<HistoryApiResponse> inputData, DateTime comDate) {
    List<HistoryApiResponse> result = [];
    for (HistoryApiResponse data in inputData) {
      int day = DateTime.fromMillisecondsSinceEpoch(data.recordedTime).day;
      if (comDate.day == day) {
        result.add(data);
      }
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

  List<HistoryApiResponse> processOverlappingData(
      List<HistoryApiResponse> inputData) {
    List<HistoryApiResponse> result = [];
    DateTime dummyTime = DateTime(1);
    late List<HistoryApiResponse> dummyDataList = [];
    for (HistoryApiResponse data in inputData) {
      DateTime time = DateTime.fromMillisecondsSinceEpoch(data.recordedTime);
      // 동일하다면
      if (dummyTime.hour == time.hour && dummyTime.minute == time.minute) {
        //평균 내야할 곳
        dummyDataList.add(data);
      }
      //다르면
      else {
        dummyTime = time;
        if (dummyDataList.length > 1) {
          result.add(processAvgHistoryData(dummyDataList));
        }
        result.add(data);
        dummyDataList = [];
      }
    }
    return result;
  }

  //평균 내주는 함수
  HistoryApiResponse processAvgHistoryData(List<HistoryApiResponse> inputData) {
    int lengthInputData = inputData.length;
    int recordedTime = 0;
    int uniqueID = 0;
    double dummyStress = 0.0;
    double dummyHeartRate = 0.0;
    double dummySystolic = 0.0;
    double dummyDiastolic = 0.0;
    double dummyWeight = 0.0;
    for (HistoryApiResponse data in inputData) {
      recordedTime = data.recordedTime;
      uniqueID = data.uniqueID;
      dummyStress += data.stress;
      dummyHeartRate += data.heartRate;
      dummySystolic += data.systolic;
      dummyDiastolic += data.diastolic;
      dummyWeight += data.weight;
    }
    return HistoryApiResponse(
        recordedTime: recordedTime,
        uniqueID: uniqueID,
        stress: dummyStress / lengthInputData,
        heartRate: dummyHeartRate / lengthInputData,
        systolic: dummySystolic / lengthInputData,
        diastolic: dummyDiastolic / lengthInputData,
        weight: dummyWeight / lengthInputData);
  }

  //날짜 동일하면
  List<HistoryApiResponse> getAvgHistoryData(
      List<HistoryApiResponse> dataList) {
    List<HistoryApiResponse> resultData = [];
    Map<int, List<HistoryApiResponse>> mapData = Map();
    for (HistoryApiResponse data in dataList) {
      int day = DateTime.fromMillisecondsSinceEpoch(data.recordedTime).day;
      if (mapData[day] == null) {
        mapData[day] = [];
      }
      mapData[day]!.add(data);
    }
    for (List<HistoryApiResponse> value in mapData.values) {
      resultData.add(processAvgHistoryData(value));
    }
    return resultData;
  }

  //다른 날짜만
  List<HistoryApiResponse> justDifferent(List<HistoryApiResponse> dataList) {
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
}
