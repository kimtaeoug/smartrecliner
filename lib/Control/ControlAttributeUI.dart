import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/BleProvider.dart';
import 'package:smartrecliner_flutter/Protocol/BleProtocol.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

class ControlAttributeUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ControlAttributeUI();
}

class _ControlAttributeUI extends State<ControlAttributeUI> {
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  //끝까지 세우기
  bool _standToEndCheck = false;

  //끝까지 눕히기
  bool _layToEndCheck = false;

  late BleProvider _bleProvider;
  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;

  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _bleProvider = Provider.of<BleProvider>(context);
    return Opacity(
      opacity: 0.7,
      child: Container(
        width: _src.setWidth(331),
        height: _src.setHeight(412),
        decoration: BoxDecoration(
            color: _reclinerColor.white2,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: _src.setHeight(53),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/body_controlseat_img.png',
                  width: _src.setWidth(48),
                  height: _src.setHeight(48),
                  fit: BoxFit.fill,
                ),
                Container(
                  width: _src.setWidth(14),
                ),
                Container(
                  width: _src.setWidth(43),
                  height: _src.setHeight(24),
                  child: Text(
                    '등받이',
                    style: TextStyle(
                        fontSize: _src.setSp(13),
                        color: _reclinerColor.dark1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: _src.setWidth(28),
                ),
                backControlDetail()
              ],
            ),
            Container(
              height: _src.setHeight(25),
            ),
            Container(
              height: _src.setHeight(1),
              color: _reclinerColor.grey,
            ),
            Container(
              height: _src.setHeight(33),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/leg_controlseat_img.png',
                  width: _src.setWidth(48),
                  height: _src.setHeight(48),
                  fit: BoxFit.fill,
                ),
                Container(
                  width: _src.setWidth(14),
                ),
                Container(
                  width: _src.setWidth(43),
                  height: _src.setHeight(24),
                  child: Text(
                    '발받침',
                    style: TextStyle(
                        fontSize: _src.setSp(13),
                        color: _reclinerColor.dark1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: _src.setWidth(28),
                ),
                footControlDetail()
              ],
            ),
            Container(
              height: _src.setHeight(32.5),
            ),
            Container(
              height: _src.setHeight(1),
              color: _reclinerColor.grey,
            ),
            Container(
              height: _src.setHeight(33.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    standToTheEnd();
                  },
                  child: _standToEndCheck
                      ? Container(
                          width: _src.setWidth(130),
                          height: _src.setHeight(80),
                          decoration: BoxDecoration(
                              color: _reclinerColor.turquoise,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              border:
                                  Border.all(color: _reclinerColor.turquoise),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 0.01,
                                    blurRadius: 1,
                                    offset: Offset(-1.5, 2.0))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/sit_white_img.png',
                                width: _src.setWidth(32),
                                height: _src.setHeight(32),
                                fit: BoxFit.fill,
                              ),
                              Container(
                                height: _src.setHeight(6),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '끝까지',
                                    style:
                                        TextStyle(color: _reclinerColor.white2),
                                  ),
                                  Container(
                                    width: _src.setWidth(2),
                                  ),
                                  Text(
                                    '세우기',
                                    style: TextStyle(
                                        color: _reclinerColor.white2,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: _src.setWidth(130),
                          height: _src.setHeight(80),
                          decoration: BoxDecoration(
                              color: _reclinerColor.white2,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              border: Border.all(color: _reclinerColor.grey),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 0.01,
                                    blurRadius: 1,
                                    offset: Offset(-1.5, 2.0))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/sit_img.png',
                                width: _src.setWidth(32),
                                height: _src.setHeight(32),
                                fit: BoxFit.fill,
                              ),
                              Container(
                                height: _src.setHeight(6),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '끝까지',
                                  ),
                                  Container(
                                    width: _src.setWidth(2),
                                  ),
                                  Text(
                                    '세우기',
                                    style: TextStyle(
                                        color: _reclinerColor.turquoise,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
                Container(
                  width: _src.setWidth(11),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      layToTheEnd();
                    });
                  },
                  child: _layToEndCheck
                      ? Container(
                          width: _src.setWidth(130),
                          height: _src.setHeight(80),
                          decoration: BoxDecoration(
                              color: _reclinerColor.turquoise,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50)),
                              border:
                                  Border.all(color: _reclinerColor.turquoise),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 0.01,
                                    blurRadius: 1,
                                    offset: Offset(-1.5, 2.0))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/lying_white_img.png',
                                width: _src.setWidth(55),
                                height: _src.setHeight(22),
                                fit: BoxFit.fill,
                              ),
                              Container(
                                height: _src.setHeight(6),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '끝까지',
                                    style:
                                        TextStyle(color: _reclinerColor.white2),
                                  ),
                                  Container(
                                    width: _src.setWidth(2),
                                  ),
                                  Text(
                                    '눕히기',
                                    style: TextStyle(
                                        color: _reclinerColor.white2,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: _src.setWidth(130),
                          height: _src.setHeight(80),
                          decoration: BoxDecoration(
                              color: _reclinerColor.white2,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50)),
                              border: Border.all(color: _reclinerColor.grey),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 0.01,
                                    blurRadius: 1,
                                    offset: Offset(-1.5, 2.0))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/lying_img.png',
                                width: _src.setWidth(55),
                                height: _src.setHeight(22),
                                fit: BoxFit.fill,
                              ),
                              Container(
                                height: _src.setHeight(6),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '끝까지',
                                  ),
                                  Container(
                                    width: _src.setWidth(2),
                                  ),
                                  Text(
                                    '눕히기',
                                    style: TextStyle(
                                        color: _reclinerColor.turquoise,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  double _bodyCurrentSliderValue = 50;

  //_currentSliderValue
  Widget backControlDetail() {
    return Container(
        width: _src.setWidth(100),
        height: _src.setHeight(46),
        child: Stack(
          children: [
            Container(
              width: _src.setWidth(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: _src.setWidth(10),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/directionsign_left_img.png',
                        width: _src.setWidth(10),
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  Container(
                    width: _src.setWidth(60),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/directionsign_right_img.png',
                        width: _src.setWidth(10),
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                  Container(
                    width: _src.setWidth(10),
                  )
                ],
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.transparent,
                  inactiveTrackColor: Colors.transparent,
                  trackShape: RoundedRectSliderTrackShape(),
                  trackHeight: 12.0,
                  thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: _src.setHeight(22)),
                  thumbColor: _reclinerColor.turquoise,
                  overlayColor: _reclinerColor.turquoise.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),
                  tickMarkShape: RoundSliderTickMarkShape()),
              child: Slider(
                value: _bodyCurrentSliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                onChangeStart: (_) {
                  setState(() {
                    backCheck = 0;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _bodyCurrentSliderValue = value;
                  });
                  if (value > 90) {
                    if (backCheck == 0) {
                      _bleProvider.sendToData(_bleProtocol.getMoveBack('1'));
                      backCheck = 1;
                    }
                  } else if (value == 50) {
                    if (backCheck == 1) {
                      _bleProvider.sendToData(_bleProtocol.getMoveBack('off'));
                      backCheck = 0;
                    }
                  } else if (value < 10) {
                    if (backCheck == 0) {
                      _bleProvider.sendToData(_bleProtocol.getMoveBack('2'));
                    }
                  }
                },
                onChangeEnd: (value) {
                  setState(() {
                    backCheck = 0;
                    _bodyCurrentSliderValue = 50;
                  });
                  _bleProvider.sendToData(_bleProtocol.getMoveBack('off'));
                },
              ),
            )
          ],
        ));
  }

  double _footCurrentSliderValue = 50;

  //foot
  Widget footControlDetail() {
    return Container(
        width: _src.setWidth(100),
        height: _src.setHeight(46),
        child: Stack(
          children: [
            Container(
              width: _src.setWidth(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: _src.setWidth(10),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/directionsign_left_img.png',
                        width: _src.setWidth(10),
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  Container(
                    width: _src.setWidth(60),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/directionsign_right_img.png',
                        width: _src.setWidth(10),
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                  Container(
                    width: _src.setWidth(10),
                  )
                ],
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.transparent,
                  inactiveTrackColor: Colors.transparent,
                  trackShape: RoundedRectSliderTrackShape(),
                  trackHeight: 12.0,
                  thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: _src.setHeight(22)),
                  thumbColor: _reclinerColor.turquoise,
                  overlayColor: _reclinerColor.turquoise.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),
                  tickMarkShape: RoundSliderTickMarkShape()),
              child: Slider(
                value: _footCurrentSliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                onChangeStart: (value) {
                  setState(() {
                    footCheck = 0;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _footCurrentSliderValue = value;
                  });
                  if (value > 90) {
                    if (footCheck == 0) {
                      _bleProvider.sendToData(_bleProtocol.getMoveFoot('1'));
                      footCheck = 1;
                    }
                  } else if (value == 50) {
                    if (footCheck == 1) {
                      _bleProvider.sendToData(_bleProtocol.getMoveFoot('off'));
                      footCheck = 0;
                    }
                  } else if (value < 10) {
                    if (footCheck == 0) {
                      _bleProvider.sendToData(_bleProtocol.getMoveFoot('2'));
                      footCheck = 1;
                    }
                  }
                },
                onChangeEnd: (value) {
                  setState(() {
                    footCheck = 0;
                    _footCurrentSliderValue = 50;
                  });
                  _bleProvider.sendToData(_bleProtocol.getMoveFoot('off'));
                },
              ),
            )
          ],
        ));
  }

  int standToTheEndCheck = 0;

  //Stand to the end
  void standToTheEnd()  {
    print('_standToEndCheck : $_standToEndCheck');
    if (_standToEndCheck) {
      setState(() {
        _standToEndCheck = false;
      });
      if (standToTheEndCheck == 1) {
        _bleProvider.sendToData(_bleProtocol.getMoveFoot('off'));
        sleep(Duration(milliseconds: 100));
        _bleProvider.sendToData(_bleProtocol.getMoveBack('off'));
        standToTheEndCheck = 0;
      }
    } else {
      setState(() {
        _standToEndCheck = true;
      });
      if (standToTheEndCheck == 0) {
        _bleProvider.sendToData(_bleProtocol.getMoveFoot('2'));
        sleep(Duration(milliseconds: 100));
        _bleProvider.sendToData(_bleProtocol.getMoveBack('1'));
        standToTheEndCheck = 1;
      }
    }
  }

  int layToTheEndCheck = 0;

  //Lay to the end
  void layToTheEnd(){
    if (_layToEndCheck) {
      setState(() {
        _layToEndCheck = false;
      });
      if (layToTheEndCheck == 1) {
        _bleProvider.sendToData(_bleProtocol.getMoveFoot('off'));
        sleep(Duration(milliseconds: 100));
        _bleProvider.sendToData(_bleProtocol.getMoveBack('off'));
        layToTheEndCheck = 0;
      }
    } else {
      setState(() {
        _layToEndCheck = true;
      });
      if (layToTheEndCheck == 0) {
        _bleProvider.sendToData(_bleProtocol.getMoveFoot('1'));
        sleep(Duration(milliseconds: 100));
        _bleProvider.sendToData(_bleProtocol.getMoveBack('2'));
        layToTheEndCheck = 1;
      }
    }
  }

  final BleProtocol _bleProtocol = BleProtocol();
  int backCheck = 0;
  int footCheck = 0;

  void controlAttribute(double value, String attributeItem) {
    switch (attributeItem) {
      case 'back':
        if (value > 50) {
          _bleProvider.sendToData(_bleProtocol.getMoveBack('1'));
          sleep(Duration(milliseconds: 10));
        } else if (value < 50) {
          _bleProvider.sendToData(_bleProtocol.getMoveBack('2'));
          sleep(Duration(milliseconds: 10));
        }
        break;
      case 'foot':
        if (value > 50) {
          if (footCheck == 0) {
            _bleProvider.sendToData(_bleProtocol.getMoveFoot('1'));
            print('up');
            footCheck = 1;
          }
        } else if (value == 50) {
          print('center');
          _bleProvider.sendToData(_bleProtocol.getMoveFoot('off'));
          footCheck = 0;
        } else if (value < 50) {
          if (footCheck == 0) {
            print('down');
            _bleProvider.sendToData(_bleProtocol.getMoveFoot('2'));
            footCheck = 1;
          }
        }
        break;
    }
  }
}
