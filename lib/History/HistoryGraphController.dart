//HistoryGraphController

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

import 'HistoryProvider2.dart';

class HistoryGraphController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HistoryGraphController();
}

class _HistoryGraphController  extends State<HistoryGraphController>{

  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  late HistoryProvider2 _historyProvider;
  late String wichMode;
  String _itemGraph = 'list';
  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _historyProvider = Provider.of<HistoryProvider2>(context);
    wichMode = _historyProvider.getWichMode();
    _itemGraph = wichMode;
    return Stack(
      children: [
        Container(
          width: _src.setWidth(131),
          height: _src.setHeight(40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: _reclinerColor.grey1
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap:(){
                  setState(() {
                    _itemGraph = 'list';
                    _historyProvider.setWichMode('list');
                  });
                },
                child: Image.asset('images/list_gray_img.png', width: _src.setWidth(28), height: _src.setHeight(28),fit: BoxFit.fill,),
              ),
              Container(
                width: _src.setWidth(32),
              ),
              InkWell(
                onTap: (){
                  _itemGraph = 'graph';
                  _historyProvider.setWichMode('graph');
                },
                child: Image.asset('images/graph_icon_gray_img.png', width: _src.setWidth(28), height: _src.setHeight(28),fit: BoxFit.fill,),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              switch(_itemGraph){
                case 'list':
                  _itemGraph = 'graph';
                  _historyProvider.setWichMode('graph');
                  break;
                case 'graph':
                  _itemGraph = 'list';
                  _historyProvider.setWichMode('list');
                  break;
              }
            });
          },
          child: Container(
            width: _src.setWidth(131),
            height: _src.setHeight(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: _src.setWidth(4),
                ),
                Container(
                  width: _src.setWidth(123),
                  child: AnimatedAlign(
                    alignment: _graphItemAlign()!,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: itemGraphUI(_itemGraph),
                  ),
                ),
                Container(
                  width: _src.setWidth(4),
                )
              ],
            ),
          ),
        )
      ],
    );
  }


  AlignmentGeometry? _graphItemAlign(){
    switch(_itemGraph){
      case 'list':
        return Alignment(-1.0, 0.0);
      case 'graph':
        return Alignment(1.0, 0.0);
    }
    return null;
  }
  Widget itemGraphUI(String itemGraph){
    String imgAddress = '';
    setState(() {
      switch(itemGraph){
        case 'list':
          imgAddress = 'images/list_black_img.png';
          break;
        case 'graph':
          imgAddress = 'images/graph_icon_black_img.png';
          break;
      }
    });
    return Container(
      width: _src.setWidth(60),
      height: _src.setHeight(32),
      decoration: BoxDecoration(
        color: _reclinerColor.white1,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imgAddress, width: _src.setWidth(28), height: _src.setHeight(28),fit: BoxFit.fill,)
            ],
          )
        ],
      ),
    );
  }
}
//custom painter
//화면에 직접 UI를 그릴 때 사용.
//직접 UI를 그리려면 CustomPaint와 CustomPainter 클래스가 있어야함.
//canvas, paint, size등을 통해 실제 화면을 그릴 때 사용

//custom paint
//Custom Paint는 Containter나 Center같은 위젯
//Custom Paint는 CustomPaint를 담는 그릇

