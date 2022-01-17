import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/ContextMenu/ContextMenu.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
import '../BleProvider.dart';

class Measuring extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MeasuringUI();
}

class MeasuringUI extends State<Measuring> {
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();
  late BleProvider _bleProvider;
  double percent = 0.0;
  late Timer timer;

  //시간 -- 80초
  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        if(percent < 0.99985){
          percent +=0.000125;
        }else{
          percent = 1;
          timer.cancel();
          Navigator.pushNamed(context, '/MeasureResult');
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    _bleProvider.measureEnd();
    super.dispose();
  }

  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _bleProvider = Provider.of<BleProvider>(context);
    // _bleProvider.measureEnd();
    // _bleProvider.measureStop();
    _src = _screenUtilAPI.getScreenUtil();
    return SafeArea(
        child: WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ContextMenuUI(),
                Container(
                  width: _src.setWidth(12),
                ),
              ],
            ),
            measuringAppbar(),
            Container(
              height: _src.setHeight(130),
            ),
            Container(
              width: _src.setWidth(76),
              height: _src.setHeight(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _src.setWidth(10),
                    height: _src.setHeight(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xff36c0c1)),
                  ),
                  Container(
                    width: _src.setWidth(6),
                  ),
                  Container(
                    width: _src.setWidth(10),
                    height: _src.setHeight(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xff49bcc5)),
                  ),
                  Container(
                    width: _src.setWidth(6),
                  ),
                  Container(
                    width: _src.setWidth(10),
                    height: _src.setHeight(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xff6cb9cd)),
                  ),
                  Container(
                    width: _src.setWidth(6),
                  ),
                  Container(
                    width: _src.setWidth(10),
                    height: _src.setHeight(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xff9ab6d7)),
                  ),
                  Container(
                    width: _src.setWidth(6),
                  ),
                  Container(
                    width: _src.setWidth(10),
                    height: _src.setHeight(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xffdebde9)),
                  )
                ],
              ),
            ),
            Container(
              height: _src.setHeight(5),
            ),
            Container(
              width: _src.setWidth(232),
              height: _src.setHeight(32),
              child: Text(
                '측정 중입니다.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _src.setSp(23),
                    color: _reclinerColor.dark1),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: _src.setHeight(32),
            ),
            InkWell(
              child: reclinerProgressIndicator(),
              onTap: () {
                Navigator.pushNamed(context, '/MeasureResult');
              },
            ),
            Container(
              height: _src.setHeight(48),
            ),
            Container(
              width: _src.setWidth(232),
              height: _src.setHeight(48),
              child: Text(
                '측정 중에는 등과 허벅지를 \n 리클라이너에 편하게 기대주세요.',
                style: TextStyle(
                    fontSize: _src.setSp(15),
                    color: _reclinerColor.dark1),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget measuringAppbar() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0.01,
            blurRadius: 1,
            offset: Offset(0.0, 2.0))
      ]),
      height: _src.setHeight(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: _src.setWidth(18),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'images/back_img.png',
                  width: _src.setWidth(32),
                  height: _src.setHeight(32),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: _src.setWidth(98),
              ),
              Container(
                width: _src.setWidth(64),
                child: Text(
                  '건강측정',
                  style: TextStyle(
                      fontSize: _src.setSp(15),
                      color: _reclinerColor.dark1,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget reclinerProgressIndicator() {
    return SizedBox(
      width: _src.setWidth(190),
      height: _src.setHeight(190),
      child: CircularPercentIndicator(
        backgroundColor: _reclinerColor.grey1,
        radius: _src.setWidth(187),
        lineWidth: _src.setWidth(35),
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff00c1b4), Color(0xffd9b1e5)]),
        circularStrokeCap: CircularStrokeCap.round,
        percent: percent.toDouble(),
        center: Container(
          width: _src.setWidth(58),
          height: _src.setHeight(65),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(percent*100).ceil()}%',
                  style: TextStyle(
                      fontSize: _src.setSp(21),
                      fontWeight: FontWeight.bold,
                      color: _reclinerColor.dark1),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: _src.setHeight(1),
                ),
                Text(
                  '완료',
                  style: TextStyle(
                      fontSize: _src.setSp(20),
                      color: _reclinerColor.dark2),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
