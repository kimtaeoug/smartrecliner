import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';
import 'package:smartrecliner_flutter/Health/HistoryHealthItemUI.dart';
import 'package:smartrecliner_flutter/History/HistoryListItem.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

import 'HistoryProvider2.dart';

class HistoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _HistoryList();
}

class _HistoryList extends State<HistoryList> {
  ReclinerColor _reclinerColor = ReclinerColor();
  late HistoryProvider2 _historyProvider;
  late String wichDate;

  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _historyProvider =  Provider.of<HistoryProvider2>(context);
    _src = _screenUtilAPI.getScreenUtil();
    wichDate = _historyProvider.getWichDate();
    return Expanded(
      child: historyList(),
    );
  }

  Widget historyList() {
    List<HistoryApiResponse> inputData = [];
    switch (wichDate) {
      case '일':
        inputData = _historyProvider.requestGetDayData();
        break;
      case '주':
        inputData = _historyProvider.requestGetWeekData();
        break;
      case '월':
        inputData = _historyProvider.requestGetMonthData();

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
          return HistoryListItem(
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
