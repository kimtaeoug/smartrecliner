import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartrecliner_flutter/BottomUI.dart';
import 'package:smartrecliner_flutter/Control/ControlUI.dart';
import 'package:smartrecliner_flutter/Drawer/DrawerUI.dart';
import 'package:smartrecliner_flutter/UISupport/ScreenUtilAPI.dart';
import 'Banner/BannerUI.dart';
import 'ContextMenu/ContextMenu.dart';
import 'Control/RemoteContolProvider.dart';
import 'Health/HealthItemUI.dart';
import 'Mode/ModeItemUI.dart';
import 'package:smartrecliner_flutter/Mode/ModeDto.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';
import 'package:smartrecliner_flutter/BleProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainPageUI();
  }
}

class MainPageUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageUI();
}

class _MainPageUI extends State<MainPageUI> {
  String tag = 'MainPage';
  late BleProvider _bleProvider;
  late Stream _deviceState;
  late BluetoothDevice _device;
  //색상
  ReclinerColor _reclinerColor = ReclinerColor();

  //Responsive UI

  List<ModeDto> modeList = [
    ModeDto('낮잠모드', '오후에는\n잠이 쏟아져', '', '흔들 2', '', false),
    ModeDto('휴식모드', '아늑하고\n편하게', '60분', '흔들1', '온열1', false),
    ModeDto('사용자 추가 모드', '누워서\n핸드폰 볼 때', '60분', '흔들1', '온열1', false)
  ];

  //Remote Control
  late RemoteContolProvider _remoteContolProvider;

  @override
  void initState() {
    super.initState();
  }


  ScreenUtilAPI _screenUtilAPI = ScreenUtilAPI();
  late ScreenUtil _src;
  //360px, 740px
  @override
  Widget build(BuildContext context) {
    //BLE Provider
    _bleProvider = Provider.of<BleProvider>(context);
    _device = _bleProvider.getSelectDevice();
    _bleProvider.measureStop();
    _deviceState = _device.state;
    _src = _screenUtilAPI.getScreenUtil();
    //RemoteControl Provider
    _remoteContolProvider = Provider.of<RemoteContolProvider>(context);
    return SafeArea(
        child: WillPopScope(
      child: Scaffold(
        endDrawer: DrawerUI(),
        body: Builder(
          builder: (context) => Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ContextMenuUI(),
                      Container(
                        width: _src.setWidth(8),
                      )
                    ],
                  ),
                  profile(context),
                  Container(
                    height: _src.setHeight(4),
                  ),
                  lastCheckAlarm(),
                  Container(
                    height: _src.setHeight(9),
                  ),
                  BannerUI(),
                  Container(
                    height:
                        _src.setHeight(18),
                  ),
                  favoriteAndPlusMode(),
                  Container(
                    height:
                        _src.setHeight(12),
                  ),
                  modes(),
                  Container(
                    height:
                        _src.setHeight(18),
                  ),
                  health(),
                  Container(
                    height:
                        _src.setHeight(12),
                  ),
                  Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HealthItemUI(),
                          // blankHealthData(),
                          Container(
                          ),
                          Container(
                            height: _src.setHeight(
                                11),
                          ),
                          BottomUI()
                        ],
                      ),
                      SizedBox(
                        height: _src.setHeight(
                            228),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                remoteController(),
                                Container(
                                  height: _src.setHeight(
                                      15),
                                )
                              ],
                            ),
                            Container(
                              width: _src.setWidth(
                                  26),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              _remoteContolProvider.getOpenControl()?ControlUI():Container()
            ],
          ),
        ),
      ),
      onWillPop: () {
        return Future(()=>false);
      },
    ));
  }

  Widget profile(BuildContext context) {
    return SizedBox(
      width: _src.setWidth(324),
      height: _src.setHeight(46),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //profileimg
          SizedBox(
            width: _src.setWidth(36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/dummy_profile.png',
                  width: _src.setWidth(36),
                  fit: BoxFit.fill,
                )
              ],
            ),
          ),
          Container(
            width: _src.setWidth(13),
          ),
          //text
          Container(
            width: _src.setWidth(221),
            height: _src.setHeight(46),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '김수지님',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    Text(
                      '오늘도 자콤!',
                    )
                  ],
                ),
                Container(
                  height: _src.setHeight(4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: _src.setWidth(4),
                    ),
                    SizedBox(
                      width: _src.setWidth(4),
                      height:
                          _src.setHeight(4),
                      child: Image.asset(
                        'images/point_img.png',
                        width:
                            _src.setWidth(4),
                        height:
                            _src.setHeight(4),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: _src.setWidth(4),
                    ),
                    StreamBuilder(
                        stream: _deviceState,
                        builder: (context, snapshot) {
                          String _nowState = '연결 안됨';
                          switch (snapshot.data) {
                            case BluetoothDeviceState.connected:
                              _nowState = '연결됨';
                              break;
                            case BluetoothDeviceState.disconnecting:
                              _nowState = '연결 종료중';
                              break;
                            case BluetoothDeviceState.disconnected:
                              _nowState = '연결 끊김';
                              break;
                            case BluetoothDeviceState.connecting:
                              _nowState = '연결됨';
                              break;
                            default:
                              _nowState = '알 수 없음';
                              break;
                          }
                          return Text(
                            _nowState,
                            style: TextStyle(color: _reclinerColor.turquoise, fontSize: _src.setSp(10)),
                          );
                        }),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: _src.setWidth(22),
          ),
          //menu
          SizedBox(
            width: _src.setWidth(32),
            height: _src.setHeight(32),
            child: InkWell(
              child: Image.asset('images/menu_img.png',fit: BoxFit.fill,),
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          )
        ],
      ),
    );
  }

  //opacity - 투명도 위젯
  Widget lastCheckAlarm() {
    return SizedBox(
      width: _src.setWidth(324),
      height: _src.setHeight(36),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Opacity(
              opacity: 0.3,
              child: Container(
                width: _src.setWidth(324),
                height: _src.setHeight(36),
                color: _reclinerColor.grey,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: _src.setWidth(15),
                  ),
                  SizedBox(
                    width: _src.setWidth(20),
                    height:
                        _src.setHeight(20),
                    child: Image.asset(
                      'images/heart_img.png',
                      width: _src.setWidth(20),
                      height:
                          _src.setHeight(20),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: _src.setWidth(6),
                  ),
                  Text('마지막 검사 이후 14일이 경과했습니다')
                ],
              )
            ],
          ),
        ],
      ),
    );
  }


  Widget favoriteAndPlusMode() {
    return SizedBox(
      width: _src.setWidth(324),
      height: _src.setHeight(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _src.setWidth(50),
                height: _src.setHeight(20),
                child: Text(
                  '즐겨찾기',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Container(
            width: _src.setWidth(185),
          ),
          SizedBox(
            width: _src.setWidth(79),
            height: _src.setHeight(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _src.setWidth(24),
                  height: _src.setHeight(24),
                  child: Image.asset(
                    'images/plus_img.png',
                    width: _src.setWidth(24),
                    height:
                        _src.setHeight(24),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: _src.setWidth(55),
                  height: _src.setHeight(24),
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      '모드 추가',
                      style: TextStyle(color: _reclinerColor.turquoise),
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

  //모드
  Widget modes() {
    return Container(
      width: _src.setWidth(324),
      height: _src.setHeight(138),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: modeList.length,
        itemBuilder: (context, index) {
          return ModeItemUI(
              data: modeList[index], key: null,);
        },
        separatorBuilder: (context, index) {
          return Container(
            width: _src.setWidth(12),
          );
        },
      ),
    );
  }

  Widget health() {
    return SizedBox(
      width: _src.setWidth(324),
      height: _src.setHeight(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: _src.setWidth(56),
            child: Text(
              '나의 건강',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: _src.setWidth(182),
          ),
          SizedBox(
            width: _src.setWidth(24),
            height: _src.setHeight(24),
            child: Image.asset(
              'images/plus_img.png',
              width: _src.setWidth(24),
              height: _src.setHeight(24),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: _src.setWidth(56),
            height: _src.setHeight(24),
            child: InkWell(
              child: Text(
                '건강 측정',
                style: TextStyle(
                    color: _reclinerColor.turquoise,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/Measure');
              },
            ),
          )
        ],
      ),
    );
  }

  Widget remoteController() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0.01,
                  blurRadius: 1,
                  offset: Offset(-1.5, 3.0))
            ],
            shape: BoxShape.circle,
            color: _reclinerColor.turquoise,
          ),
          width: _src.setWidth(57),
          height: _src.setHeight(57),
        ),
        Container(
          width: _src.setWidth(57),
          height: _src.setHeight(57),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Image.asset(
                      'images/remoter_img.png',
                      width: _src.setWidth(17),
                      height:
                          _src.setHeight(36),
                      fit: BoxFit.fill,
                    ),
                    onTap: (){
                      _remoteContolProvider.setOpenControl(true);
                    },
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
