import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';
import 'package:smartrecliner_flutter/Dto/MeasureResultDto.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

class DetailResult extends StatefulWidget {
  final HistoryApiResponse? data;
  DetailResult({required Key? key, required this.data});
  @override
  State<StatefulWidget> createState() => _DetailResult(data);
}

class _DetailResult extends State<DetailResult> {
  HistoryApiResponse? data;

  _DetailResult(this.data);

  //색상
  ReclinerColor _reclinerColor = ReclinerColor();



  //dummy data
  MeasureResultDto dummyData = MeasureResultDto(1, 12, 90, 72, 125, 68, 40);
  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    return detailResultStructure();
  }
  Widget detailResultStructure(){
    if(data != null){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          detailResultItem('심박수', data!.heartRate),
          Container(
            color: _reclinerColor.white2,
            height: _src.setHeight(8),
          ),
          bloodPressureResultItem(data!.systolic, data!.diastolic),
          Container(
            color: _reclinerColor.white2,
            height: _src.setHeight(8),
          ),
          detailResultItem('스트레스', data!.stress),
          Container(
            color: _reclinerColor.white2,
            height: _src.setHeight(8),
          ),
          weightResult(data!.weight)
        ],
      );
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          detailResultItem('심박수', dummyData.heartRate),
          Container(
            color: _reclinerColor.white2,
            height: _src.setHeight(8),
          ),
          bloodPressureResultItem(dummyData.systolic, dummyData.diastolic),
          Container(
            color: _reclinerColor.white2,
            height: _src.setHeight(8),
          ),
          detailResultItem('스트레스', dummyData.stress),
          Container(
            color: _reclinerColor.white2,
            height: _src.setHeight(8),
          ),
          weightResult(dummyData.weight)
        ],
      );
    }
  }
  Widget detailResultItem(String item, double value) {
    bool _isHr = false;
    if (item == '심박수') {
      _isHr = true;
    } else {
      _isHr = false;
    }
    return Container(
      height: _src.setHeight(162),
      color: _reclinerColor.white1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item,
                  style: TextStyle(
                      fontSize: _src.setSp(15)),
                ),
                Container(
                  width: _src.setWidth(8),
                ),
                Text(
                  value.toInt().toString(),
                  style: TextStyle(
                      fontSize: _src.setSp(24),
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: _src.setWidth(6),
                ),
                _isHr
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'bpm',
                            style: TextStyle(
                                fontSize:
                                    _src.setSp(11),
                                color: _reclinerColor.dark2),
                          )
                        ],
                      )
                    : Container(),
                Container(
                  width: _src.setWidth(112),
                ),
                rateState()
              ],
            ),
            height: _src.setHeight(26),
          ),
          rateGraph(item, value)
        ],
      ),
    );
  }

  Widget bloodPressureResultItem(double sysValue, double disValue) {
    return Container(
      height: _src.setHeight(251),
      color: _reclinerColor.white1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '혈압',
                  style: TextStyle(
                      fontSize: _src.setSp(15),
                      color: _reclinerColor.dark1),
                ),
                Container(
                  width: _src.setWidth(8),
                ),
                Text(
                  sysValue.toInt().toString(),
                  style: TextStyle(
                      fontSize: _src.setSp(24),
                      color: _reclinerColor.dark1),
                ),
                Container(
                  width: _src.setWidth(8),
                ),
                Text(
                  '/',
                  style: TextStyle(
                      fontSize: _src.setSp(24),
                      color: Color(0xffacacac)),
                ),
                Container(
                  width: _src.setWidth(7),
                ),
                Text(
                  disValue.toInt().toString(),
                  style: TextStyle(
                      fontSize: _src.setSp(24),
                      color: _reclinerColor.dark1),
                ),
                Container(
                  width: _src.setWidth(6),
                ),
                Text(
                  'mmHg',
                  style: TextStyle(
                      fontSize: _src.setSp(11),
                      color: _reclinerColor.dark2),
                ),
                Container(
                  width: _src.setWidth(38),
                ),
                rateState()
              ],
            ),
          ),
          Container(
            height: _src.setHeight(16),
          ),
          Container(
            width: _src.setWidth(288),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '수축기',
                  style: TextStyle(
                      fontSize: _src.setSp(11),
                      color: _reclinerColor.dark1),
                ),
                Container(
                  width: _src.setWidth(4),
                ),
                Text(
                  sysValue.toString(),
                  style: TextStyle(
                      fontSize: _src.setSp(11),
                      color: _reclinerColor.dark1,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: _src.setHeight(6),
                )
              ],
            ),
          ),
          rateGraph('혈압', sysValue),
          Container(
            width: _src.setWidth(288),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '이완기',
                  style: TextStyle(
                      fontSize: _src.setSp(11),
                      color: _reclinerColor.dark1),
                ),
                Container(
                  width: _src.setWidth(4),
                ),
                Text(
                  disValue.toString(),
                  style: TextStyle(
                      fontSize: _src.setSp(11),
                      color: _reclinerColor.dark1,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: _src.setHeight(6),
                )
              ],
            ),
          ),
          rateGraph('혈압', disValue),
          Container(
            height: _src.setHeight(8),
          ),
          guideAsRate('혈압')
        ],
      ),
    );
  }

  Widget rateState() {
    return Container(
      width: _src.setWidth(50),
      height: _src.setHeight(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: _reclinerColor.turquoise,
      ),
      child: Text(
        '정상',
        style: TextStyle(
          color: _reclinerColor.white1,
          fontSize: _src.setSp(13),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget rateGraph(String item, double value) {
    bool _isHR= false;
    if(item == '혈압'){
      _isHR = true;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: _src.setHeight(_isHR? 6 :15),
        ),
        Stack(
          children: [
            Container(
              width: _src.setWidth(288),
              height: _src.setHeight(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: _src.setHeight(18),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: _reclinerColor.grey2),
                        color: _reclinerColor.white1),
                  )
                ],
              ),
            ),
            graphUnit(item),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                showGraphValue(item, value),
              ],
            )
          ],
        ),
        Container(
          height: _src.setHeight(1),
        ),
        graphRange(item),
        Container(
          height: _src.setHeight(8),
        ),
        _isHR?Container():guideAsRate(item)
      ],
    );
  }

  Widget showGraphValue(String item, double value) {
    double _valueWidth = 0;
    print('value : $value');
    switch (item) {
      case '스트레스':
        _valueWidth = 288/100  * value;
        if(_valueWidth > 281){
          _valueWidth = 282;
        }
        break;
      case '심박수':
        _valueWidth = 288/150  * value;
        if(_valueWidth > 281){
          _valueWidth = 282;
        }
        break;
      case '혈압':
        _valueWidth = 288/220 * value;
        if(_valueWidth > 281){
          _valueWidth = 282;
        }
        break;
    }
    return Container(
      width: _src.setWidth(288),
      height: _src.setHeight(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: _src.setWidth(_valueWidth),
          ),
          Container(
            width: _src.setWidth(6),
            height: _src.setHeight(24),
            decoration: BoxDecoration(
                border: Border.all(color: _reclinerColor.grey),
                color: _reclinerColor.white1,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: _src.setWidth(4),
                      height: _src.setHeight(22),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(
                              begin: Alignment(0.0, -1.0),
                              end: Alignment(0.0, 1.0),
                              colors: [Color(0xff00c1b4), Color(0xffd9b1e5)])),
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

  Widget graphUnit(String item) {
    int unitCount = 0;
    int unitSpace = 0;
    switch (item) {
      case '스트레스':
        unitCount = 9;
        unitSpace = 28;
        break;
      case '심박수':
        unitCount = 12;
        unitSpace = 21;
        break;
      case '혈압':
        unitCount = 17;
        unitSpace = 14;
        break;
    }
    return Container(
      width: _src.setWidth(288),
      height: _src.setHeight(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: unitCount,
            itemBuilder: (itemBuilder, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _src.setWidth(2),
                    height: _src.setHeight(5),
                    color: Color(0xffdbdbdb),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                width:
                    _src.setWidth(unitSpace.toDouble()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget graphRange(String item) {
    int startRange = 0;
    int endRange = 0;
    switch (item) {
      case '스트레스':
        startRange = 0;
        endRange = 100;
        break;
      case '심박수':
        startRange = 20;
        endRange = 150;
        break;
      case '혈압':
        startRange = 40;
        endRange = 220;
        break;
    }
    return Container(
      width: _src.setWidth(288),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            startRange.toString(),
            style: TextStyle(
                color: Color(0xff363636),
                fontSize: _src.setSp(7)),
          ),
          Text(
            endRange.toString(),
            style: TextStyle(
                color: Color(0xff363636),
                fontSize: _src.setSp(7)),
          ),
        ],
      ),
    );
  }

  Widget guideAsRate(String item) {
    String resultText = '';
    switch (item) {
      case '심박수':
        resultText = '적정 심박수가 측정되었습니다.';
        break;
      case '혈압':
        resultText = '적정 혈압이 측정되었습니다.';
        break;
      case '스트레스':
        resultText = '조금 피곤하신 것 같아요 나의 스트레스 원인을 점검해 보세요.';
        break;
    }
    return Container(
      width: _src.setWidth(288),
      child: Text(
        resultText,
        style: TextStyle(
            fontSize: _src.setSp(11),
            color: _reclinerColor.dark1),
      ),
    );
  }

  Widget weightResult(double weight) {
    return Container(
      color: _reclinerColor.white1,
      height: _src.setHeight(90),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: _src.setWidth(35),
          ),
          Text(
            '몸무게',
            style: TextStyle(
                fontSize: _src.setSp(15),
                color: _reclinerColor.dark1),
          ),
          Container(
            width: _src.setWidth(8),
          ),
          Text(
            weight.toInt().toString(),
            style: TextStyle(
                fontSize: _src.setSp(30),
                color: _reclinerColor.dark1,
                fontWeight: FontWeight.bold),
          ),
          Container(
            width: _src.setWidth(6),
          ),
          Text(
            'kg',
            style: TextStyle(
                fontSize: _src.setSp(11),
                color: _reclinerColor.dark2),
          )
        ],
      ),
    );
  }
}
