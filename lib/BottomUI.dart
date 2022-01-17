import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

import 'Control/HeatProvider.dart';
import 'UISupport/ReclinerColor.dart';
import 'Control/ShakeProvider.dart';
class BottomUI extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _BottomUI();

}

class _BottomUI extends State<BottomUI>{

  ReclinerColor _reclinerColor = ReclinerColor();

  late HeatProvider _heatProvider;
  late ShakeProvider _shakeProvider;
  late bool _isheat;
  late bool _ishake;

  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _heatProvider = Provider.of<HeatProvider>(context);
    _shakeProvider = Provider.of<ShakeProvider>(context);
    _isheat = _heatProvider.getHeatOn();
    _ishake = _shakeProvider.getShakeOn();
    return Stack(
      children: [
        Container(
          height: _src.setHeight(52),
          child: Opacity(
            opacity: 0.3,
            child: Container(
              decoration: BoxDecoration(
                  color: _reclinerColor.grey,
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(30))),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: _src.setHeight(17),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: _src.setWidth(37),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: _src.setWidth(6),
                      height: _src.setHeight(6),
                      child: Image.asset(
                        _isheat?'images/point_img.png':'images/point_grey_img.png',
                        width: _src.setWidth(6),
                        height: _src.setHeight(6),
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
                Container(
                  width: _src.setWidth(4),
                ),
                Text(
                  '온열',
                  style: TextStyle(
                      fontSize: _src.setSp(10),
                      color: _isheat? _reclinerColor.turquoise:_reclinerColor.modeDetailTextColor,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: _src.setWidth(21),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: _src.setWidth(6),
                      height: _src.setHeight(6),
                      child: Image.asset(
                        _ishake?'images/point_img.png':'images/point_grey_img.png',
                        width: _src.setWidth(6),
                        height: _src.setHeight(6),
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
                Container(
                  width: _src.setWidth(4),
                ),
                Text(
                  '흔들',
                  style: TextStyle(
                      fontSize: _src.setSp(10),
                      color: _ishake? _reclinerColor.turquoise:_reclinerColor.modeDetailTextColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}