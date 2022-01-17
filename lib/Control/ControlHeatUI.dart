import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
import 'package:smartrecliner_flutter/Protocol/BleProtocol.dart';
import '../BleProvider.dart';
import 'HeatProvider.dart';
import 'HeatMultiSwitch.dart';

class ControlHeatUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _ControlHeatUI();
}

class _ControlHeatUI extends State<ControlHeatUI> {
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  late bool _isChecked;
  late HeatProvider _heatProvider;
  late DateTime _heatTime;

  //differ time
  late String _refinedHeatTime = '시간 x';

  //heat time timer
  late Timer? _heatTimer;

  @override
  void initState() {
    super.initState();
    differNowHeatTime(true);
  }

  @override
  void dispose() {
    if(_heatTimer != null){
      _heatTimer!.cancel();
      print('heattimer is cancel()');
    }
    differNowHeatTime(false);
    _heatTimer = null;
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
    _heatProvider = Provider.of<HeatProvider>(context);
    _bleProvider = Provider.of<BleProvider>(context);
    _heatTime = _heatProvider.getHeatTime();
    _itemIndex = _heatProvider.getItemIndex();
    _isChecked = _heatProvider.getHeatCheck();
    if (_isChecked == null) {
      _isChecked = false;
    }
    // Isolate.spawn(differNowHeatTime,DateTime.now());
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
                      '온열',
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
                        duration: Duration(milliseconds: 300),
                        valueFontSize: _src.setSp(10),
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
                            heatCheck(val);
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
              HeatMultiSwitch(),
              Container(
                height: _src.setHeight(40),
              ),
              heatTime()
            ],
          ),
        )
      ],
    );
  }

  Widget heatTime() {
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
                  _refinedHeatTime != '시간 x' ? '$_refinedHeatTime' : '시간 x',
                  style: TextStyle(
                      color: _reclinerColor.primary2,
                      fontSize: _src.setSp(20)),
                ),
                Container(
                  width: _src.setWidth(12),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _heatProvider.setHeatTime(DateTime(1996));
                      _refinedHeatTime = '시간 x';
                      _bleProvider.sendToData(_bleProtocol.getHeap('off'));
                    });
                  },
                  child: Image.asset(
                    'images/reset_img.png',
                    width: _src.setWidth(24),
                    height: _src.setHeight(24),
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
            Container(
              height: _src.setHeight(14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                heatTimeItem(1),
                Container(
                  width: _src.setWidth(4),
                ),
                heatTimeItem(5),
                Container(
                  width: _src.setWidth(4),
                ),
                heatTimeItem(10)
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
                  _refinedHeatTime != '시간 x' ? '$_refinedHeatTime' : '시간 x',
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
                heatTimeItem(1),
                Container(
                  width: _src.setWidth(4),
                ),
                heatTimeItem(5),
                Container(
                  width: _src.setWidth(4),
                ),
                heatTimeItem(10)
              ],
            )
          ],
        ),
      );
    }
  }

  Widget heatTimeItem(int time) {
    if (_isChecked) {
      return Container(
        width: _src.setWidth(85),
        height: _src.setHeight(50),
        child: InkWell(
          onTap: () {
            setState(() {
              calHeatTime(time);
              if(_heatTime != DateTime(1996)){
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
                            fontSize:
                                _src.setSp(20)),
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
                          fontSize:
                              _src.setSp(20)),
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

  void heatCheck(bool value) {
    _isChecked = value;
    _heatProvider.setHeatChecked(_isChecked);
  }

  void calHeatTime(int time) {
    if (_heatTime == DateTime(1996)) {
      _heatTime = DateTime.now().add(Duration(minutes: time));
      _heatProvider.setHeatTime(_heatTime);
      differNowHeatTime(true);
    } else {
      _heatTime = _heatTime.add(Duration(minutes: time));
      _heatProvider.setHeatTime(_heatTime);
      differNowHeatTime(true);
    }
  }

  //now - 2021-05-17 16:47:48.681272
  //differenc - 0:09:58.987871
  void differNowHeatTime(bool mode) {
    _heatTimer = Timer.periodic(Duration(seconds: 1), (v) {
      if(mode){
        if(_heatTime.second > 0){
          DateTime now = DateTime.now();
          if(_heatTime.difference(now).inSeconds > 0){
            secondToMinute(_heatTime.difference(now).inSeconds);
          }else{
            _heatProvider.setHeatTime(DateTime(1996));
            _refinedHeatTime = '시간 x';
            _bleProvider.sendToData(_bleProtocol.getHeap('off'));
          }
        }
      }else{
        v.cancel();
      }
    });
  }
  Future<void> cancelHeatTimer()async{
    if(_heatTimer != null){
      _heatTimer!.cancel();
    }
  }

  //mounted - 모든 위젯은 bool형식의 this.mounted 속성을 갖고 있으며, buildContext가 할당되면 true를 리턴함.
  //(위젯이 unmounted 상태일 때 setState를 호출하면 error가 발생함.)
  void secondToMinute(int second) {
    if(mounted == true){
      setState(() {
        _refinedHeatTime = '${second ~/ 60}분 ${second % 60}초';
      });
    }
  }
}
