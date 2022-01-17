import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';
import 'package:smartrecliner_flutter/ContextMenu/ContextMenu.dart';
import 'package:smartrecliner_flutter/Control/ControlUI.dart';
import 'package:smartrecliner_flutter/Control/RemoteContolProvider.dart';
import 'package:smartrecliner_flutter/Drawer/DrawerUI.dart';
import 'package:smartrecliner_flutter/History/HistoryBloodPressureGraphUI.dart';
import 'package:smartrecliner_flutter/History/HistoryDateController.dart';
import 'package:smartrecliner_flutter/History/HistoryGraphController.dart';
import 'package:smartrecliner_flutter/History/HistoryList.dart';
import 'package:smartrecliner_flutter/UISupport/AppbarUI.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
import '../BottomUI.dart';
import 'HistoryGraphUI.dart';
import 'HistoryProvider2.dart';



class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryUI();
}


class HistoryUI extends State<History> {
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();
  //HealthItemUnit
  String _healthItemUnit = '심박수';
  //Remote Control
  late RemoteContolProvider _remoteContolProvider;
  late HistoryProvider2 _historyProvider;

  late String wichDate;
  late String wichMode;
  late List<HistoryApiResponse> rawData;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _historyProvider =  Provider.of<HistoryProvider2>(context, listen: false);
      initHistoryData(_historyProvider);
    });
    super.initState();
  }
  void initHistoryData(HistoryProvider2 _historyProvider){
    DateTime now = DateTime.now();
    DateTime day = DateTime(now.year, now.month, now.day-1);
    DateTime week = DateTime(now.year, now.month, now.day - 7);
    DateTime month = DateTime(now.year, now.month -1 ,now.day);
    _historyProvider.requestSetDayData(day.millisecondsSinceEpoch, now.millisecondsSinceEpoch);
    _historyProvider.requestSetWeekData(week.millisecondsSinceEpoch, now.millisecondsSinceEpoch);
    _historyProvider.requestSetMonthData(month.millisecondsSinceEpoch, now.millisecondsSinceEpoch);
    _historyProvider.requestEnd = true;
  }

  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _remoteContolProvider = Provider.of<RemoteContolProvider>(context);
    _historyProvider =  Provider.of<HistoryProvider2>(context);
    wichDate = _historyProvider.getWichDate();
    wichMode = _historyProvider.getWichMode();
    return SafeArea(
        child: WillPopScope(
          child: Scaffold(
            endDrawer: DrawerUI(),
            body: Builder(
              builder: (context) {
                return Stack(
                  children: [
                    Container(
                      color: _reclinerColor.white1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          topUI(),
                          Container(
                            height: _src.setHeight(13),
                          ),
                          bodyUI(),
                          Container(
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
                          )
                        ],
                      ),
                    ),
                    _remoteContolProvider.getOpenControl()
                        ? ControlUI()
                        : Container(),
                    // _buildBody(context)
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

  Widget topUI() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ContextMenuUI(),
            Container(
              width: _src.setWidth(8),
            )
          ],
        ),
        AppbarUI(
          name: '지난 측정 내역',
          scaffoldContext: context,
          key: null,
        )
      ],
    );
  }

  Widget bodyUI() {
    return Flexible(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HistoryDateController(),
                Container(
                  width: _src.setWidth(21),
                ),
                HistoryGraphController()
              ],
            ),
            Container(
              height: _src.setHeight(19),
            ),
            measureDate(),
            Container(
              height: _src.setHeight(22),
            ),
            wichMode == 'list' ? buildList() : buildGraph(),
          ],
        ));
  }

  Widget buildList() {
    return Container(
      child: _historyProvider.requestEnd
          ? HistoryList()
          : Container(
        width: _src.setWidth(324),
        height: _src.setHeight(375),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildGraph() {
    return Container(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  healthGraphUnitUI('심박수'),
                  Container(
                    width: _src.setWidth(15),
                  ),
                  healthGraphUnitUI('혈압'),
                  Container(
                    width: _src.setWidth(15),
                  ),
                  healthGraphUnitUI('스트레스'),
                  Container(
                    width: _src.setWidth(15),
                  ),
                  healthGraphUnitUI('몸무게'),
                  Container(
                    width: _src.setWidth(15),
                  ),
                ],
              ),
              Container(
                height: _src.setHeight(27),
              ),
              _historyProvider.requestEnd
                  ? historyGraph()
                  : Container(
                width: _src.setWidth(331),
                height: _src.setHeight(301),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ));
  }

  Widget remoteController() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0.01,
                  blurRadius: 1,
                  offset: Offset(-1.5, 3.0))
            ],
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

  Widget measureDate() {
    return Container(
      height: _src.setHeight(34),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: _src.setWidth(62)),
            child: Container(
              width: _src.setWidth(34),
              height: _src.setHeight(34),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 0.01,
                        blurRadius: 1,
                        offset: Offset(0.0, 2.0))
                  ]),
              child: InkWell(
                onTap: () {
                  setState(() {
                    switch (wichDate) {
                      case '일':
                        DateTime differ = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month, HistoryProvider2.standardTime.day,0);
                        HistoryProvider2.standardTime = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month, HistoryProvider2.standardTime.day -1,0);
                        _historyProvider.requestSetDayData(HistoryProvider2.standardTime.millisecondsSinceEpoch, differ.millisecondsSinceEpoch);
                        break;
                      case '주':
                        DateTime differ = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month, HistoryProvider2.standardTime.day,0);
                        HistoryProvider2.standardTime = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month, HistoryProvider2.standardTime.day -7,0);
                        _historyProvider.requestSetWeekData(HistoryProvider2.standardTime.millisecondsSinceEpoch, differ.millisecondsSinceEpoch);
                        break;
                      case '월':
                        DateTime differ = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month, 0,0);
                        HistoryProvider2.standardTime = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month-1, HistoryProvider2.standardTime.day,0);
                        DateTime before2 = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month, 0);
                        _historyProvider.requestSetMonthData(before2.millisecondsSinceEpoch, differ.millisecondsSinceEpoch);
                        print('month : ${HistoryProvider2.standardTime}');
                        break;
                    }
                    // requestMoreHistoryData();
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/measure_previous_history_img.png',
                          width: _src.setWidth(22),
                          height: _src.setHeight(22),
                          fit: BoxFit.fill,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Text(
            _historyProvider.getDateData(),
            style: TextStyle(
                fontSize: _src.setSp(19), color: _reclinerColor.dark1),
          ),
          Padding(
            padding: EdgeInsets.only(right: _src.setWidth(62)),
            child: Container(
              width: _src.setWidth(34),
              height: _src.setHeight(34),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 0.01,
                        blurRadius: 1,
                        offset: Offset(0.0, 2.0))
                  ]),
              child: InkWell(
                onTap: () {
                  setState(() {
                    switch (wichDate) {
                      case '일':
                        HistoryProvider2.standardTime = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month, HistoryProvider2.standardTime.day+1,0);
                        DateTime differ = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month, HistoryProvider2.standardTime.day+1,0);

                        _historyProvider.requestSetDayData(HistoryProvider2.standardTime.millisecondsSinceEpoch, differ.millisecondsSinceEpoch);
                        break;
                      case '주':
                        DateTime differ = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month, HistoryProvider2.standardTime.day,0);
                        HistoryProvider2.standardTime = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month, HistoryProvider2.standardTime.day +7,0);
                        _historyProvider.requestSetWeekData(differ.millisecondsSinceEpoch, HistoryProvider2.standardTime.millisecondsSinceEpoch);
                        break;
                      case '월':
                        DateTime differ = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month, 0,0);
                        HistoryProvider2.standardTime = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month+1, HistoryProvider2.standardTime.day,0);
                        DateTime before2 = DateTime(HistoryProvider2.standardTime.year, HistoryProvider2.standardTime.month, 0,0);
                        _historyProvider.requestSetMonthData(differ.millisecondsSinceEpoch, before2.millisecondsSinceEpoch);
                        break;
                    }
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/measure_next_history_img.png',
                          width: _src.setWidth(22),
                          height: _src.setHeight(22),
                          fit: BoxFit.fill,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget healthGraphUnitUI(String itemName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _healthItemUnit = itemName;
            });
          },
          child: Container(
            width: _src.setWidth(68),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  _historyProvider.getHealthItemImage(_healthItemUnit, itemName),
                  width: _src.setWidth(24),
                  height: _src.setHeight(24),
                  fit: BoxFit.fill,
                ),
                Container(
                  width: _src.setWidth(2),
                ),
                Text(
                  itemName,
                  style: TextStyle(
                      fontSize: _src.setSp(10),
                      color: _reclinerColor.dark1,
                      fontWeight: _healthItemUnit == itemName
                          ? FontWeight.bold
                          : FontWeight.normal),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
  Widget historyGraph() {
    List<HistoryApiResponse> wichData = [];
    if(_historyProvider.requestEnd){
      switch (wichDate) {
        case '일':
          wichData = _historyProvider.requestGetDayData();
          break;
        case '주':
          wichData = _historyProvider.requestGetWeekData();
          break;
        case '월':
          wichData = _historyProvider.requestGetMonthData();
          break;
      }
      if (wichData.isNotEmpty) {
        if (_healthItemUnit != '혈압') {
          return CustomPaint(
            size: Size(_src.setWidth(331), _src.setHeight(309)),
            foregroundPainter: HistoryGraphUI(
                healthItem: _healthItemUnit,
                data: _historyProvider.getHealthData(_healthItemUnit, wichData),
                labels: _historyProvider.getTimeData(wichDate, wichData)),
          );
        } else {
          return CustomPaint(
            size: Size(_src.setWidth(331), _src.setHeight(309)),
            foregroundPainter: HistoryBloodPressureGraphUI(
                healthItem:_healthItemUnit,
                sdata: _historyProvider.getSystolicData(wichData),
                ddata: _historyProvider.getDiastolicData(wichData),
                labels: _historyProvider.getTimeData(wichDate, wichData)),
          );
        }
      } else {
        return historyNoData();
      }
    }else{
      return Container(
        width: _src.setWidth(331),
        height: _src.setHeight(309),
        child: CircularProgressIndicator(),
      );
    }

  }
  Widget historyNoData(){
    return Container(
      width: _src.setWidth(331),
      height: _src.setHeight(309),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/healthnodata_img.png',
            width: _src.setWidth(111),
            height: _src.setHeight(92),
            fit: BoxFit.fill,
          ),
          Container(
            height: _src.setHeight(16),
          ),
          Text(
            '측정된 데이터가 없습니다.',
            style: TextStyle(
                color: _reclinerColor.dark2, fontSize: _src.setSp(15)),
          ),
          Container(
            height: _src.setHeight(2),
          ),
          Text(
            '메뉴를 눌러 건강측정을 할 수 있어요.',
            style: TextStyle(
                color: _reclinerColor.dark2, fontSize: _src.setSp(12)),
          )
        ],
      ),
    );
  }
}
