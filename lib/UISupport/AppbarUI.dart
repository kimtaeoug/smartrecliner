import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

import 'ReclinerColor.dart';

class AppbarUI extends StatefulWidget {

  final String name;
  final BuildContext scaffoldContext;
  AppbarUI({required Key? key,required this.name, required this.scaffoldContext})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AppbarUI(name,scaffoldContext);
}

class _AppbarUI extends State<AppbarUI> {
  String _name;
  BuildContext scaffoldContext;
  _AppbarUI(this._name, this.scaffoldContext);
  //색상
  final ReclinerColor _reclinerColor = ReclinerColor();
  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0.01,
            blurRadius: 1,
            offset: Offset(0.0, 2.0))
      ]),
      height: _src.setHeight(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/MainPage');
                },
                child: Padding(
                  padding: EdgeInsets.only(left: _src.setWidth(17)),
                  child: Image.asset(
                    'images/back_img.png',
                    width: _src.setWidth(32),
                    height: _src.setHeight(32),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                child: Text(
                  _name,
                  style: TextStyle(
                      fontSize: _src.setSp(15),
                      color: _reclinerColor.dark1,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: (){
                  Scaffold.of(context).openEndDrawer();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: _src.setWidth(18)),
                  child: Image.asset(
                    'images/menu_img.png',
                    width: _src.setWidth(32),
                    height: _src.setHeight(32),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
