import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/Control/ControlAttributeUI.dart';
import 'package:smartrecliner_flutter/Control/ControlShakeUI.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/Control/RemoteContolProvider.dart';
import 'package:smartrecliner_flutter/Control/ShakeProvider.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
import 'ControlHeatUI.dart';
import 'HeatProvider.dart';

class ControlUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ControlUI();
}

class _ControlUI extends State<ControlUI> {


  //Remote Control
  late RemoteContolProvider _remoteContolProvider;

  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  String _selectedMode = '자세';
  late HeatProvider _heatProvider;
  late ShakeProvider _shakeProvider;
  late bool _heatOn;
  late bool _shakeOn;

  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src = _screenUtilAPI.getScreenUtil();

  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _remoteContolProvider = Provider.of<RemoteContolProvider>(context);
    _heatProvider = Provider.of<HeatProvider>(context);
    _heatOn = _heatProvider.getHeatOn();
    _shakeProvider = Provider.of<ShakeProvider>(context);
    _shakeOn = _shakeProvider.getShakeOn();
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Opacity(
          opacity: 0.9,
          child: Container(
            height: _src.setHeight(113),
            decoration: BoxDecoration(
                color: _reclinerColor.modeSideColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: _src.setHeight(113),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: _src.setHeight(16),
                      ),
                      closeButton(),
                      topNaviagtion(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: _src.setHeight(582),
          decoration: BoxDecoration(
            color: _reclinerColor.modeSideColor
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: _src.setHeight(17),
              ),
              Container(
                width: _src.setWidth(331),
                height: _src.setHeight(412),
                child: selectMode(_selectedMode),
              ),
              Container(
                height: _src.setHeight(28),
              ),
              Container(
                width: _src.setWidth(234),
                height: _src.setHeight(60),
                decoration: BoxDecoration(
                    border: Border.all(color: _reclinerColor.turquoise),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '자세 초기화 + 모든 기능 종료',
                      style: TextStyle(
                          color: _reclinerColor.turquoise,
                          fontSize: _src.setSp(14),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
  Widget topNaviagtion(){
    return Container(
      height: _src.setHeight(65),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              width: _src.setWidth(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _selectedMode == '자세'
                      ? Image.asset(
                    'images/position_seat_img.png',
                    width: _src.setWidth(
                        40),
                    height: _src.setHeight(
                        40),
                    fit: BoxFit.fill,
                  )
                      : Image.asset(
                    'images/position_seat_grey_img.png',
                    width: _src.setWidth(
                        40),
                    height: _src.setHeight(
                        40),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    height:
                    _src.setHeight(1),
                  ),
                  Container(
                      width:
                      _src.setWidth(40),
                      height: _src.setHeight(
                          16),
                      child: Text(
                        '자세',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: _src.setSp(9)),
                      ))
                ],
              ),
            ),
            onTap: () {
              setState(() {
                _selectedMode = '자세';
              });
            },
          ),
          Container(
            width: _src.setWidth(64),
          ),
          InkWell(
            child: Container(
              width: _src.setWidth(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //_isheat?'images/point_img.png':'images/point_grey_img.png',
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        _heatOn
                            ? 'images/point_img.png'
                            : 'images/point_grey_img.png',
                        width: _src.setWidth(
                            6),
                        height: _src.setHeight(
                            6),
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                  Container(
                    height:
                    _src.setHeight(2),
                  ),
                  _selectedMode == '온열'
                      ? Image.asset(
                    'images/heat_seat_img.png',
                    width: _src.setWidth(
                        40),
                    height: _src.setHeight(
                        40),
                    fit: BoxFit.fill,
                  )
                      : Image.asset(
                    'images/heat_seat_grey_img.png',
                    width: _src.setWidth(
                        40),
                    height: _src.setHeight(
                        40),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    height:
                    _src.setHeight(1),
                  ),
                  Container(
                    width:
                    _src.setWidth(40),
                    height:
                    _src.setHeight(16),
                    child: Text(
                      '온열',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: _src.setSp(9)),
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              setState(() {
                _selectedMode = '온열';
              });
            },
          ),
          Container(
            width: _src.setWidth(64),
          ),
          InkWell(
            child: Container(
              width: _src.setWidth(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        _shakeOn
                            ? 'images/point_img.png'
                            : 'images/point_grey_img.png',
                        width: _src.setWidth(
                            6),
                        height: _src.setHeight(
                            6),
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                  Container(
                    height:
                    _src.setHeight(2),
                  ),
                  _selectedMode == '흔들'
                      ? Image.asset(
                    'images/rocking_seat_img.png',
                    width: _src.setWidth(
                        40),
                    height: _src.setHeight(
                        40),
                    fit: BoxFit.fill,
                  )
                      : Image.asset(
                    'images/rocking_seat_grey_img.png',
                    width: _src.setWidth(
                        40),
                    height: _src.setHeight(
                        40),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    height:
                    _src.setHeight(1),
                  ),
                  Container(
                      width:
                      _src.setWidth(40),
                      height: _src.setHeight(
                          16),
                      child: Text(
                        '흔들',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: _src.setSp(9)),
                      ))
                ],
              ),
            ),
            onTap: () {
              setState(() {
                _selectedMode = '흔들';
              });
            },
          )
        ],
      ),
    );
  }
  Widget closeButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: _src.setWidth(32),
          height: _src.setHeight(32),
          child: InkWell(
            onTap: () {
              _remoteContolProvider.setOpenControl(false);
            },
            child: Image.asset(
              'images/close_img.png',
              width: _src.setWidth(32),
              height: _src.setHeight(32),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          width: _src.setWidth(18),
        )
      ],
    );
  }
  Widget? selectMode(String _selectedMode) {
    switch (_selectedMode) {
      case '자세':
        return ControlAttributeUI();
      case '온열':
        return ControlHeatUI();
      case '흔들':
        return ControlShakeUI();
    }
    return null;
  }

}
