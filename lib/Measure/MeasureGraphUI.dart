import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
class MeasureGraphUI extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _MeasureGraphUI();

}

class _MeasureGraphUI extends State<MeasureGraphUI>{

  //색상
  ReclinerColor _reclinerColor = ReclinerColor();
  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    return Container(
      width: _src.setWidth(292),
      height: _src.setHeight(331),
      child: Stack(
        children: [
          baseLines()
        ],
      )
    );
  }
  Widget baseLines(){
    return Container(
      width: _src.setWidth(292),
      height: _src.setHeight(331),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: _src.setHeight(1),
            width: _src.setWidth(286),
            color: _reclinerColor.grey2,
          ),
          Container(
            height: _src.setHeight(1),
            width: _src.setWidth(286),
            color: _reclinerColor.grey2,
          ),
          Container(
            height: _src.setHeight(1),
            width: _src.setWidth(286),
            color: _reclinerColor.grey2,
          ),
          Container(
            height: _src.setHeight(1),
            width: _src.setWidth(286),
            color: _reclinerColor.grey2,
          ),
          Container(
            height: _src.setHeight(1),
            width: _src.setWidth(286),
            color: _reclinerColor.grey2,
          )
        ],
      ),
    );
  }
  List<int>? getYaxis(String healthItem){
    switch(healthItem){
      case '심박수':
        return [0, 40, 80, 120, 160];
      case '혈압':
        return [0, 55, 110, 165, 220];
      case '스트레스':
        return [0, 25, 50, 75, 100];
      case '몸무게':
        return [0, 50, 100, 150, 200];
    }
  }

}