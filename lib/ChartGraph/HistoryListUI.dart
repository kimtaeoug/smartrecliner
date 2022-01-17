import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';
import 'package:smartrecliner_flutter/Health/HistoryHealthItemUI.dart';
import 'package:smartrecliner_flutter/History/NewHistoryProvider.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

class HistoryListUI extends StatefulWidget {
  final List<HistoryApiResponse> data;
  final DateTime showDateTime;

  HistoryListUI(
      {required Key? key,
      required this.data,
      required this.showDateTime})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _HistoryListUI(data,showDateTime);
}

class _HistoryListUI extends State<HistoryListUI> {
  List<HistoryApiResponse> data;
  DateTime showDateTime;

  _HistoryListUI(this.data, this.showDateTime);

  ReclinerColor _reclinerColor = ReclinerColor();

  late NewHistoryProvider _newHistoryProvider;
  late String wichDate;

  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _newHistoryProvider = Provider.of<NewHistoryProvider>(context);
    wichDate = _newHistoryProvider.getWichDate();
    return Expanded(
      child: historyList(),
    );
  }

  Widget historyList() {
    List<HistoryApiResponse> inputData = [];
    switch (wichDate) {
      case '일':
        // inputData = _historyProvider.getDayData(data,showDateTime);
        break;
      case '주':
        // inputData = _historyProvider.getWeekData(data,showDateTime);
        break;
      case '월':
        // inputData = _historyProvider.getMonthData(data);
        break;
    }
    if (inputData.isEmpty) {
      return Container(
        width: _src.setWidth(324),
        child: Center(
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
                    fontSize: _src.setHeight(15),
                    color: _reclinerColor.dark2),
              ),
              Container(
                height: _src.setHeight(2),
              ),
              Text(
                '메뉴를 눌러 건강측정을 할 수 있어요.',
                style: TextStyle(
                    fontSize: _src.setHeight(12),
                    color: _reclinerColor.dark2),
              )
            ],
          ),
        ),
      );
    } else {
      return ListView.separated(
          itemCount: inputData.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return HistoryHealthItemUI(
                key: null,
                data: inputData[index]);
          },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: _src.setHeight(12),
          );
      },);
    }
  }
}
