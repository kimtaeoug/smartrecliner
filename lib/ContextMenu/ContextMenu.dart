
import 'package:flutter/cupertino.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ContextMenuUI extends StatelessWidget{
  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  //ReponsiveUI
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    return SizedBox(
      width: _src.setHeight(36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: _src.setHeight(7),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: _src.setWidth(7.2),
                height: _src.setHeight(10),
                child: Image.asset('images/context_recten_img.png'),
              ),
              SizedBox(
                width: _src.setWidth(7.2),
                height: _src.setHeight(10),
                child: Image.asset('images/context_circle_img.png'),
              ),
              SizedBox(
                width: _src.setWidth(7.2),
                height: _src.setHeight(10),
                child: Image.asset('images/context_trialg_img.png'),
              )
            ],
          ),
          Container(
            height: _src.setHeight(7),
          )
        ],
      ),
    );
  }

}