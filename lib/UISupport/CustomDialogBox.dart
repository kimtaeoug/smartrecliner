import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

import 'ReclinerColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


//popup
//초기상태로 복귀
//움직임 감지_측정 취소
//측정 결과 삭제
//계속 측정
//자리이탈 감지
//낮잠모드
//흔들기능종료
//리클라이너 연결
class CustomDialogBox extends StatefulWidget {
  final String mode;
  final String? title, contents, noText, yesText;

  CustomDialogBox({required Key? key,
    required this.mode,
    required this.title,
    required this.contents,
    required this.noText,
    required this.yesText})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _CustomDialogBox(
          mode,
          title,
          contents,
          noText,
          yesText);
}

class _CustomDialogBox extends State<CustomDialogBox> {
  String? title, contents, noText, yesText;
  String mode;

  _CustomDialogBox(this.mode, this.title,
      this.contents, this.noText, this.yesText);

  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _scr;
  @override
  Widget build(BuildContext context) {
    _scr = _screenUtilAPI.getScreenUtil();
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0,
      backgroundColor: _reclinerColor.white1,
      child: dialogBox(),
    );
  }

  Widget dialogBox() {
    return Container(
      width: _scr.setWidth(284),
      height: _scr.setHeight(204),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: _scr.setHeight(153),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getTitleWidget(),
                title != null
                    ? Container(
                  height: _scr.setHeight(17),
                )
                    : Container(),
                Container(
                  width: _scr.setWidth(284),
                  child: Text(
                    contents!,
                    style: TextStyle(
                        color: _reclinerColor.dark1,
                        fontSize: _scr.setSp(13)),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: _scr.setWidth(284),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    noButtonByContents();
                  },
                  child: Container(
                    width: _scr.setWidth(142),
                    decoration: BoxDecoration(
                        color: _reclinerColor.dark2,
                        borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30))),
                    height: _scr.setHeight(51),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        noText!,
                        style: TextStyle(color: _reclinerColor.white1),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    yesButtonByContents();
                  },
                  child: Container(
                    width: _scr.setWidth(142),
                    decoration: BoxDecoration(
                        color: _reclinerColor.turquoise,
                        borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(30))),
                    height: _scr.setHeight(51),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        yesText!,
                        style: TextStyle(color: _reclinerColor.white1),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getTitleWidget() {
    if (title != null) {
      Widget showTitle = titleGreen(title!);
      switch (title) {
        case '낮잠모드':
          showTitle = titleBlack(title!);
          break;
        case '리클라이너 연결':
          showTitle = titleBlack(title!);
          break;
      }
      return showTitle;
    } else {
      return Container();
    }
  }

  Widget titleBlack(String title) {
    return Container(
      width: _scr.setWidth(284),
      child: Text(
        title,
        style: TextStyle(
            fontSize: _scr.setSp(15),
            color: _reclinerColor.dark1,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget titleGreen(String title) {
    return Container(
      width: _scr.setWidth(284),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/info_img.png',
            width: _scr.setWidth(24),
            height: _scr.setHeight(24),
            fit: BoxFit.fill,
          ),
          Text(title,
              style: TextStyle(
                  color: _reclinerColor.turquoise,
                  fontSize: _scr.setSp(15),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center)
        ],
      ),
    );
  }

  dynamic noButtonByContents() {
    switch (mode) {
      case '리클라이너 연결':
        return SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }
  dynamic yesButtonByContents() {
    switch (mode) {
      case '리클라이너 연결':
        // return Navigator.pushNamed(context, '/MemberShipStart');
        return Navigator.pushNamed(context, '/BLEScanBlue');

    }
  }
}
