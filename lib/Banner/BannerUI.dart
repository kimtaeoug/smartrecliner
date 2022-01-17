import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';

class BannerUI extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _BannerUI();
}

class _BannerUI extends State<BannerUI> {

  //색상
  ReclinerColor _reclinerColor = ReclinerColor();


  List<String> bannersList = [
    'images/banner1_img.png',
    'images/banner2_img.png',
    'images/banner1_img.png',
    'images/banner1_img.png',
    'images/banner1_img.png'
  ];
  final PageController _controller = PageController(initialPage: 0);

  int _itemIndex = 1;
  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    return SizedBox(
      width: _src.setWidth(324),
      height: _src.setHeight(104),
      child: Stack(
        children: [
          PageView(
            onPageChanged: (index){
              setState(() {
                _itemIndex = index + 1;
              });
            },
            controller: _controller,
            children: [
              Container(
                width: _src.setWidth(324),
                height: _src.setHeight(104),
                child: Image.asset(
                  bannersList[0],
                  width: _src.setWidth(324),
                  height: _src.setHeight(104),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: _src.setWidth(324),
                height: _src.setHeight(104),
                child: Image.asset(
                  bannersList[1],
                  width: _src.setWidth(324),
                  height: _src.setHeight(104),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: _src.setWidth(324),
                height: _src.setHeight(104),
                child: Image.asset(
                  bannersList[2],
                  width: _src.setWidth(324),
                  height: _src.setHeight(104),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: _src.setWidth(324),
                height: _src.setHeight(104),
                child: Image.asset(
                  bannersList[3],
                  width: _src.setWidth(324),
                  height: _src.setHeight(104),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: _src.setWidth(324),
                height: _src.setHeight(104),
                child: Image.asset(
                  bannersList[4],
                  width: _src.setWidth(324),
                  height: _src.setHeight(104),
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: _src.setWidth(32),
                      height: _src.setHeight(16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '$_itemIndex / 5',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _reclinerColor.white1,
                              fontSize:
                              _src.setSp(10)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: _src.setWidth(12),
                  )
                ],
              ),
              Container(
                height: _src.setHeight(12),
              )
            ],
          )
        ],
      ),
    );
  }

}
