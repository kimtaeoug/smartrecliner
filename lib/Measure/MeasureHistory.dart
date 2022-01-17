// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:smartrecliner_flutter/Api/HistoryAPI.dart';
// import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';
// import 'package:smartrecliner_flutter/ChartGraph/BloodPressureGraphUI.dart';
// import 'package:smartrecliner_flutter/ChartGraph/HistoryListUI.dart';
// import 'package:smartrecliner_flutter/ChartGraph/ReclinerGraphUI.dart';
// import 'package:smartrecliner_flutter/ContextMenu/ContextMenu.dart';
// import 'package:smartrecliner_flutter/Control/ControlUI.dart';
// import 'package:smartrecliner_flutter/Control/RemoteContolProvider.dart';
// import 'package:smartrecliner_flutter/Drawer/DrawerUI.dart';
// import 'package:smartrecliner_flutter/History/NewHistoryProvider.dart';
// import 'package:smartrecliner_flutter/UISupport/AppbarUI.dart';
// import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
// import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
// import '../BottomUI.dart';
// import 'HistoryControlDate.dart';
// import 'HistoryProvider.dart';
// import 'HistroyControlGraph.dart';
//
// class MeasureHistory extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => MeasureHistoryUI();
// }
//
// class MeasureHistoryUI extends State<MeasureHistory> {
//   //색상
//   ReclinerColor _reclinerColor = ReclinerColor();
//
//   //HealthItemUnit
//   String _healthItemUnit = '심박수';
//
//   //Remote Control
//   late RemoteContolProvider _remoteContolProvider;
//
//   // late HistoryProvider _historyProvider;
//   late NewHistoryProvider _newHistoryProvider;
//
//   //주 데이터
//   late List<HistoryApiResponse> weekData;
//
//   //일 데이터
//   late List<HistoryApiResponse> dayData;
//
//   //월 데이터
//   late List<HistoryApiResponse> monthData;
//
//   bool _isRequested = false;
//
//   late String wichDate;
//   late String wichMode;
//   late List<HistoryApiResponse> rawData;
//
//   int _dayIndex = 0;
//   int _weekIndex = 0;
//   int _monthIndex = 0;
//   DateTime _showDateTime = DateTime(0);
//
//   @override
//   void initState() {
//     super.initState();
//     requestHistoryData();
//   }
//   Future<void> requestHistoryData() async {
//     DateTime rowTime = DateTime.now();
//     DateTime time = DateTime(rowTime.year, rowTime.month, 24, 59);
//     _newHistoryProvider.setDayData('test', time);
//     _newHistoryProvider.setWeekData('test', time);
//     _newHistoryProvider.setMonthData('test', time);
//     // DateTime now = DateTime.now();
//     // DateTime beforeMonth = DateTime(now.year, now.month - 1, now.day);
//     // final client =
//     //     HistoryAPI(Dio(BaseOptions(contentType: "application/json")));
//     // await client
//     //     .getHistory(beforeMonth.millisecondsSinceEpoch,
//     //         now.millisecondsSinceEpoch, 'RAW')
//     //     .then((value) async {
//     //   setState(() {
//     //     rawData = value;
//     //     monthData = _historyProvider.getMonthData(value);
//     //     _historyProvider.requestSetMonthData(monthData);
//     //     weekData = _historyProvider.getWeekData(value, now);
//     //     _historyProvider.requestSetWeekData(weekData);
//     //     dayData = _historyProvider.getDayData(value, now);
//     //     _historyProvider.requestSetDayData(dayData);
//     //     _showDateTime = now;
//     //     _isRequested = true;
//     //   });
//     // });
//   }
//   ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
//   late ScreenUtil _src;
//
//   @override
//   Widget build(BuildContext context) {
//     _src = _screenUtilAPI.getScreenUtil();
//     _remoteContolProvider = Provider.of<RemoteContolProvider>(context);
//     _newHistoryProvider = Provider.of<NewHistoryProvider>(context);
//     wichDate = _newHistoryProvider.getWichDate();
//     wichMode = _newHistoryProvider.getWichMode();
//     return SafeArea(
//         child: WillPopScope(
//       child: Scaffold(
//         endDrawer: DrawerUI(),
//         body: Builder(
//           builder: (context) {
//             return Stack(
//               children: [
//                 Container(
//                   color: _reclinerColor.white1,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       topUI(),
//                       Container(
//                         height: _src.setHeight(13),
//                       ),
//                       bodyUI(),
//                       Container(
//                         height: _src.setHeight(72),
//                         color: Colors.white,
//                         child: Stack(
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 BottomUI(),
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     remoteController(),
//                                     Container(
//                                       width: _src.setWidth(26),
//                                     )
//                                   ],
//                                 ),
//                                 Container(
//                                   height: _src.setHeight(15),
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 _remoteContolProvider.getOpenControl()
//                     ? ControlUI()
//                     : Container(),
//                 // _buildBody(context)
//               ],
//             );
//           },
//         ),
//       ),
//       onWillPop: () {
//         return Future(() => false);
//       },
//     ));
//   }
//
//   Widget topUI() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ContextMenuUI(),
//             Container(
//               width: _src.setWidth(8),
//             )
//           ],
//         ),
//         AppbarUI(
//           name: '지난 측정 내역',
//           scaffoldContext: context,
//           key: null,
//         )
//       ],
//     );
//   }
//
//   Widget bodyUI() {
//     return Flexible(
//         child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             HistoryControlDate(),
//             Container(
//               width: _src.setWidth(21),
//             ),
//             HistoryControlGraph()
//           ],
//         ),
//         Container(
//           height: _src.setHeight(19),
//         ),
//         measureDate(),
//         Container(
//           height: _src.setHeight(22),
//         ),
//         wichMode == 'list' ? buildList() : buildGraph(),
//       ],
//     ));
//   }
//
//   Widget buildList() {
//     return Container(
//       child: _isRequested
//           ? HistoryListUI(
//               data: rawData,
//               showDateTime: _showDateTime,
//               key: null,
//             )
//           : Container(
//               width: _src.setWidth(324),
//               height: _src.setHeight(375),
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//     );
//   }
//
//   Widget buildGraph() {
//     return Container(
//         child: Align(
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               healthGraphUnitUI('심박수'),
//               Container(
//                 width: _src.setWidth(15),
//               ),
//               healthGraphUnitUI('혈압'),
//               Container(
//                 width: _src.setWidth(15),
//               ),
//               healthGraphUnitUI('스트레스'),
//               Container(
//                 width: _src.setWidth(15),
//               ),
//               healthGraphUnitUI('몸무게'),
//               Container(
//                 width: _src.setWidth(15),
//               ),
//             ],
//           ),
//           Container(
//             height: _src.setHeight(27),
//           ),
//           _isRequested
//               ? historyGraph()
//               : Container(
//                   width: _src.setWidth(331),
//                   height: _src.setHeight(301),
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//         ],
//       ),
//     ));
//   }
//
//   Widget remoteController() {
//     return Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.grey.withOpacity(0.4),
//                   spreadRadius: 0.01,
//                   blurRadius: 1,
//                   offset: Offset(-1.5, 3.0))
//             ],
//             color: _reclinerColor.turquoise,
//           ),
//           width: _src.setWidth(57),
//           height: _src.setHeight(57),
//         ),
//         Container(
//           width: _src.setWidth(57),
//           height: _src.setHeight(57),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     child: Image.asset(
//                       'images/remoter_img.png',
//                       width: _src.setWidth(17),
//                       height: _src.setHeight(36),
//                       fit: BoxFit.fill,
//                     ),
//                     onTap: () {
//                       _remoteContolProvider.setOpenControl(true);
//                     },
//                   )
//                 ],
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
//
//   Widget measureDate() {
//     return Container(
//       height: _src.setHeight(34),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: _src.setWidth(62)),
//             child: Container(
//               width: _src.setWidth(34),
//               height: _src.setHeight(34),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey.withOpacity(0.4),
//                         spreadRadius: 0.01,
//                         blurRadius: 1,
//                         offset: Offset(0.0, 2.0))
//                   ]),
//               child: InkWell(
//                 onTap: () {
//                   setState(() {
//                     switch (wichDate) {
//                       case '일':
//                         _dayIndex -= 1;
//                         break;
//                       case '주':
//                         _weekIndex -= 1;
//                         break;
//                       case '월':
//                         _monthIndex -= 1;
//                         break;
//                     }
//                     requestMoreHistoryData();
//                   });
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           'images/measure_previous_history_img.png',
//                           width: _src.setWidth(22),
//                           height: _src.setHeight(22),
//                           fit: BoxFit.fill,
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Text(
//             getDateData(),
//             style: TextStyle(
//                 fontSize: _src.setSp(19), color: _reclinerColor.dark1),
//           ),
//           Padding(
//             padding: EdgeInsets.only(right: _src.setWidth(62)),
//             child: Container(
//               width: _src.setWidth(34),
//               height: _src.setHeight(34),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey.withOpacity(0.4),
//                         spreadRadius: 0.01,
//                         blurRadius: 1,
//                         offset: Offset(0.0, 2.0))
//                   ]),
//               child: InkWell(
//                 onTap: () {
//                   setState(() {
//                     switch (wichDate) {
//                       case '일':
//                         _dayIndex += 1;
//                         break;
//                       case '주':
//                         _weekIndex += 1;
//                         break;
//                       case '월':
//                         _monthIndex += 1;
//                         break;
//                     }
//                     requestMoreHistoryData();
//                   });
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           'images/measure_next_history_img.png',
//                           width: _src.setWidth(22),
//                           height: _src.setHeight(22),
//                           fit: BoxFit.fill,
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String getDateData() {
//     String result = '';
//     DateTime now = _showDateTime;
//     switch (wichDate) {
//       case '일':
//         String dayName = DateFormat('EEEE').format(now);
//         switch (dayName) {
//           case 'Monday':
//             result = '${now.month}월 ${now.day}일 월요일';
//             break;
//           case 'Tuesday':
//             result = '${now.month}월 ${now.day}일 화요일';
//             break;
//           case 'Wednesday':
//             result = '${now.month}월 ${now.day}일 수요일';
//             break;
//           case 'Thursday':
//             result = '${now.month}월 ${now.day}일 목요일';
//             break;
//           case 'Friday':
//             result = '${now.month}월 ${now.day}일 금요일';
//             break;
//           case 'Saturday':
//             result = '${now.month}월 ${now.day}일 토요일';
//             break;
//           case 'Sunday':
//             result = '${now.month}월 ${now.day}일 일요일';
//             break;
//         }
//         break;
//       case '주':
//         DateTime weekago = now.subtract(Duration(days: 7));
//         if (now.year == weekago.year) {
//           if (now.month == weekago.month) {
//             result = '${now.month}월 ${weekago.day}일-${now.day}일';
//           } else {
//             result =
//                 '${weekago.month}월 ${weekago.day}일-${now.month}월 ${now.day}일';
//           }
//         } else {
//           result =
//               '${weekago.month}월 ${weekago.day}일-${now.month}월 ${now.day}일';
//         }
//         break;
//       case '월':
//         result = '${now.month}월';
//         break;
//     }
//     return result;
//   }
//
//   Widget healthGraphUnitUI(String itemName) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         InkWell(
//           onTap: () {
//             setState(() {
//               _healthItemUnit = itemName;
//             });
//           },
//           child: Container(
//             width: _src.setWidth(68),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   getHealthItemData(itemName),
//                   width: _src.setWidth(24),
//                   height: _src.setHeight(24),
//                   fit: BoxFit.fill,
//                 ),
//                 Container(
//                   width: _src.setWidth(2),
//                 ),
//                 Text(
//                   itemName,
//                   style: TextStyle(
//                       fontSize: _src.setSp(10),
//                       color: _reclinerColor.dark1,
//                       fontWeight: _healthItemUnit == itemName
//                           ? FontWeight.bold
//                           : FontWeight.normal),
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
//
//   String getHealthItemData(String itemName) {
//     String _imgAddress = '';
//     if (_healthItemUnit != itemName) {
//       switch (itemName) {
//         case '심박수':
//           _imgAddress = 'images/blooddrop_img.png';
//           break;
//         case '혈압':
//           _imgAddress = 'images/heartgrey_img.png';
//           break;
//         case '스트레스':
//           _imgAddress = 'images/stress_img.png';
//           break;
//         case '몸무게':
//           _imgAddress = 'images/weight_img.png';
//           break;
//       }
//     } else {
//       switch (itemName) {
//         case '심박수':
//           _imgAddress = 'images/blooddrop_black_img.png';
//           break;
//         case '혈압':
//           _imgAddress = 'images/heart_black_img.png';
//           break;
//         case '스트레스':
//           _imgAddress = 'images/stress_black_img.png';
//           break;
//         case '몸무게':
//           _imgAddress = 'images/weight_black_img.png';
//           break;
//       }
//     }
//     return _imgAddress;
//   }
//
//
//   Widget historyGraph() {
//     List<HistoryApiResponse> wichData = [];
//     switch (wichDate) {
//       case '일':
//         wichData = dayData;
//         break;
//       case '주':
//         wichData = weekData;
//         break;
//       case '월':
//         wichData = monthData;
//         break;
//     }
//     if (wichData.isNotEmpty) {
//       if (_healthItemUnit != '혈압') {
//         return CustomPaint(
//           size: Size(_src.setWidth(331), _src.setHeight(309)),
//           foregroundPainter: ReclinerGraphUI(
//               healthItem: _healthItemUnit,
//               data: _historyProvider.getHealthData(_healthItemUnit, wichData),
//               labels: _historyProvider.getTimeData(wichDate, wichData)),
//         );
//       } else {
//         return CustomPaint(
//           size: Size(_src.setWidth(331), _src.setHeight(309)),
//           foregroundPainter: BloodPressureGraphUI(
//               healthItem: _healthItemUnit,
//               sdata: _historyProvider.getSystolicData(wichData),
//               ddata: _historyProvider.getDiastolicData(wichData),
//               labels: _historyProvider.getTimeData(wichDate, wichData)),
//         );
//       }
//     } else {
//       return Container(
//         width: _src.setWidth(331),
//         height: _src.setHeight(309),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'images/healthnodata_img.png',
//               width: _src.setWidth(111),
//               height: _src.setHeight(92),
//               fit: BoxFit.fill,
//             ),
//             Container(
//               height: _src.setHeight(16),
//             ),
//             Text(
//               '측정된 데이터가 없습니다.',
//               style: TextStyle(
//                   color: _reclinerColor.dark2, fontSize: _src.setSp(15)),
//             ),
//             Container(
//               height: _src.setHeight(2),
//             ),
//             Text(
//               '메뉴를 눌러 건강측정을 할 수 있어요.',
//               style: TextStyle(
//                   color: _reclinerColor.dark2, fontSize: _src.setSp(12)),
//             )
//           ],
//         ),
//       );
//     }
//   }
// }
