import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/History/NewHistoryProvider.dart';
import 'package:smartrecliner_flutter/MainPage.dart';
import 'package:smartrecliner_flutter/UISupport/CustomDialogBox.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

import 'UISupport/ReclinerColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashPageUI();
  }
}
class SplashPageUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageUI();
}

class _SplashPageUI extends State<SplashPageUI> {
  late MediaQueryData deviceData;
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  late NewHistoryProvider _newHistoryProvider;
  @override
  void initState() {
    super.initState();
    //CotrolUI
    Timer(Duration(seconds: 3), ()=>Navigator.pushNamed(context, '/BLEScanBlue'));
    // Timer(Duration(seconds: 3), () => bleConnectCheck());
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   _newHistoryProvider = Provider.of<NewHistoryProvider>(context, listen : false);
    //   _newHistoryProvider.setDayData('test', DateTime.now());
    // });
    // Timer(Duration(seconds: 3), () => Navigator.pushNamed(context,'/Main'));

  }
  late ScreenUtilAPI _screenUtilAPI;
  late ScreenUtil _scr;
  @override
  Widget build(BuildContext context) {
    deviceData = MediaQuery.of(context);
    _screenUtilAPI = ScreenUtilAPI();
    _screenUtilAPI.deviceWidth =  deviceData.size.width;
    _screenUtilAPI.deviceHeight = deviceData.size.height;
    _scr = _screenUtilAPI.getScreenUtil();
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: _reclinerColor.turquoise,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _scr.setWidth(252),
                child: Text(
                  '나를 위한 케어',
                  style: TextStyle(
                      fontSize: _scr.setSp(20),
                      fontWeight: FontWeight.bold,
                      color: _reclinerColor.white1),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                height: _scr.setHeight(17),
              ),
              Container(
                width: _scr.setWidth(252),
                child: Text('자코모',
                    style: TextStyle(
                        fontSize: _scr.setSp(42),
                        color: _reclinerColor.white1,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
              ),
              Container(
                height: _scr.setHeight(8),
              ),
              Container(
                width: _scr.setWidth(252),
                child: Text('스마트',
                    style: TextStyle(
                        fontSize: _scr.setSp(42),
                        color: _reclinerColor.white1,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
              ),
              Container(
                height: _scr.setHeight(8),
              ),
              Container(
                width: _scr.setWidth(252),
                child: Text('리클라이너',
                    style: TextStyle(
                        fontSize: _scr.setSp(42),
                        color: _reclinerColor.white1,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
              ),
              Container(
                height: _scr.setWidth(244),
              )
            ],
          ),
        ),
      ),
    );
  }

  void bleConnectCheck() {
    showDialog(
        context: context,
        builder: (context) => CustomDialogBox(
            key: null,
            mode: '리클라이너 연결',
            title: '리클라이너 연결',
            contents: '연결을 위해 블루투스가 켜져있는지 확인 후,\n해당 리클라이너 모델을 연결해주세요',
            noText: '종료하기',
            yesText: '확인'));
  }
}
