import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/Measure/HistoryProvider.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
class HistoryControlDate extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HistoryControlDate();
}

class _HistoryControlDate extends State<HistoryControlDate>{

  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  String _dateItem = '일';
  //방향
  double direction = 0;
  late HistoryProvider _historyProvider;

  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _historyProvider = Provider.of<HistoryProvider>(context);
    _dateItem = _historyProvider.getWichDate();
    return Stack(
      children: [
        Container(
          width: _src.setWidth(172),
          height: _src.setHeight(40),
          decoration: BoxDecoration(
            color: _reclinerColor.grey1,
            borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap:(){
                  setState(() {
                    _dateItem = '일';
                    _historyProvider.setWichDate('일');
                  });
                },
                child: Text('일',style: TextStyle(fontSize: _src.setSp(11), color: _reclinerColor.dark2),),
              ),
              Container(
                width: _src.setWidth(43),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    _dateItem = '주';
                    _historyProvider.setWichDate('주');
                  });
                },
                child: Text('주',style: TextStyle(fontSize: _src.setSp(11), color: _reclinerColor.dark2),),
              ),
              Container(
                width: _src.setWidth(43),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    _dateItem = '월';
                    _historyProvider.setWichDate('월');
                  });
                },
                child: Text('월',style: TextStyle(fontSize: _src.setSp(11), color: _reclinerColor.dark2),),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              switch(_dateItem){
                case '일':
                  _dateItem = '주';
                  _historyProvider.setWichDate('주');
                  break;
                case '월':
                  _dateItem = '주';
                  _historyProvider.setWichDate('주');
                  break;
              }
            });
          },
          onHorizontalDragUpdate: (DragUpdateDetails details){
            setState(() {
              direction = details.delta.dx;
              switch(_dateItem){
                case '주':
                  if(direction > 0){
                    _dateItem = '월';
                    _historyProvider.setWichDate('월');
                  }else{
                    _dateItem = '일';
                    _historyProvider.setWichDate('일');
                  }
                  break;
              }
            });
          },
          child: Container(
            width: _src.setWidth(172),
            height: _src.setHeight(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: _src.setWidth(4),
                ),
                Container(
                  width: _src.setWidth(164),
                  child: AnimatedAlign(
                    alignment: _dateItemAlign()!,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: dateItemUI(_dateItem),
                  ),
                )
              ],
            ),
          ),
        )

      ],
    );
  }
  AlignmentGeometry? _dateItemAlign(){
    switch(_dateItem){
      case '일':
        return Alignment(-1.0, 0.0);
      case '주':
        return Alignment.center;
      case '월':
        return Alignment(1.0, 0.0);
    }
    return null;
  }
  Widget dateItemUI(String dateItem){
    return Container(
      width: _src.setWidth(56),
      height: _src.setHeight(32),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: _reclinerColor.white1
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(dateItem, style: TextStyle(fontSize: _src.setSp(11),color: _reclinerColor.dark1),)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}