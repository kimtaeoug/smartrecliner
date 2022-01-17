import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
class DrawerUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerUI();
}

class _DrawerUI extends State<DrawerUI> {
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();
  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      width: _src.setWidth(276),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: _src.setWidth(276),
            height: _src.setHeight(65),
            decoration: BoxDecoration(color: _reclinerColor.white2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: _src.setWidth(24),
                    ),
                    Image.asset(
                      'images/jakomo_logo_img.png',
                      width: _src.setWidth(86),
                      height: _src.setHeight(30),
                      fit: BoxFit.fill,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: _src.setHeight(12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: _src.setHeight(18),
              ),
              Container(
                width: _src.setWidth(160),
                height: _src.setHeight(24),
                child: Text(
                  '건강',
                  style: TextStyle(
                      fontSize: _src.setSp(16),
                      fontWeight: FontWeight.bold,
                      color: _reclinerColor.dark1),
                ),
              )
            ],
          ),
          Container(
            height: _src.setHeight(12),
          ),
          Container(
            height: _src.setHeight(70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/Measure');
                  },
                  child: Container(
                    width: _src.setWidth(66),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/heart_mint_img.png',
                          width: _src.setWidth(48),
                          height: _src.setHeight(48),
                          fit: BoxFit.fill,
                        ),
                        Container(
                          height: _src.setHeight(4),
                        ),
                        Container(
                          width: _src.setWidth(66),
                          height: _src.setHeight(18),
                          child: Text(
                            '건강측정',
                            style: TextStyle(
                                fontSize: _src.setSp(11),
                                color: _reclinerColor.dark1),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: _src.setWidth(16),
                ),
                Container(
                  width: _src.setWidth(70),
                  child: InkWell(
                    onTap: (){
                      // Navigator.pushNamed(context, '/MeasureHistory');
                      Navigator.pushNamed(context, '/History');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/result_mint_img.png',
                          width: _src.setWidth(48),
                          height: _src.setHeight(48),
                          fit: BoxFit.fill,
                        ),
                        Container(
                          height: _src.setHeight(4),
                        ),
                        Container(
                          height: _src.setHeight(18),
                          child: Text(
                            '지난 측정내역',
                            style: TextStyle(
                                fontSize: _src.setSp(11),
                                color: _reclinerColor.dark1),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: _src.setWidth(19),
                ),
                Container(
                  width: _src.setWidth(66),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/breathe_mint_img.png',
                        width: _src.setWidth(48),
                        height: _src.setHeight(48),
                        fit: BoxFit.fill,
                      ),
                      Container(
                        height: _src.setHeight(4),
                      ),
                      Container(
                        height: _src.setHeight(18),
                        child: Text(
                          '호흡 훈련',
                          style: TextStyle(
                              fontSize: _src.setSp(11),
                              color: _reclinerColor.dark1),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: _src.setHeight(38),
          ),
          Container(
            height: _src.setHeight(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: _src.setWidth(18),
                ),
                Container(
                  width: _src.setWidth(160),
                  child: Text(
                    '즐겨찾기',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _src.setSp(16),
                        color: _reclinerColor.dark1),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: _src.setHeight(12),
          ),
          Container(
            height: _src.setHeight(70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: _src.setWidth(9),
                ),
                Container(
                  width: _src.setWidth(66),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/mode_add_mint_img.png',
                            width: _src.setWidth(48),
                            height: _src.setHeight(48),
                            fit: BoxFit.fill,
                          )
                        ],
                      ),
                      Container(
                        height: _src.setHeight(4),
                      ),
                      Container(
                        width: _src.setWidth(66),
                        height: _src.setHeight(18),
                        child: Text(
                          '모드 추가',
                          style: TextStyle(
                              fontSize: _src.setSp(11),
                              color: _reclinerColor.dark1),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: _src.setWidth(20),
                ),
                Container(
                  width: _src.setWidth(66),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/mode_list_mint_img.png',
                            width: _src.setWidth(48),
                            height: _src.setHeight(48),
                            fit: BoxFit.fill,
                          )
                        ],
                      ),
                      Container(
                        height: _src.setHeight(4),
                      ),
                      Container(
                        width: _src.setWidth(66),
                        height: _src.setHeight(18),
                        child: Text(
                          '모드 목록',
                          style: TextStyle(
                              fontSize: _src.setSp(11),
                              color: _reclinerColor.dark1),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: _src.setHeight(37),
          ),
          Container(
            height: _src.setHeight(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: _src.setWidth(18),
                ),
                Container(
                  width: _src.setWidth(160),
                  child: Text(
                    '설정',
                    style: TextStyle(
                        fontSize: _src.setSp(16),
                        fontWeight: FontWeight.bold,
                        color: _reclinerColor.dark1),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: _src.setHeight(16),
          ),
          Container(
            height: _src.setHeight(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: _src.setWidth(18),
                ),
                Container(
                  width: _src.setWidth(240),
                  child: Text(
                    '데일리케어',
                    style: TextStyle(
                        fontSize: _src.setSp(14),
                        color: _reclinerColor.dark1),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: _src.setHeight(16),
          ),
          Container(
            height: _src.setHeight(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: _src.setWidth(18),
                ),
                Container(
                  width: _src.setWidth(240),
                  child: Text('리클라이너 관리',
                      style: TextStyle(
                          fontSize: _src.setSp(14),
                          color: _reclinerColor.dark1)),
                )
              ],
            ),
          ),
          Container(
            height: _src.setHeight(16),
          ),
          Container(
            height: _src.setHeight(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: _src.setWidth(18),
                ),
                Container(
                  width: _src.setWidth(240),
                  child: Text('프로필 관리',
                      style: TextStyle(
                          fontSize: _src.setSp(14),
                          color: _reclinerColor.dark1)),
                )
              ],
            ),
          ),
          Container(
            height: _src.setHeight(16),
          ),
          Container(
            height: _src.setHeight(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: _src.setWidth(18),
                ),
                Container(
                  width: _src.setWidth(240),
                  child: Text('자주 묻는 질문',
                      style: TextStyle(
                          fontSize: _src.setSp(14),
                          color: _reclinerColor.dark1)),
                )
              ],
            ),
          ),
          Container(
            height: _src.setHeight(110),
          ),
          Container(
            width: _src.setWidth(234),
            height: _src.setHeight(50),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _reclinerColor.modeSideColor),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 0.01,
                      blurRadius: 3,
                      offset: Offset(-1.5, 2.0))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '로그아웃',
                      style: TextStyle(
                          fontSize: _src.setSp(14),
                          color: _reclinerColor.dark1),
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
}
