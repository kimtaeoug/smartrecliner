// import 'package:flutter/cupertino.dart';
// import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
//
// class DummyHistory extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() => _DummyHistory();
// }
//
// class _DummyHistory extends State<DummyHistory> {
//   final ReclinerColor _reclinerColor = ReclinerColor();
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
// //  //색상
// //   ReclinerColor _reclinerColor = ReclinerColor();
// //   //HealthItemUnit
// //   String _healthItemUnit = '심박수';
// //   //Remote Control
// //   late RemoteContolProvider _remoteContolProvider;
// //   late HistoryProvider2 _historyProvider;
// //
// //   late String wichDate;
// //   late String wichMode;
// //   late List<HistoryApiResponse> rawData;
// //   int _dayIndex = 0;
// //   int _weekIndex = 0;
// //   int _monthIndex = 0;
// //   DateTime _showDateTime = DateTime(0);
// //   DateTime standardTime = DateTime.now();
// //   @override
// //   void initState() {
// //     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
// //       _historyProvider =  Provider.of<HistoryProvider2>(context, listen: false);
// //       initHistoryData(_historyProvider);
// //     });
// //     super.initState();
// //   }
// //   void initHistoryData(HistoryProvider2 _historyProvider){
// //     DateTime now = DateTime.now();
// //     DateTime day = DateTime(now.year, now.month, now.day-1);
// //     DateTime week = DateTime(now.year, now.month, now.day - 7);
// //     DateTime month = DateTime(now.year, now.month -1 ,now.day);
// //     _historyProvider.requestSetDayData(day.millisecondsSinceEpoch, now.millisecondsSinceEpoch);
// //     _historyProvider.requestSetWeekData(week.millisecondsSinceEpoch, now.millisecondsSinceEpoch);
// //     _historyProvider.requestSetMonthData(month.millisecondsSinceEpoch, now.millisecondsSinceEpoch);
// //     _historyProvider.requestEnd = true;
// //   }
// //
// //   ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
// //   late ScreenUtil _src;