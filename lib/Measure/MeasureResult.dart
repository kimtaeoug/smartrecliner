import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/Api/HistoryAPI.dart';
import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';
import 'package:smartrecliner_flutter/BottomUI.dart';
import 'package:smartrecliner_flutter/ContextMenu/ContextMenu.dart';
import 'package:smartrecliner_flutter/Control/ControlUI.dart';
import 'package:smartrecliner_flutter/Control/RemoteContolProvider.dart';
import 'package:smartrecliner_flutter/Drawer/DrawerUI.dart';
import 'package:smartrecliner_flutter/UISupport/AppbarUI.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
import 'DetailResult.dart';

class MeasureResult extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MeasureResult();
}

class _MeasureResult extends State<MeasureResult> {
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  //Remote Control
  late RemoteContolProvider _remoteContolProvider;

  //Detail open
  bool _isDetailOpen = false;
  final client = HistoryAPI(Dio(BaseOptions(contentType: "application/json")));
  late Future<HistoryApiResponse> _requestRecent;
  @override
  void initState() {
    super.initState();
    _requestRecent = client.getRecent();
  }
  ScreenUtilAPI _screenUtilAPI =ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _remoteContolProvider = Provider.of<RemoteContolProvider>(context);
    return SafeArea(
        child: WillPopScope(
      child: Scaffold(
        endDrawer: DrawerUI(),
        body: Builder(
          builder: (context) {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ContextMenuUI(),
                        Container(
                          width: _src.setWidth(7),
                        )
                      ],
                    ),
                    AppbarUI(
                      name: '측정결과',
                      scaffoldContext: context,
                      key: null,
                    ),
                    Container(
                      height: _src.setHeight(2),
                    ),
                    measureResultFutureStrcuture()
                  ],
                ),
                _remoteContolProvider.getOpenControl()
                    ? ControlUI()
                    : Container()
              ],
            );
          },
        ),
      ),
      onWillPop: () {
        return Future(() => false);
      },
    ));
  }

  Widget measureResultFutureStrcuture() {
    return FutureBuilder<HistoryApiResponse>(
      future: _requestRecent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final HistoryApiResponse? data = snapshot.data;
          if (data != null) {
            return measureResultBigStrcuture(data);
          } else {
            return measureResultBigStrcuture(data);
          }
        } else {
          return Container(
            width: _src.setWidth(320),
            height: _src.setHeight(584),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget measureResultBigStrcuture(HistoryApiResponse? data) {
    if(data != null){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: _src.setHeight(47),
            color: _reclinerColor.white2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  calDate(data.recordedTime),
                  style: TextStyle(
                      fontSize: _src.setSp(18),
                      color: _reclinerColor.dark1),
                )
              ],
            ),
          ),
          Container(
            height: _src.setHeight(581),
            child: SingleChildScrollView(
              child: measureResultStructure(data),
            ),
          )
        ],
      );
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: _src.setHeight(47),
            color: _reclinerColor.white2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '정보 없음',
                  style: TextStyle(
                      fontSize: _src.setSp(18),
                      color: _reclinerColor.dark1),
                )
              ],
            ),
          ),
          Container(
            height: _src.setHeight(581),
            child: SingleChildScrollView(
              child: measureResultStructure(data),
            ),
          )
        ],
      );
    }
  }

  Widget measureResultStructure(HistoryApiResponse? data) {
    if(data != null){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            height: _src.setHeight(300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/point_img.png',
                            width: _src.setWidth(6),
                            height: _src.setHeight(6),
                            fit: BoxFit.fill,
                          ),
                          Text(
                            '정상',
                            style: TextStyle(color: _reclinerColor.turquoise),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: _src.setWidth(12),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/point_yellow_img.png',
                            width: _src.setWidth(6),
                            height: _src.setHeight(6),
                            fit: BoxFit.fill,
                          ),
                          Text(
                            '주의',
                            style: TextStyle(color: Color(0xfff7b500)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: _src.setWidth(12),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/point_red_img.png',
                            width: _src.setWidth(6),
                            height: _src.setHeight(6),
                            fit: BoxFit.fill,
                          ),
                          Text(
                            '위험',
                            style: TextStyle(color: Color(0xfffa6400)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: _src.setWidth(20),
                    )
                  ],
                ),
                Container(
                  height: _src.setHeight(11),
                ),
                Container(
                  width: _src.setWidth(320),
                  height: _src.setHeight(180),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: _reclinerColor.grey1),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 0.01,
                            blurRadius: 1,
                            offset: Offset(0.0, 2.0))
                      ]),
                  child: Stack(
                    children: [
                      Align(
                        child: Container(
                          height: _src.setHeight(165),
                          width: 1,
                          color: Color(0xfff0f0f0),
                        ),
                        alignment: Alignment.center,
                      ),
                      Align(
                        child: Container(
                          width: _src.setHeight(280),
                          height: 1,
                          color: Color(0xfff0f0f0),
                        ),
                        alignment: Alignment.center,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //심박수 item
                              measureResultItem('images/heartgrey_img.png', '심박수',
                                  data.heartRate.toInt().toString(), _reclinerColor.turquoise, 'bpm'),
                              Container(),
                              measureResultItem('images/blooddrop_img.png', '혈압',
                                  '${data.systolic.toInt()}/${data.diastolic.toInt()}', _reclinerColor.turquoise, 'mmHg')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              measureResultItem('images/stress_img.png', '스트레스',
                                  data.stress.toInt().toString(), _reclinerColor.secondary2, ''),
                              Container(),
                              measureResultItem('images/weight_img.png', '몸무게',
                                  data.weight.toInt().toString(), _reclinerColor.secondary1, 'mmHg')
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: _src.setHeight(20),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '평소보다 스트레스 지수가 높게 측정되었습니다.',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:
                            _src.setSp(10)),
                      ),
                      Text(
                        '충분한 휴식과 가벼운 산책을 즐겨보세요.',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:
                            _src.setSp(10)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: _reclinerColor.white2,
            height: _src.setHeight(44),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '상세 설명 더보기',
                        style: TextStyle(
                            fontSize: _src.setSp(11),
                            color: _reclinerColor.dark2),
                      ),
                      Container(
                        width: _src.setWidth(4),
                      ),
                      Image.asset(
                          _isDetailOpen
                              ? 'images/up_direction_img.png'
                              : 'images/down_direction_img.png',
                          width: _src.setWidth(10),fit: BoxFit.fill,)
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      if (_isDetailOpen) {
                        _isDetailOpen = false;
                      } else {
                        _isDetailOpen = true;
                      }
                    });
                  },
                )
              ],
            ),
          ),
          _isDetailOpen ? DetailResult(data: data, key: null,) : Container(),
          controlButtons(_isDetailOpen),
          bottom()
        ],
      );
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            height: _src.setHeight(300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/point_img.png',
                            width: _src.setWidth(6),
                            height: _src.setHeight(6),
                            fit: BoxFit.fill,
                          ),
                          Text(
                            '정상',
                            style: TextStyle(color: _reclinerColor.turquoise),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: _src.setWidth(12),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/point_yellow_img.png',
                            width: _src.setWidth(6),
                            height: _src.setHeight(6),
                            fit: BoxFit.fill,
                          ),
                          Text(
                            '주의',
                            style: TextStyle(color: Color(0xfff7b500)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: _src.setWidth(12),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/point_red_img.png',
                            width: _src.setWidth(6),
                            height: _src.setHeight(6),
                            fit: BoxFit.fill,
                          ),
                          Text(
                            '위험',
                            style: TextStyle(color: Color(0xfffa6400)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: _src.setWidth(20),
                    )
                  ],
                ),
                Container(
                  height: _src.setHeight(11),
                ),
                Container(
                  width: _src.setWidth(320),
                  height: _src.setHeight(180),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: _reclinerColor.grey1),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 0.01,
                            blurRadius: 1,
                            offset: Offset(0.0, 2.0))
                      ]),
                  child: Stack(
                    children: [
                      Align(
                        child: Container(
                          height: _src.setHeight(165),
                          width: 1,
                          color: Color(0xfff0f0f0),
                        ),
                        alignment: Alignment.center,
                      ),
                      Align(
                        child: Container(
                          width: _src.setHeight(280),
                          height: 1,
                          color: Color(0xfff0f0f0),
                        ),
                        alignment: Alignment.center,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //심박수 item
                              measureResultItem('images/heartgrey_img.png', '심박수',
                                  '72', _reclinerColor.turquoise, 'bpm'),
                              Container(),
                              measureResultItem('images/blooddrop_img.png', '혈압',
                                  '125/68', _reclinerColor.turquoise, 'mmHg')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              measureResultItem('images/stress_img.png', '스트레스',
                                  '80', _reclinerColor.secondary2, ''),
                              Container(),
                              measureResultItem('images/weight_img.png', '몸무게',
                                  '40', _reclinerColor.secondary1, 'mmHg')
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: _src.setHeight(20),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '평소보다 스트레스 지수가 높게 측정되었습니다.',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:
                            _src.setSp(10)),
                      ),
                      Text(
                        '충분한 휴식과 가벼운 산책을 즐겨보세요.',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:
                            _src.setSp(10)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: _reclinerColor.white2,
            height: _src.setHeight(44),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '상세 설명 더보기',
                        style: TextStyle(
                            fontSize: _src.setSp(11),
                            color: _reclinerColor.dark2),
                      ),
                      Container(
                        width: _src.setWidth(4),
                      ),
                      Image.asset(
                          _isDetailOpen
                              ? 'images/up_direction_img.png'
                              : 'images/down_direction_img.png',
                          width: _src.setWidth(10),
                        fit: BoxFit.fill,)
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      if (_isDetailOpen) {
                        _isDetailOpen = false;
                      } else {
                        _isDetailOpen = true;
                      }
                    });
                  },
                )
              ],
            ),
          ),
          _isDetailOpen ? DetailResult(data: data, key: null,) : Container(),
          controlButtons(_isDetailOpen),
          bottom()
        ],
      );
    }
  }

  Widget measureResultItem(String img, String itemName, String value,
      Color valueColor, String unit) {
    return Container(
      width: _src.setWidth(155),
      height: _src.setHeight(85),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                img,
                width: _src.setWidth(20),
                height: _src.setHeight(20),
                fit: BoxFit.fill,
              ),
              Text(
                '$itemName',
                style: TextStyle(
                    fontSize: _src.setSp(11),
                    color: Colors.black),
              ),
            ],
          ),
          Container(
            height: _src.setHeight(1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                    fontSize: _src.setSp(20),
                    color: valueColor,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: _src.setWidth(3),
              ),
              Container(
                height: _src.setHeight(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      unit,
                      style: TextStyle(
                          color: _reclinerColor.dark2,
                          fontSize: _src.setSp(9)),
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

  Widget deleteResultButton() {
    return Container(
      width: _src.setWidth(144),
      height: _src.setHeight(53),
      decoration: BoxDecoration(
          border: Border.all(color: _reclinerColor.dark2),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          '결과 삭제',
          style: TextStyle(
              fontSize: _src.setSp(13),
              color: _reclinerColor.dark2),
        ),
      ),
    );
  }

  Widget reMeasureButton() {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/Measure');
      },
      child: Container(
        width: _src.setWidth(144),
        height: _src.setHeight(53),
        decoration: BoxDecoration(
            border: Border.all(color: _reclinerColor.dark2),
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.white),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            '다시 측정하기',
            style: TextStyle(
                fontSize: _src.setSp(13),
                color: _reclinerColor.dark2),
          ),
        ),
      ),
    );
  }

  Widget remoteController() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0.01,
                  blurRadius: 1,
                  offset: Offset(-1.5, 3.0))
            ],
            shape: BoxShape.circle,
            color: _reclinerColor.turquoise,
          ),
          width: _src.setWidth(57),
          height: _src.setHeight(57),
        ),
        Container(
          width: _src.setWidth(57),
          height: _src.setHeight(57),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Image.asset(
                      'images/remoter_img.png',
                      width: _src.setWidth(17),
                      height: _src.setHeight(36),
                      fit: BoxFit.fill,
                    ),
                    onTap: () {
                      _remoteContolProvider.setOpenControl(true);
                    },
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget controlButtons(bool _isDetailOpen) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: _src.setHeight(21),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              deleteResultButton(),
              Container(
                width: _src.setWidth(12),
              ),
              reMeasureButton()
            ],
          ),
          Container(
            height: _isDetailOpen
                ? _src.setHeight(12)
                : _src.setHeight(90),
          )
        ],
      ),
    );
  }

  Widget bottom() {
    return Container(
      height: _src.setHeight(72),
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BottomUI(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  remoteController(),
                  Container(
                    width: _src.setWidth(26),
                  )
                ],
              ),
              Container(
                height: _src.setHeight(15),
              )
            ],
          )
        ],
      ),
    );
  }

  String calDate(int time) {
    String result = '';
    DateTime calTime = DateTime.fromMillisecondsSinceEpoch(time);
    String dayName = DateFormat('EEEE').format(calTime);
    int month = calTime.month;
    int day = calTime.day;
    switch (dayName) {
      case 'Monday':
        result = '$month월 $day일 월요일 ${calTime.hour}:${calTime.minute}';
        break;
      case 'Tuesday':
        result = '$month월 $day일 화요일 ${calTime.hour}:${calTime.minute}';
        break;
      case 'Wednesday':
        result = '$month월 $day일 수요일 ${calTime.hour}:${calTime.minute}';
        break;
      case 'Thursday':
        result = '$month월 $day일 목요일 ${calTime.hour}:${calTime.minute}';
        break;
      case 'Friday':
        result = '$month월 $day일 금요일 ${calTime.hour}:${calTime.minute}';
        break;
      case 'Saturday':
        result = '$month월 $day일 토요일 ${calTime.hour}:${calTime.minute}';
        break;
      case 'Sunday':
        result = '$month월 $day일 일요일 ${calTime.hour}:${calTime.minute}';
        break;
    }
    return result;
  }
}
