import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:smartrecliner_flutter/BleProvider.dart';

class BLEScanBlue extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BLEScanBlueUI();
}

class BLEScanBlueUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BLEScanBlueUI();
}

class _BLEScanBlueUI extends State<BLEScanBlueUI> {
  final String tag = 'BLEScanBlue';
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> foundDevice = [];
  late BleProvider _bleProvider;

  @override
  void initState() {
    super.initState();
    checkPermission();
    scanBleDevice();
  }

  @override
  Widget build(BuildContext context) {
    _bleProvider = Provider.of<BleProvider>(context);
    return SafeArea(
        child: WillPopScope(
      child: Scaffold(
        body: Stack(
          children: [
            ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          flutterBlue.stopScan();
                          _bleProvider
                              .setSelectDevice(foundDevice[index].device);
                          _bleProvider.initConnect().then((_){
                            Navigator.pushNamed(context, '/MainPage');
                            // Navigator.pushNamed(context, '/MemberShipStart');
                          });
                        });
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(foundDevice[index].device.name),
                            Text(foundDevice[index].rssi.toString())
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: foundDevice.length),
          ],
        ),
      ),
      onWillPop: () {
        return Future(()=>false);
      },
    ));
  }

  //권한 확인
  Future<void> checkPermission() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.location, Permission.bluetooth].request();
    for (PermissionStatus status in statuses.values) {
      if (status.isDenied) {}
    }
  }

  Future<void> scanBleDevice() async {
    try {
      foundDevice.clear();
      // Start scanning
      flutterBlue.startScan(timeout: Duration(seconds: 10));
      flutterBlue.scanResults.listen((results) {
        for (ScanResult r in results) {
          print(r.device.name);
          if (r.device.name != '' && r.device.name != ' ') {
            if (!foundDevice.contains(r)) {
              setState(() {
                foundDevice.add(r);
              });
            }
          }
        }
      });
    } catch (e) {
      // log('$e in scanBleDevice', name: tag);
    }
  }
}
