import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/Control/HeatProvider.dart';
import 'package:smartrecliner_flutter/Control/RemoteContolProvider.dart';
import 'package:smartrecliner_flutter/History/HistoryProvider2.dart';
import 'package:smartrecliner_flutter/History/NewHistoryProvider.dart';
import 'package:smartrecliner_flutter/Measure/MeasureHistory.dart';
import 'package:smartrecliner_flutter/Measure/MeasureResult.dart';
import 'package:smartrecliner_flutter/Measure/Measuring.dart';

import 'BleProvider.dart';
import 'BleScan/BLEScanBlue.dart';
import 'Control/ShakeProvider.dart';
import 'History/History.dart';
import 'MainPage.dart';
import 'Measure/HistoryProvider.dart';
import 'Measure/Measure.dart';
import 'MemberShip/MemberShipStart.dart';
import 'MemberShip/PatternAuth.dart';
import 'SplashPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //세로 고정
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BleProvider>(
          create: (context) => BleProvider(null),
        ),
        ChangeNotifierProvider<RemoteContolProvider>(
          create: (context) => RemoteContolProvider(false),
        ),
        ChangeNotifierProvider<HeatProvider>(
          create: (context) => HeatProvider(false, false, DateTime(1996), null),
        ),
        ChangeNotifierProvider<ShakeProvider>(
          create: (context) => ShakeProvider(false, false, DateTime(1996), null),
        ),
        ChangeNotifierProvider<HistoryProvider>(
          create: (context) => HistoryProvider([], '일', 'list', [], [], []),
        ),
        ChangeNotifierProvider<HistoryProvider2>(
          create: (context) => HistoryProvider2([], [], [], '일', 'list', false),
        ),
        // ChangeNotifierProvider<NewHistoryProvider>(
        //   create: (context) => NewHistoryProvider(null, [], [], [], '일', 'list', false),
        // )
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/MainPage': (context) => MainPage(),
          '/BLEScanBlue' : (context) => BLEScanBlue(),
          '/Measure': (context) => Measure(),
          '/Measuring' : (context) => Measuring(),
          '/MeasureResult' : (context) => MeasureResult(),
          // '/MeasureHistory' : (context) => MeasureHistory(),
          '/MemberShipStart' : (context) => MemberShipStart(),
          '/PatternAuth':(context) => PatternAuth(),
          '/History' : (context) => History()
        },
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SplashPage(),
      ),
    );
  }
}
