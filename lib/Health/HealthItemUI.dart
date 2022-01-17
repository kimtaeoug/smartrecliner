import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
import 'package:smartrecliner_flutter/Api/HistoryAPI.dart';
import 'dart:isolate';
class HealthItemUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _HealthItemUI();
}

class _HealthItemUI extends State<HealthItemUI> {
  // final Future<HistoryApiResponse> data;
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  late HistoryApiResponse? requestRecentData;
  late Isolate _isolate;
  late ReceivePort _receivePort;
  void initRequestRecent() async{
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(requestRecentByIsolate, _receivePort.sendPort);
    _receivePort.listen(setRequestRecentData, onDone: (){
      print('setRequestRecentData done');
    });
  }
  static void requestRecentByIsolate(SendPort sendPort)async{
    await HistoryAPI(Dio(BaseOptions(contentType: "application/json"))).getRecent().then((value){
      sendPort.send(value);
    });
  }
  void setRequestRecentData(dynamic data){
    setState(() {
      requestRecentData = data;
    });
    _receivePort.close();
    _isolate.kill(priority: Isolate.immediate);
  }
  @override
  void initState() {
    requestRecentData = null;
    initRequestRecent();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    return requestRecentData != null?
        healthItemStructure(requestRecentData!):
        blankHealthData();
  }
  Widget blankHealthData(){
    return Container(
      width: _src.setWidth(324),
      height: _src.setHeight(172),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: _reclinerColor.white1,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0.01,
                blurRadius: 1,
                offset: Offset(-1.5, 2.0))
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/healthnodata_img.png', width: _src.setWidth(72), height: _src.setHeight(65),fit: BoxFit.fill,),
          Container(
            height: _src.setHeight(11),
          ),
          Text('측정된 데이터가 없습니다.', style: TextStyle(fontSize: _src.setSp(8), color: _reclinerColor.dark2),),
          Container(
            height: _src.setHeight(1),
          ),
          Text('\'건강측정\'버튼을 누르면 측정 할 수 있어요.',style: TextStyle(fontSize: _src.setSp(6),color: _reclinerColor.dark2),)
        ],
      ),
    );
  }
  Widget healthItemStructure(HistoryApiResponse data) {
    return Container(
      width: _src.setWidth(324),
      height: _src.setHeight(172),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _reclinerColor.modeSideColor),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0.01,
                blurRadius: 1,
                offset: Offset(-1.5, 2.0))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: _src.setWidth(29),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: _src.setHeight(20),
              ),
              Container(
                width: _src.setWidth(65),
                height: _src.setHeight(36),
                child: Text(
                  calculateDateTime(data.recordedTime),
                  style: TextStyle(
                      fontSize: _src.setSp(11),
                      color: _reclinerColor.modeDetailTextColor),
                ),
              ),
            ],
          ),
          Container(
            width: _src.setWidth(20),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: _src.setHeight(20),
              ),
              //심박수
              SizedBox(
                width: _src.setWidth(200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: _src.setWidth(25),
                      height:
                          _src.setHeight(25),
                      child: Image.asset(
                        'images/heartgrey_img.png',
                        width:
                            _src.setWidth(25),
                        height: _src.setHeight(
                            25),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Container(
                      width: _src.setWidth(40),
                      height:
                          _src.setHeight(20),
                      child: Text(
                        '심박수',
                        style: TextStyle(
                            fontSize: _src.setSp(13)),
                      ),
                    ),
                    Container(
                      width: _src.setWidth(25),
                    ),
                    Container(
                      child: Text(
                        data.heartRate.toInt().toString(),
                        style: TextStyle(
                            fontSize: _src.setSp(14),
                            color: _reclinerColor.turquoise,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Text(
                      'bpm',
                      style: TextStyle(
                          fontSize: _src.setSp(13),
                          color: _reclinerColor.modeDetailTextColor),
                    )
                  ],
                ),
              ),
              Container(
                height: _src.setHeight(12),
              ),
              //혈압
              SizedBox(
                width: _src.setWidth(200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: _src.setWidth(25),
                      height:
                          _src.setHeight(25),
                      child: Image.asset(
                        'images/blooddrop_img.png',
                        width:
                            _src.setWidth(25),
                        height: _src.setHeight(
                            25),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Container(
                      width: _src.setWidth(40),
                      height:
                          _src.setHeight(20),
                      child: Text(
                        '혈압',
                        style: TextStyle(
                            fontSize: _src.setSp(13)),
                      ),
                    ),
                    Container(
                      width: _src.setWidth(25),
                    ),
                    Container(
                      child: Text(
                        '${data.systolic.toInt()} / ${data.diastolic.toInt()}',
                        style: TextStyle(
                            fontSize: _src.setSp(10),
                            color: _reclinerColor.bloodTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Text(
                      'mmHg',
                      style: TextStyle(
                          fontSize: _src.setSp(10),
                          color: _reclinerColor.modeDetailTextColor),
                    )
                  ],
                ),
              ),
              Container(
                height: _src.setHeight(12),
              ),
              SizedBox(
                width: _src.setWidth(200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: _src.setWidth(25),
                      height:
                          _src.setHeight(25),
                      child: Image.asset(
                        'images/stress_img.png',
                        width:
                            _src.setWidth(25),
                        height: _src.setHeight(
                            25),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Container(
                      width: _src.setWidth(60),
                      height:
                          _src.setHeight(20),
                      child: Text(
                        '스트레스',
                        style: TextStyle(
                            fontSize: _src.setSp(
                                13)),
                      ),
                    ),
                    Container(
                      width: _src.setWidth(8),
                    ),
                    Container(
                      child: Text(
                        data.stress.toInt().toString(),
                        style: TextStyle(
                            fontSize: _src.setSp(
                                14),
                            color: _reclinerColor.turquoise,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                  ],
                ),
              ),
              Container(
                height: _src.setHeight(12),
              ),
              SizedBox(
                width: _src.setWidth(200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: _src.setWidth(25),
                      height:
                          _src.setHeight(25),
                      child: Image.asset(
                        'images/weight_img.png',
                        width:
                            _src.setWidth(25),
                        height: _src.setHeight(
                            25),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Container(
                      width: _src.setWidth(40),
                      height:
                          _src.setHeight(20),
                      child: Text(
                        '몸무게',
                        style: TextStyle(
                            fontSize: _src.setSp(
                                13)),
                      ),
                    ),
                    Container(
                      width: _src.setWidth(25),
                    ),
                    Container(
                      child: Text(
                        data.weight.toInt().toString(),
                        style: TextStyle(
                            fontSize: _src.setSp(
                                14),
                            color: _reclinerColor.turquoise,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Text(
                      'kg',
                      style: TextStyle(
                          fontSize: _src.setSp(
                              13),
                          color: _reclinerColor.modeDetailTextColor),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  String calculateDateTime(int time){
    String result = '';
    DateTime calDate = DateTime.fromMillisecondsSinceEpoch(time);
    result = '${calDate.year}/${calDate.month}/${calDate.day} \n ${calDate.hour}:${calDate.minute}';
    return result;
  }
}
