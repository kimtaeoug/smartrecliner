import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/Control/ShakeProvider.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';


class ShakeMutliSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _ShakeMutliSwitch();
}

class _ShakeMutliSwitch extends State<ShakeMutliSwitch> {
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  int _itemIndex = 1;

  //방향
  double direction = 0;

  late ShakeProvider _shakeProvider;
  bool _checked = false;

  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _shakeProvider = Provider.of<ShakeProvider>(context);
    _checked = _shakeProvider.getShakeCheck();
    return Container(
      width: _src.setWidth(270),
      height: _src.setHeight(120),
      child: _checked? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$_itemIndex단계',style: TextStyle(color: _reclinerColor.primary2,fontSize: _src.setSp(24),fontWeight: FontWeight.bold ),),
          Container(
            height: _src.setHeight(14),
          ),
          Stack(
            children: [
              Container(
                width: _src.setWidth(270),
                height: _src.setHeight(60),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: _reclinerColor.turquoise.withOpacity(0.1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          _itemIndex = 1;
                          _shakeProvider.setItemIndex(_itemIndex);
                        });
                      },
                      child: Text('1',style: TextStyle(color: _reclinerColor.dark2,fontSize: _src.setSp(20) ),),
                    ),
                    Container(
                      width: _src.setWidth(75),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          _itemIndex = 2;
                          _shakeProvider.setItemIndex(_itemIndex);
                        });
                      },
                      child: Text('2',style: TextStyle(color: _reclinerColor.dark2,fontSize: _src.setSp(20) ),),
                    ),
                    Container(
                      width: _src.setWidth(75),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          _itemIndex = 3;
                          _shakeProvider.setItemIndex(_itemIndex);
                        });
                      },
                      child: Text('3',style: TextStyle(color: _reclinerColor.dark2,fontSize: _src.setSp(20) ),),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    switch(_itemIndex){
                      case 1:
                        _itemIndex = 2;
                        _shakeProvider.setItemIndex(_itemIndex);
                        break;
                      case 3:
                        _itemIndex = 2;
                        _shakeProvider.setItemIndex(_itemIndex);
                        break;
                    }
                  });
                },
                onHorizontalDragUpdate: (DragUpdateDetails details){
                  setState(() {
                    direction = details.delta.dx;
                    switch(_itemIndex){
                      case 2:
                        if(direction > 0){
                          _itemIndex = 3;
                          _shakeProvider.setItemIndex(_itemIndex);
                        }else{
                          _itemIndex =1;
                          _shakeProvider.setItemIndex(_itemIndex);
                        }
                        break;
                    }

                  });
                },
                child: Container(
                  width: _src.setWidth(270),
                  height: _src.setHeight(60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: _src.setWidth(4),
                      ),
                      Container(
                        width: _src.setWidth(262),
                        child: AnimatedAlign(
                          alignment:itemAlign()!,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                          child: switchItem(_itemIndex),
                        ),
                      ),
                      Container(
                        width: _src.setWidth(4),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ):Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('1단계',style: TextStyle(color: _reclinerColor.grey.withOpacity(0.3),fontSize: _src.setSp(24),fontWeight: FontWeight.bold ),),
          Container(
            height: _src.setHeight(14),
          ),
          Stack(
            children: [
              Container(
                width: _src.setWidth(270),
                height: _src.setHeight(60),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: _reclinerColor.grey4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('1',style: TextStyle(color: _reclinerColor.grey3,fontSize: _src.setSp(20) ),),
                    Container(
                      width: _src.setWidth(75),
                    ),
                    Text('2',style: TextStyle(color: _reclinerColor.grey3,fontSize: _src.setSp(20) ),),
                    Container(
                      width: _src.setWidth(75),
                    ),
                    Text('3',style: TextStyle(color: _reclinerColor.grey3,fontSize: _src.setSp(20) ),)
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  width: _src.setWidth(270),
                  height: _src.setHeight(60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: _src.setWidth(4),
                      ),
                      Container(
                        width: _src.setWidth(262),
                        child: AnimatedAlign(
                          alignment: Alignment(-1.0, 0.0),
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                          child: switchItem(1),
                        ),
                      ),
                      Container(
                        width: _src.setWidth(4),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  AlignmentGeometry? itemAlign() {
    switch (_itemIndex) {
      case 1:
        return Alignment(-1.0, 0.0);
      case 2:
        return Alignment.center;
      case 3:
        return Alignment(1.0, 0.0);
    }
    return null;
  }

  Widget switchItem(int itemIndex) {
    if(_checked){
      return Container(
        width: _src.setWidth(85),
        height: _src.setHeight(50),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: _reclinerColor.turquoise),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$itemIndex',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: _src.setSp(20)),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      );
    }else{
      return Container(
        width: _src.setWidth(85),
        height: _src.setHeight(50),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: _reclinerColor.grey3),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$itemIndex',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: _src.setSp(20)),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      );
    }
  }
}
