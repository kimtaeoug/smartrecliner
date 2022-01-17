import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:smartrecliner_flutter/ContextMenu/ContextMenu.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatternAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PatternAuthUI();
  }
}

class PatternAuthUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PatternAuthUI();
}

class _PatternAuthUI extends State<PatternAuthUI> {
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();
  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    return SafeArea(
        child: WillPopScope(
      child: Scaffold(
        body: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: _src.setHeight(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //close_black_img
                    Padding(
                      padding: EdgeInsets.all(
                          _src.setHeight(6)),
                      child: Image.asset(
                        'images/close_black_img.png',
                        width: _src.setWidth(25),
                        height: _src.setHeight(25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: _src.setWidth(8)),
                      child: ContextMenuUI(),
                    )
                  ],
                ),
              ),
                Container(
                height: _src.setHeight(60),
              ),
              Container(
                width: _src.setWidth(100),
                height: _src.setHeight(42),
                child: Text(
                  '패턴 등록',
                  style: TextStyle(
                      fontSize: _src.setSp(22),
                      color: _reclinerColor.dark1,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: _src.setHeight(25),
              ),
              Container(
                width: _src.setWidth(252),
                height: _src.setHeight(50),
                child: Text(
                  '패턴 등록을 통해 로그인할 수 있어요. 패턴을\n설정하지 않으면 자동으로 로그인돼요.',
                  style: TextStyle(
                    color: _reclinerColor.dark1,
                    fontSize: _src.setSp(12),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: _src.setHeight(80),
              ),
              pattern(),
              Container(
                height: _src.setHeight(120),
              ),
              Container(
                width: _src.setWidth(324),
                height: _src.setHeight(44),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    skip(),
                    settingEnd()
                  ],
                ),
              ),
              Container(
                height: _src.setHeight(23),
              )
            ],
          ),
        ),
      ),
      onWillPop: () {
        return Future(() => false);
      },
    ));
  }

  Widget pattern() {
    return Container(
      height: _src.setHeight(214),
      child: PatternLock(
        selectedColor: _reclinerColor.turquoise,
        //점 두께
        pointRadius: _src.setWidth(6),
        //whether show user's input and highlight selected points
        showInput: true,
        //행렬 - 3이면 3x3, 4면 4x4
        dimension: 3,
        //padding of points area relative to distance between points
        relativePadding: 0.3,
        // needed distance from input to point to select point.
        selectThreshold: 25,
        //whether fill points
        fillPoints: true,
        //callback that called when user's input complete. Called if user selected one or more points
        onInputComplete: (List<int> input) {
          print('pattern is $input');
        },
      ),
    );
  }
  Widget skip(){
    return Container(
      width: _src.setWidth(154),
      height: _src.setHeight(44),
      decoration: BoxDecoration(
        border: Border.all(color: _reclinerColor.grey),
        color: _reclinerColor.white1
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/BLEScanBlue');
        },
        child: Align(
          alignment: Alignment.center,
          child: Text('건너뛰기', style: TextStyle(fontSize: _src.setSp(20), color: _reclinerColor.grey),),
        ),
      ),
    );
  }
  Widget settingEnd(){
    return Container(
      width: _src.setWidth(154),
      height: _src.setHeight(44),
      decoration: BoxDecoration(
        border: Border.all(color: _reclinerColor.grey),
        color: _reclinerColor.grey
      ),
      child: InkWell(
        onTap: (){
          // Navigator.pushNamed(context, '/BLEScanBlue');
          Navigator.pushNamed(context, '/MainPage');
        },
        child: Align(
          alignment: Alignment.center,
          child: Text('설정완료', style: TextStyle(fontSize: _src.setSp(20), color: _reclinerColor.white1),),
        ),
      ),
    );
  }
}
