import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/BleProvider.dart';
import 'package:smartrecliner_flutter/ContextMenu/ContextMenu.dart';
import 'package:smartrecliner_flutter/Drawer/DrawerUI.dart';
import 'package:smartrecliner_flutter/UISupport/AppbarUI.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

class Measure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeasureUI();
  }
}

class MeasureUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MeasureUI();
}

class _MeasureUI extends State<MeasureUI> {
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();


  late BleProvider _bleProvider;

  @override
  void initState() {
    super.initState();
  }
  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _bleProvider = Provider.of<BleProvider>(context);
    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          endDrawer: DrawerUI(),
          body: Builder(
            builder: (context){
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ContextMenuUI(),
                      Container(
                        width: _src.setWidth(12),
                      )
                    ],
                  ),
                  AppbarUI(name: '건강측정',scaffoldContext: context, key: null,),
                  Container(
                    height: _src.setHeight(106),
                  ),
                  Container(
                    width: _src.setWidth(324),
                    height: _src.setHeight(27),
                    child: Text(
                      '스마트 리클라이너에서는',
                      style: TextStyle(
                          fontSize: _src.setSp(18),
                          color: _reclinerColor.blackblack),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: _src.setWidth(324),
                    height: _src.setHeight(27),
                    child: Text(
                      '심박수, 혈압, 스트레스, 체중',
                      style: TextStyle(
                          fontSize: _src.setSp(18),
                          color: _reclinerColor.primaryCjkr,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: _src.setWidth(324),
                    height: _src.setHeight(27),
                    child: Text(
                      '을 측정합니다',
                      style: TextStyle(
                          fontSize: _src.setSp(18),
                          color: _reclinerColor.blackblack),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: _src.setHeight(25),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/Measuring');
                      _bleProvider.measureStart();
                    },
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: _src.setWidth(188),
                            height: _src.setHeight(188),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment(0.0, -1.0),
                                    end: Alignment(0.0, 1.0),
                                    colors: [Color(0xffffffff), Color(0xffe6d3ec)])),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: _src.setWidth(188),
                            height: _src.setHeight(188),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: Container(
                                  width: _src.setWidth(185),
                                  height: _src.setHeight(185),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                          begin: Alignment(0.0, -1.0),
                                          end: Alignment(0.0, 1.0),
                                          colors: [Color(0xff00c1b4), Color(0xffd9b1e5)])),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: _src.setWidth(188),
                            height: _src.setHeight(188),
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('측정시작', style: TextStyle(fontWeight: FontWeight.bold, fontSize: _src.setSp(23),color: Colors.white,),textAlign: TextAlign.center,),
                                  Container(
                                    height: _src.setHeight(1),
                                  ),
                                  Text('소요시간 약 1분', style: TextStyle(fontWeight: FontWeight.bold, fontSize: _src.setSp(13),color: Colors.white,),textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: _src.setHeight(63),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/info_img.png', width: _src.setWidth(24),height: _src.setHeight(24),fit: BoxFit.fill,),
                      Text('잠깐!확인해주세요',style: TextStyle(fontSize: _src.setSp(13), color: _reclinerColor.turquoise),)
                    ],
                  )
                ],
              );
            },
          ),
        ),
        onWillPop: () {
          return Future(()=>false);
        },
      ),
    );
  }
}

