import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

import 'HistoryProvider2.dart';

class HistoryListItem extends StatefulWidget {
  final HistoryApiResponse data;

  HistoryListItem(
      {required Key? key,
        required this.data})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _HistoryListItem(data);
}

class _HistoryListItem extends State<HistoryListItem> {

  HistoryApiResponse data;

  _HistoryListItem(this.data);

  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  late HistoryProvider2 _historyProvider;
  late String wichDate;
  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _historyProvider = Provider.of<HistoryProvider2>(context);
    wichDate = _historyProvider.getWichDate();
    return Container(
      width: _src.setWidth(324),
      height: _src.setHeight(167),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: _src.setWidth(84),
            height: _src.setHeight(167),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      processDate(data.recordedTime),
                      style: TextStyle(
                          fontSize: _src.setSp(11),
                          color: _reclinerColor.dark2, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            width: _src.setWidth(240),
            height: _src.setHeight(167),
            decoration: BoxDecoration(
                color: _reclinerColor.white1,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _reclinerColor.grey1),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: _src.setWidth(16),
                    ),
                    Image.asset(
                      'images/heartgrey_img.png',
                      width: _src.setWidth(24),
                      height: _src.setHeight(24),
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Text(
                      '심박수',
                      style: TextStyle(
                          color: _reclinerColor.dark1,
                          fontSize: _src.setSp(13)),
                    ),
                    Container(
                      width: _src.setWidth(45),
                    ),
                    Text(
                      data.heartRate.toInt().toString(),
                      style: TextStyle(
                          fontSize: _src.setSp(13),
                          color: _reclinerColor.turquoise,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Text(
                      'bpm',
                      style: TextStyle(
                          fontSize: _src.setSp(13),
                          color: _reclinerColor.dark2),
                    )
                  ],
                ),
                Container(
                  height: _src.setHeight(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: _src.setWidth(16),
                    ),
                    Image.asset(
                      'images/blooddrop_img.png',
                      width: _src.setWidth(24),
                      height: _src.setHeight(24),
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Text(
                      '혈압',
                      style: TextStyle(
                          color: _reclinerColor.dark1,
                          fontSize: _src.setSp(13)),
                    ),
                    Container(
                      width: _src.setWidth(58),
                    ),
                    Text(
                      '${data.systolic.toInt()}/${data.diastolic.toInt()}',
                      style: TextStyle(
                          fontSize: _src.setSp(13),
                          color: _reclinerColor.secondary1,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Text(
                      'mmHg',
                      style: TextStyle(
                          fontSize: _src.setSp(13),
                          color: _reclinerColor.dark2),
                    )
                  ],
                ),
                Container(
                  height: _src.setHeight(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: _src.setWidth(18),
                    ),
                    Image.asset(
                      'images/stress_img.png',
                      width: _src.setWidth(24),
                      height: _src.setHeight(24),
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Text(
                      '스트레스',
                      style: TextStyle(
                          color: _reclinerColor.dark1,
                          fontSize: _src.setSp(13)),
                    ),
                    Container(
                      width: _src.setWidth(32),
                    ),
                    Text(
                      data.stress.toInt().toString(),
                      style: TextStyle(
                          fontSize: _src.setSp(13),
                          color: _reclinerColor.secondary2,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    )
                  ],
                ),
                Container(
                  height: _src.setHeight(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: _src.setWidth(16),
                    ),
                    Image.asset(
                      'images/stress_img.png',
                      width: _src.setWidth(24),
                      height: _src.setHeight(24),
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Text(
                      '몸무게',
                      style: TextStyle(
                          color: _reclinerColor.dark1,
                          fontSize: _src.setSp(13)),
                    ),
                    Container(
                      width: _src.setWidth(44),
                    ),
                    Text(
                      data.weight.toInt().toString(),
                      style: TextStyle(
                          fontSize: _src.setSp(13),
                          color: _reclinerColor.secondary1,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Text(
                      'kg',
                      style: TextStyle(
                          fontSize: _src.setSp(13),
                          color: _reclinerColor.dark2),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String processDate(int recordedTime) {
    String result = '';
    DateTime inputTime = DateTime.fromMillisecondsSinceEpoch(recordedTime);
    switch (wichDate) {
      case '일':
        int hour = inputTime.hour;
        String morningAfternoon = '오전';
        if (hour > 12) {
          morningAfternoon = '오후';
        }
        result = '$morningAfternoon $hour:${inputTime.minute}';
        break;
      case '주':
        String dayName = DateFormat('EEEE').format(inputTime);
        int month = inputTime.month;
        int day = inputTime.day;
        switch (dayName) {
          case 'Monday':
            result = '$month/$day 월요일';
            break;
          case 'Tuesday':
            result = '$month/$day 화요일';
            break;
          case 'Wednesday':
            result = '$month/$day 수요일';
            break;
          case 'Thursday':
            result = '$month/$day 목요일';
            break;
          case 'Friday':
            result = '$month/$day 금요일';
            break;
          case 'Saturday':
            result = '$month/$day 토요일';
            break;
          case 'Sunday':
            result = '$month/$day 일요일';
            break;
        }
        break;
      case '월':
        String dayName = DateFormat('EEEE').format(inputTime);
        int month = inputTime.month;
        int day = inputTime.day;
        switch (dayName) {
          case 'Monday':
            result = '$month/$day 월요일';
            break;
          case 'Tuesday':
            result = '$month/$day 화요일';
            break;
          case 'Wednesday':
            result = '$month/$day 수요일';
            break;
          case 'Thursday':
            result = '$month/$day 목요일';
            break;
          case 'Friday':
            result = '$month/$day 금요일';
            break;
          case 'Saturday':
            result = '$month/$day 토요일';
            break;
          case 'Sunday':
            result = '$month/$day 일요일';
            break;
        }
        break;
    }
    return result;
  }
}
