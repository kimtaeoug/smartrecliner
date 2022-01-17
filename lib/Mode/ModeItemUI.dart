import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/Mode/ModeDto.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/Control/HeatProvider.dart';
import 'package:smartrecliner_flutter/Control/ShakeProvider.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
class ModeItemUI extends StatefulWidget {
  final ModeDto data;
  ModeItemUI({required Key? key, required this.data})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _ModeItemUI(data);
}

class _ModeItemUI extends State<ModeItemUI>
    with SingleTickerProviderStateMixin {
  //rotate animation
  late AnimationController _controller;

  late ModeDto data;


  _ModeItemUI(this.data);

  @override
  void initState() {
    super.initState();
    //init animation
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
  }

  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  List<String?> getModeDetailContext(ModeDto data) {
    List<String?> dummy = [];
    if (data.modeTime != null) {
      dummy.add(data.modeTime);
    }
    if (data.modeShake != null) {
      dummy.add(data.modeShake);
    }
    if (data.modeWarmth != null) {
      dummy.add(data.modeWarmth);
    }
    return dummy;
  }

  bool clicked = false;

  late HeatProvider _heatProvider;
  late ShakeProvider _shakeProvider;

  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src = _screenUtilAPI.getScreenUtil();
  @override
  Widget build(BuildContext context) {
    _src = _screenUtilAPI.getScreenUtil();
    _heatProvider = Provider.of<HeatProvider>(context);
    _shakeProvider = Provider.of<ShakeProvider>(context);
    List<String?> detailModeContext = getModeDetailContext(data);
    return InkWell(
      onTap: () {
        activateMode();
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: setBorderColor(),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      //background color of box
                      color: Colors.grey.withOpacity(0.4),
                      //extend the shadow
                      spreadRadius: 0.01,
                      //soften the shadow
                      blurRadius: 2,
                      offset: Offset(
                          //Move to right 10 horizontally
                          -0.5,
                          //Move to bottom 10 vertically
                          1.0))
                ]),
            width: _src.setWidth(115),
            height: _src.setHeight(131),
            child: SizedBox(
              width: _src.setWidth(86),
              height: _src.setHeight(130),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: _src.setHeight(45),
                  ),
                  Container(
                    width: _src.setWidth(86),
                    child: Text(
                      data.modeName,
                      style: TextStyle(
                          fontSize: _src.setSp(10)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    height: _src.setHeight(4),
                  ),
                  Container(
                    width: _src.setWidth(86),
                    child: Text(
                      data.modeContext!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _src.setSp(12),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    height: _src.setHeight(4),
                  ),
                  Container(
                    width: _src.setWidth(86),
                    height: _src.setHeight(15),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: detailModeContext.length,
                      itemBuilder: (context, index) {
                        return Text(
                          detailModeContext[index]!,
                          style: TextStyle(
                              color: _reclinerColor.modeDetailTextColor,
                              fontSize: _src.setSp(9),
                              fontWeight: FontWeight.bold),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          width:
                              _src.setWidth(4),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: _src.setWidth(115),
            height: _src.setHeight(131),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: _src.setHeight(12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    showActivatingUI(),
                    Container(
                      width: _src.setWidth(12),
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

  Border setBorderColor() {
    if (clicked) {
      return Border.all(color: _reclinerColor.turquoise);
    } else {
      return Border.all(color: _reclinerColor.modeSideColor);
    }
  }

  Widget showActivatingUI() {
    if (clicked) {
      return Container(
        width: _src.setWidth(24),
        height: _src.setHeight(24),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Transform.rotate(
                angle: _controller.value * 10, child: child);
          },
          child: Image.asset(
            'images/playing_img.png',
            width: _src.setWidth(24),
            height: _src.setHeight(24),
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      return Container(
        width: _src.setWidth(24),
        height: _src.setHeight(24),
      );
    }
  }

  void activateMode() {
    setState(() {
      if (clicked) {
        clicked = false;
        checkOutHeatShake(clicked);
      } else {
        clicked = true;
        checkOutHeatShake(clicked);
      }
    });
  }

  void checkOutHeatShake(bool clicked) {
    // _chsProvider
    if (clicked) {
      if (data.modeShake != null) {
        _shakeProvider.setShakeOn(true);
      }
      if (data.modeWarmth != null) {
        _heatProvider.setHeatOn(true);
      }
    } else {
      _shakeProvider.setShakeOn(false);
        _heatProvider.setHeatOn(false);
    }
  }
}
