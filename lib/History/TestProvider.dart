import 'dart:isolate';

import 'package:flutter/cupertino.dart';

//    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       _testProvider = Provider.of<TestProvider>(context, listen: false);
//     });
class TestProvider with ChangeNotifier{
  String testText;
  TestProvider(this.testText);
  late Isolate _isolate;
  late ReceivePort _receivePort;
  void setTestText(String test){
    testText = test;
    notifyListeners();
  }
  getTestText() => testText;
  void test() async{
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(test2, _receivePort.sendPort);
    _receivePort.listen(test3, onDone: (){
      print('done');
    });
  }
  static void test2(SendPort sendPort){
    sendPort.send('hey');
  }
  void test3(dynamic data){
    print('=======================');
    testText = data;
    notifyListeners();
    _receivePort.close();
    _isolate.kill(priority: Isolate.immediate);
    print('data : $data');
    print('=======================');
  }
//  //  void initRequestRecent() async{
// //     _receivePort = ReceivePort();
// //     _isolate = await Isolate.spawn(requestRecentByIsolate, _receivePort.sendPort);
// //     _receivePort.listen(setRequestRecentData, onDone: (){
// //       print('setRequestRecentData done');
// //     });
// //   }
// //   static void requestRecentByIsolate(SendPort sendPort)async{
// //     await HistoryAPI(Dio(BaseOptions(contentType: "application/json"))).getRecent().then((value){
// //       sendPort.send(value);
// //     });
// //   }
// //   void setRequestRecentData(dynamic data){
// //     setState(() {
// //       requestRecentData = data;
// //     });
// //     _receivePort.close();
// //     _isolate.kill(priority: Isolate.immediate);
// //   }
//
// List<HistoryApiResponse> isolateProcess(List<HistoryApiResponse> inputData){
//   return compute(getAvgHistoryData, inputData);
// }
}