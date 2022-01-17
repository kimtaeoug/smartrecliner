import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilAPI {
  //디바이스 너비
  double deviceWidth= 0.0;

  //디바이스 높이
  double deviceHeight = 0.0;

  //디자인 너비
  final double designWidth = 360;

  //디자인 높이
  final double designHeight = 740;

  static final ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI._init();

  factory ScreenUtilAPI() => _screenUtilAPI;

  ScreenUtilAPI._init();

  ScreenUtil getScreenUtil() {
    ScreenUtil.init(
        BoxConstraints(maxWidth: this.deviceWidth, maxHeight: this.deviceHeight),
        designSize: Size(this.designWidth, this.designHeight),
        orientation: Orientation.portrait);
    ScreenUtil _screenUtil = ScreenUtil();
    return _screenUtil;
  }
}
