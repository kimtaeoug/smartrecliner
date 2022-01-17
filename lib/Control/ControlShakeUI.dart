import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/Control/ShakeMultiSwitch.dart';
import 'package:smartrecliner_flutter/Control/ShakeProvider.dart';
import 'package:smartrecliner_flutter/Protocol/BleProtocol.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
import 'package:smartrecliner_flutter/BleProvider.dart';
class ControlShakeUI extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ControlShakeUI();

}

class _ControlShakeUI extends State<ControlShakeUI>{

  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  late bool _isChecked;
  late ShakeProvider _shakeProvider;
  late DateTime _shakeTime;


  //differ time
  String _refinedShakeTime = '시간 x';
  //heat time timer
  late Timer _shakeTimer;
  @override
  void initState() {
    super.initState();
    differNowShakeTime(true);
  }
  @override
  void dispose() {
    _shakeTimer.cancel();
    differNowShakeTime(false);
    super.dispose();
  }
  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  late BleProvider _bleProvider;
  BleProtocol _bleProtocol = BleProtocol();
  late int? _itemIndex;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _shakeProvider = Provider.of<ShakeProvider>(context);
    _bleProvider = Provider.of<BleProvider>(context);
    _shakeTime = _shakeProvider.getShakeTime();
    _isChecked = _shakeProvider.getShakeCheck();
    _itemIndex = _shakeProvider.getItemIndex();
    if(_isChecked == null){
      _isChecked = false;
    }
    return Stack(
      children: [
        Opacity(
          opacity: 0.7,
          child: Container(
              width: _src.setWidth(331),
              height: _src.setHeight(412),
              decoration: BoxDecoration(
                  color: _reclinerColor.white2,
                  borderRadius: BorderRadius.all(Radius.circular(30)))),
        ),
        Container(
          height: _src.setHeight(412),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: _src.setHeight(75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '흔들',
                      style: TextStyle(color: _reclinerColor.dark1),
                    ),
                    Container(
                      width: _src.setWidth(184),
                    ),
                    Container(
                      width: _src.setWidth(77),
                      height: _src.setHeight(36),
                      child: FlutterSwitch(
                        width: _src.setWidth(77),
                        height: _src.setHeight(36),
                        valueFontSize: _src.setSp(10),
                        duration: Duration(milliseconds: 300),
                        toggleSize: _src.setHeight(30),
                        value: _isChecked,
                        padding: _src.setWidth(4),
                        borderRadius: 30.0,
                        showOnOff: true,
                        activeColor: _reclinerColor.turquoise.withOpacity(0.1),
                        activeText: 'ON',
                        activeTextColor: _reclinerColor.thickedGreenColor,
                        activeTextFontWeight: FontWeight.normal,
                        activeToggleColor: _reclinerColor.thickedGreenColor,
                        inactiveText: 'OFF',
                        inactiveTextColor: _reclinerColor.dark2,
                        inactiveTextFontWeight: FontWeight.normal,
                        inactiveColor: _reclinerColor.grey,
                        inactiveToggleColor: _reclinerColor.dark2,
                        onToggle: (val) {
                          setState(() {
                            shakeCheck(val);
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: _src.setHeight(1),
                color: _reclinerColor.modeSideColor,
              ),
              Container(
                height: _src.setHeight(31),
              ),
              ShakeMutliSwitch(),
              Container(
                height: _src.setHeight(40),
              ),
              shakeTime()
            ],
          ),
        )
      ],
    );
  }
  Widget shakeTime() {
    if (_isChecked) {
      return Container(
        width: _src.setWidth(263),
        height: _src.setHeight(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _refinedShakeTime != '시간 x' ? '$_refinedShakeTime' : '시간 x',
                  style: TextStyle(
                      color: _reclinerColor.primary2,
                      fontSize: _src.setSp(20)),
                ),
                Container(
                  width: _src.setWidth(12),
                ),
                InkWell(
                  child: Image.asset(
                    'images/reset_img.png',
                    width: _src.setWidth(24),
                    height: _src.setHeight(24),
                    fit: BoxFit.fill,
                  ),
                  onTap: (){
                    setState(() {
                      _shakeProvider.setShakeTime(DateTime(1996));
                      _refinedShakeTime = '시간 x';
                      _bleProvider.sendToData(_bleProtocol.getMoving('off'));
                    });
                  },
                )
              ],
            ),
            Container(
              height: _src.setHeight(14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                shakeTimeItem(1),
                Container(
                  width: _src.setWidth(4),
                ),
                shakeTimeItem(5),
                Container(
                  width: _src.setWidth(4),
                ),
                shakeTimeItem(10)
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
        width: _src.setWidth(263),
        height: _src.setHeight(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _refinedShakeTime != '시간 x' ? '$_refinedShakeTime' : '시간 x',
                  style: TextStyle(
                      color: _reclinerColor.grey3,
                      fontSize: _src.setSp(20)),
                ),
                Container(
                  width: _src.setWidth(12),
                ),
                Image.asset(
                  'images/reset_grey_img.png',
                  width: _src.setWidth(24),
                  height: _src.setHeight(24),
                  fit: BoxFit.fill,
                )
              ],
            ),
            Container(
              height: _src.setHeight(14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                shakeTimeItem(1),
                Container(
                  width: _src.setWidth(4),
                ),
                shakeTimeItem(5),
                Container(
                  width: _src.setWidth(4),
                ),
                shakeTimeItem(10)
              ],
            )
          ],
        ),
      );
    }
  }

  Widget shakeTimeItem(int time) {
    if (_isChecked) {
      return Container(
        width: _src.setWidth(85),
        height: _src.setHeight(50),
        child: InkWell(
          onTap: (){
            setState(() {
              calShakeTime(time);
              if(_shakeTime != DateTime(1996)){
                if(_itemIndex != null){
                  _bleProvider.sendToData(_bleProtocol.getMoving(_itemIndex.toString()));
                }else{
                  _bleProvider.sendToData(_bleProtocol.getMoving('1'));
                }
              }
            });
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: _reclinerColor.turquoise),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '+ $time분',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: _src.setSp(20)),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: _src.setWidth(85),
        height: _src.setHeight(50),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: _reclinerColor.grey3),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+ $time분',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: _src.setSp(20)),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      );
    }
  }

  void shakeCheck(bool value) {
    _isChecked = value;
    _shakeProvider.setShakeChecked(_isChecked);
  }


  void calShakeTime(int time) {
    if (_shakeTime.year == DateTime(1996).year) {
      _shakeTime = DateTime.now().add(Duration(minutes: time));
      _shakeProvider.setShakeTime(_shakeTime);
      differNowShakeTime(true);
    }else{
      _shakeTime = _shakeTime.add(Duration(minutes: time));
      _shakeProvider.setShakeTime(_shakeTime);
      differNowShakeTime(true);
    }
  }

  void differNowShakeTime(bool mode){
    _shakeTimer = Timer.periodic(Duration(seconds: 1), (v) {
      if(mode){
        if(_shakeTime.second > 0){
          DateTime now = DateTime.now();
          if(_shakeTime.difference(now).inSeconds > 0){
            secondToMinute(_shakeTime.difference(now).inSeconds);
          }else{
            _shakeProvider.setShakeTime(DateTime(1996));
            _refinedShakeTime = '시간 x';
            _bleProvider.sendToData(_bleProtocol.getMoving('off'));
          }
        }
      }else{
        v.cancel();
      }
    });
  }
  void secondToMinute(int second){
    if(mounted == true){
      setState(() {
        _refinedShakeTime = '${second ~/ 60}분 ${second % 60}초';
      });
    }
  }
}