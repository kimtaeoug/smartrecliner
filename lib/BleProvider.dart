import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:smartrecliner_flutter/Api/ApiClient.dart';
import 'package:smartrecliner_flutter/Api/ApiRawDto.dart';
import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';
import 'package:smartrecliner_flutter/Protocol/BleProtocol.dart';

//flutter_blue에서 받은 방법 - > readCharacteristic에서 setNotifyValue하고 writeCharacteristic으로 보냄.

class BleProvider with ChangeNotifier {
  final String tag = 'BLE';
  final double lPFCOEFFECG = 0.100;
  final double lPFCOEFFPPG = 0.300;
  BluetoothDevice? _selectDevice;

  BleProvider(this._selectDevice);

  getSelectDevice() => _selectDevice;

  setSelectDevice(BluetoothDevice device) => _selectDevice = device;

  bool _alreadyConnected = false;

  HistoryApiResponse apiResult = HistoryApiResponse(
      recordedTime: 0,
      uniqueID: 0,
      stress: 0,
      heartRate: 0,
      systolic: 0,
      diastolic: 0,
      weight: 0);


  //Protocol
  BleProtocol _bleProtocol = BleProtocol();
  late BluetoothCharacteristic readCharacteristic;
  late BluetoothCharacteristic writeCharacteristic;

  //Disconnect to ble device
  Future<void> disconnectBleDevice() async {
    await _selectDevice!.disconnect();
    _alreadyConnected = false;
  }

  //Connect to ble device
  Future<void> initConnect() async {
    if (_selectDevice != null) {
      try {
        if (_alreadyConnected) {
          await disconnectBleDevice();
        } else {
          await _selectDevice!.connect().then(
                  (_) =>
              {
                matchServiceCharactertistic(),
                _alreadyConnected = true
              });
        }
      } catch (e) {
        log('$e in initConnect', name: tag);
      }
    } else {
      log('Device is null(in initConnect)', name: tag);
    }
  }

  //Find matching service, charactertistic with own service uuid and charactertistic uuid
  Future<void> matchServiceCharactertistic() async {
    try {
      List<BluetoothService> services = await _selectDevice!.discoverServices();
      services.forEach((service) {
        if (service.uuid.toString() == _bleProtocol.serviceUUID) {
          service.characteristics.forEach((characteristic) async {
            if (characteristic.uuid.toString() ==
                _bleProtocol.writeCharacteristicUUID) {
              writeCharacteristic = characteristic;
            } else if (characteristic.uuid.toString() ==
                _bleProtocol.readCharacteristicUUID) {
              readCharacteristic = characteristic;
              await setNotification(readCharacteristic);
              // readCharacteristic.value.listen((event) {
              //   print('data : $event');
              // });
            }
          });
        }
      });
    } catch (e) {
      log('$e in matchServiceCharactertistic', name: tag);
    }
  }

  //Read data from ble device
  Future<void> setNotification(
      BluetoothCharacteristic _readCharactertistic) async {
    try {
      await _readCharactertistic
          .setNotifyValue(!_readCharactertistic.isNotifying);
      await _readCharactertistic.read();
    } catch (e) {
      log('$e in setNotification', name: tag);
    }
  }

  //Communicate with ble device
  // Future<void> writeDescriptorOnDevice() async {
  //   try {
  //     writeCharacteristic
  //         .write(_bleProtocol.temperature, withoutResponse: true)
  //         .then((value) {
  //       readCharacteristic.value.listen((event) {
  //         print('data : $event');
  //       });
  //     });
  //   } catch (e) {
  //     log('$e in writeDescriptorOnDevice', name: tag);
  //   }
  // }

  Future<void> sendToData(List<int>? data) async {
    try {
      writeCharacteristic.write(data!, withoutResponse: true);
      // writeCharacteristic.write(data!, withoutResponse: true).then((value) {
      //   readCharacteristic.value.listen((event) {
      //     print('data  : $event');
      //   });
      // });
      // writeCharacteristic.write(data!, withoutResponse: true);
    } catch (e) {
      log('$e in writeCharacteristic', name: tag);
    }
  }

  Future<void> measureStart() async {
    try {
      StringBuffer totalData = StringBuffer();
      double evenData = 0.0;
      double oddData = 0.0;
      int idx = 0;
      final client = ApiClient(Dio(BaseOptions(
          contentType: "application/json",
          connectTimeout: 100 * 1000,
          receiveTimeout: 100 * 1000)));
      //I/flutter (17617): oddData : 96.3603908982727
      // I/flutter (17617): evenData : 88.41154049205753
      // I/flutter (17617): oddData : 94.45227362879089
      // I/flutter (17617): evenData : 79.67038644285178
      // I/flutter (17617): oddData : 67.91659154015363
      await writeCharacteristic
          .write(_bleProtocol.measureStart, withoutResponse: true).then((_){
        //16719
        readCharacteristic.value.listen((event) async{
          if(event is double){
            if(idx <30000){
              if(event is! List){
                for (int data in event) {
                  //짝수
                  if (idx % 2 == 0) {
                    evenData = evenData - (lPFCOEFFECG * (evenData - data));
                    totalData.write("$evenData ;");
                  }
                  //홀수
                  else {
                    oddData = oddData - (lPFCOEFFPPG * (oddData - data));
                    totalData.write("$oddData; 157 \n");
                  }
                  idx += 1;
                }
              }
            }else{
              measureStop();
            }
          }
        });
      });

      Timer.periodic(Duration(seconds: 70), (timer) async {
        try {
          client
              .getResultAPI(ApiRawDto(80.0, totalData.toString()))
              .then((value) {
            print('length : ${totalData.length}');
            apiResult = value;
            totalData.clear();
            timer.cancel();
            print('apiResult : ${apiResult.toJson()}');
          });
        } catch (e) {
          print('$e in measuring');
          measureStop();
        }
      });
    } catch (e) {
      log('$e in measureStart()', name: tag);
      measureStop();
    }
  }
  

  Future<void> measureEnd() async {
    try {
      print('measureEnd');
      await writeCharacteristic
          .write(_bleProtocol.measureEnd, withoutResponse: true);
    } catch (e) {
      log('$e in measureEnd()', name: tag);
    }
  }

  Future<void> measureStop() async {
    try {
      await writeCharacteristic.write(_bleProtocol.measureEnd,
          withoutResponse: true);
    } catch (e) {
      log('$e in measureStop()', name: tag);
    }
  }
//704594
//no timer
// Future<void> measure() async{
//   try {
//     Isolate.
//     StringBuffer totalData = StringBuffer();
//     double evenData = 0.0;
//     double oddData = 0.0;
//     int idx = 0;
//     final client = ApiClient(Dio(BaseOptions(
//         contentType: "application/json",
//         connectTimeout: 100 * 1000,
//         receiveTimeout: 100 * 1000)));
//     await writeCharacteristic
//         .write(_bleProtocol.measureStart, withoutResponse: true)
//         .then((value) async{
//           if(totalData.length < 704594){
//             readCharacteristic.value.listen((event){
//               for (int data in event) {
//                 //짝수
//                 if (idx % 2 == 0) {
//                   evenData = evenData - (lPFCOEFFECG * (evenData - data));
//                   totalData.write("$evenData ;");
//                 }
//                 //홀수
//                 else {
//                   oddData = oddData - (lPFCOEFFPPG * (oddData - data));
//                   totalData.write("$oddData; 157 \n");
//                 }
//                 idx += 1;
//               }
//             });
//           }else{
//             await measureStop();
//             client.getResultAPI(ApiRawDto(80.0, totalData.toString())).then((value){
//               print('result : $value');
//               totalData.clear();
//             });
//           }
//     });
//   } catch (e) {
//     log('$e in measureStart()', name: tag);
//     measureStop();
//   }
// }


// Future<void> measure() async{
//   ReceivePort _receivePort = ReceivePort();
//   await Isolate.spawn(processMeasure, _receivePort.sendPort);
//   // await compute(_measure, client).then((value){
//   //   print('result : $value');
//   // });
// }
// static Future<void> processMeasure(SendPort sendPort) async{
//   ApiClient client = ApiClient(Dio(BaseOptions(contentType: "application/json", connectTimeout: 100*1000, receiveTimeout: 100*1000)));
//   BleProtocol _bleProtocol = BleProtocol();
//   try{
//     StringBuffer totalData = StringBuffer();
//     double evenData = 0.0;
//     double oddData = 0.0;
//     int idx = 0;
//     //LateInitialzationError - BleProvider에서 static인데 late으로 선언해놨으니 문제.
//     //해당 함수에서는 BleProvider에 선언된 인스턴스가 접근 불가능
//     //writeCharacteristic이랑 readCharacteristic을 어떻게 해야할지...
//
//     //write, read는 지정된 uuid랑 같은 거로 뽑고, notification 설정인데.
//     //여기서 선언하는 것도 불가 -> device가 인스턴스임(static 박으면 에러- 생성자로 만들기가 불가능)
//
//     //-> 결론적으로 characteristic을 끌고 와서 사용하는 게 불가능.
//     writeCharacteristic.write(_bleProtocol.measureStart, withoutResponse: true).then((value){
//       readCharacteristic.value.listen((event) {
//         for(int data in event){
//           if(idx % 2 == 0){
//             evenData = evenData - (0.100 * (evenData - data));
//             totalData.write("$evenData ;");
//           }else{
//             oddData = oddData - (0.300 * (oddData - data));
//             totalData.write("$oddData; 157 \n");
//           }
//           idx += 1;
//         }
//       });
//     });
//     Timer.periodic(Duration(seconds: 70), (timer) {
//       writeCharacteristic.write(_bleProtocol.measureEnd, withoutResponse: true);
//       client.getResultAPI(ApiRawDto(80.0, totalData.toString())).then((value){
//         print('length : ${totalData.length}');
//         print('result : $value');
//         totalData.clear();
//         timer.cancel();
//       });
//     });
//   }catch(e){
//     print('$e in processMeasure()');
//   }
// }

}

//import 'dart:async';
// import 'dart:developer';
// import 'dart:isolate';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:smartrecliner_flutter/Api/ApiClient.dart';
// import 'package:smartrecliner_flutter/Api/ApiRawDto.dart';
// import 'package:smartrecliner_flutter/Api/HistoryApiResponse.dart';
// import 'package:smartrecliner_flutter/Protocol/BleProtocol.dart';
//
// //flutter_blue에서 받은 방법 - > readCharacteristic에서 setNotifyValue하고 writeCharacteristic으로 보냄.
//
// class BleProvider with ChangeNotifier {
//   final String tag = 'BLE';
//   final double lPFCOEFFECG = 0.100;
//   final double lPFCOEFFPPG = 0.300;
//   BluetoothDevice? _selectDevice;
//
//   BleProvider(this._selectDevice);
//
//   getSelectDevice() => _selectDevice;
//
//   setSelectDevice(BluetoothDevice device) => _selectDevice = device;
//
//   bool _alreadyConnected = false;
//
//   HistoryApiResponse apiResult = HistoryApiResponse(
//       recordedTime: 0,
//       uniqueID: 0,
//       stress: 0,
//       heartRate: 0,
//       systolic: 0,
//       diastolic: 0,
//       weight: 0);
//
//   late BluetoothCharacteristic readCharacteristic;
//   late BluetoothCharacteristic writeCharacteristic;
//
//   //Protocol
//   BleProtocol _bleProtocol = BleProtocol();
//
//   //Disconnect to ble device
//   Future<void> disconnectBleDevice() async {
//     await _selectDevice!.disconnect();
//     _alreadyConnected = false;
//   }
//
//   //Connect to ble device
//   Future<void> initConnect() async {
//     if (_selectDevice != null) {
//       try {
//         if (_alreadyConnected) {
//           await disconnectBleDevice();
//         } else {
//           await _selectDevice!.connect().then(
//               (_) => {matchServiceCharactertistic(), _alreadyConnected = true});
//         }
//       } catch (e) {
//         log('$e in initConnect', name: tag);
//       }
//     } else {
//       log('Device is null(in initConnect)', name: tag);
//     }
//   }
//
//   //Find matching service, charactertistic with own service uuid and charactertistic uuid
//   Future<void> matchServiceCharactertistic() async {
//     try {
//       List<BluetoothService> services = await _selectDevice!.discoverServices();
//       services.forEach((service) {
//         if (service.uuid.toString() == _bleProtocol.serviceUUID) {
//           service.characteristics.forEach((characteristic) async {
//             if (characteristic.uuid.toString() ==
//                 _bleProtocol.writeCharacteristicUUID) {
//               writeCharacteristic = characteristic;
//             } else if (characteristic.uuid.toString() ==
//                 _bleProtocol.readCharacteristicUUID) {
//               readCharacteristic = characteristic;
//               await setNotification(readCharacteristic);
//             }
//           });
//         }
//       });
//     } catch (e) {
//       log('$e in matchServiceCharactertistic', name: tag);
//     }
//   }
//
//   //Read data from ble device
//   Future<void> setNotification(
//       BluetoothCharacteristic _readCharactertistic) async {
//     try {
//       await _readCharactertistic
//           .setNotifyValue(!_readCharactertistic.isNotifying);
//       await _readCharactertistic.read();
//     } catch (e) {
//       log('$e in setNotification', name: tag);
//     }
//   }
//
//   //Communicate with ble device
//   Future<void> writeDescriptorOnDevice() async {
//     try {
//       writeCharacteristic
//           .write(_bleProtocol.temperature, withoutResponse: true)
//           .then((value) {
//         readCharacteristic.value.listen((event) {
//           print('data : $event');
//         });
//       });
//     } catch (e) {
//       log('$e in writeDescriptorOnDevice', name: tag);
//     }
//   }
//
//   Future<void> sendToData(List<int>? data) async {
//     try {
//       writeCharacteristic.write(data!, withoutResponse: true).then((value) {
//         readCharacteristic.value.listen((event) {
//           print('data  : $event');
//         });
//       });
//     } catch (e) {
//       log('$e in writeCharacteristic', name: tag);
//     }
//   }
//
//   Future<void> measureStart() async {
//     try {
//       StringBuffer totalData = StringBuffer();
//       double evenData = 0.0;
//       double oddData = 0.0;
//       int idx = 0;
//       final client = ApiClient(Dio(BaseOptions(
//           contentType: "application/json",
//           connectTimeout: 100 * 1000,
//           receiveTimeout: 100 * 1000)));
//       await writeCharacteristic
//           .write(_bleProtocol.measureStart, withoutResponse: true)
//           .then((value) {
//         readCharacteristic.value.listen((event) {
//           for (int data in event) {
//             //짝수
//             if (idx % 2 == 0) {
//               evenData = evenData - (lPFCOEFFECG * (evenData - data));
//               totalData.write("$evenData ;");
//             }
//             //홀수
//             else {
//               oddData = oddData - (lPFCOEFFPPG * (oddData - data));
//               totalData.write("$oddData; 157 \n");
//             }
//             idx += 1;
//           }
//         });
//       });
//
//       Timer.periodic(Duration(seconds: 70), (timer) {
//         try {
//           measureStop();
//           client
//               .getResultAPI(ApiRawDto(80.0, totalData.toString()))
//               .then((value) {
//             apiResult = value;
//             totalData.clear();
//             timer.cancel();
//             print('apiResult : ${apiResult.toJson()}');
//           });
//         } catch (e) {
//           print('$e in measuring');
//           measureStop();
//         }
//       });
//     } catch (e) {
//       log('$e in measureStart()', name: tag);
//       measureStop();
//     }
//   }
//
//   Future<void> measureEnd() async {
//     try {
//       await writeCharacteristic
//           .write(_bleProtocol.measureEnd, withoutResponse: true)
//           .then((value) {
//         readCharacteristic.value.listen((event) {
//           print('measureEnd : $event');
//         });
//       });
//     } catch (e) {
//       log('$e in measureEnd()', name: tag);
//     }
//   }
//
//   Future<void> measureStop() async {
//     try {
//       await writeCharacteristic.write(_bleProtocol.measureEnd,
//           withoutResponse: true);
//     } catch (e) {
//       log('$e in measureStop()', name: tag);
//     }
//   }
//   // Future<void> measure() async{
//   //   ReceivePort _receivePort = ReceivePort();
//   //   Isolate _isolate = await Isolate.spawn(_measure, _receivePort.sendPort);
//   // }
//   // static void _measure(SendPort sendPort)async{
//   //   StringBuffer totalData = StringBuffer();
//   //   double evenData = 0.0;
//   //   double oddData = 0.0;
//   //   int idx = 0;
//   //   final client = ApiClient(Dio(BaseOptions(contentType: "application/json", connectTimeout: 100*1000, receiveTimeout: 100*1000)));
//   //   staticWriteCharacteristic.write(BleProtocol().measureStart, withoutResponse: true).then((value){
//   //     staticReadCharacteristic.value.listen((event) {
//   //       for(int data in event){
//   //         if(idx % 2 ==0){
//   //           evenData = evenData - (0.100 * (evenData - data));
//   //           totalData.write("$evenData ;");
//   //         }else{
//   //           oddData = oddData - (0.300 * (oddData - data));
//   //           totalData.write("$oddData; 157 \n");
//   //         }
//   //         idx += 1;
//   //       }
//   //     });
//   //   });
//   //   Timer.periodic(Duration(seconds: 70), (timer) {
//   //     try{
//   //       staticMeasureStop();
//   //       client.getResultAPI(ApiRawDto(80.0, totalData.toString())).then((value){
//   //         print('value : ${value.toJson()}');
//   //         totalData.clear();
//   //         timer.cancel();
//   //       });
//   //     }catch(e){
//   //       staticMeasureStop();
//   //       print('$e in error');
//   //     }
//   //   });
//   // }
//   // static Future<void> staticMeasureStop()async{
//   //   try{
//   //     await staticWriteCharacteristic.write(BleProtocol().measureEnd);
//   //   }catch(e){
//   //     log('$e in measureStop()', name: 'measure');
//   //   }
//   // }
// }