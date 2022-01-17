import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

class MemberShipStart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MemberShipStartUI();
  }
}

class MemberShipStartUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MemberShipStartUI();
}

class _MemberShipStartUI extends State<MemberShipStartUI> {
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  @override
  void initState() {
    super.initState();
  }

  ScreenUtilAPI _screenUtil = ScreenUtilAPI();
  @override
  Widget build(BuildContext context) {
    ScreenUtil _screenUtilAPI = _screenUtil.getScreenUtil();
    return SafeArea(
        child: WillPopScope(
      child: Scaffold(
        body: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _screenUtilAPI.setWidth(254),
                height: _screenUtilAPI.setHeight(71),
                child: Text('자코모와 함께\n나만의 케어를 시작하세요', style: TextStyle(fontWeight: FontWeight.bold, color: _reclinerColor.turquoise, fontSize: _screenUtilAPI.setSp(21)),),
              ),
              Container(
                height: _screenUtilAPI.setHeight(412),
              ),
              Container(
                width: _screenUtilAPI.setWidth(239),
                height: _screenUtilAPI.setHeight(60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: _reclinerColor.turquoise
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/PatternAuth');
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('가입하기', style: TextStyle(fontSize: _screenUtilAPI.setSp(17),color: _reclinerColor.white1),),
                  ),
                ),
              ),
              Container(
                height: _screenUtilAPI.setHeight(26),
              ),
              Container(
                width: _screenUtilAPI.setWidth(81),
                height: _screenUtilAPI.setHeight(21),
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
}
