class BleProtocol{
  final String serviceUUID = '0000fff0-0000-1000-8000-00805f9b34fb';
  final String readCharacteristicUUID = '0000fff1-0000-1000-8000-00805f9b34fb';
  final String writeCharacteristicUUID = '0000fff2-0000-1000-8000-00805f9b34fb';
  //getTemperature
  List<int> temperature = [0x5A, 0x01, 0x07, 0x01, 0xA5];
  //getHumidity
  List<int> humidity = [0x5A, 0x01, 0x8, 0x01, 0xA5];
  //getHeap
  List<int>? getHeap(String mode){
    switch(mode){
      case 'off':
        return [0x5A, 0x01, 0x05, 0xA1, 0xA5];
      case '1':
        return [0x5A, 0x01, 0x05, 0xA2, 0xA5];
      case '2':
        return [0x5A, 0x01, 0x05, 0xA3, 0xA5];
      case '3':
        return [0x5A, 0x01, 0x05, 0xA4, 0xA5];
    }
    return null;
  }

  //setMoveBack
  List<int>? getMoveBack(String mode){
    switch(mode){
      //앞으로
      case '1':
        return [0x5A, 0x01, 0x09, 0xA1, 0xA5];
      //뒤로
      case '2':
        return [0x5A, 0x01, 0x09, 0xA2, 0xA5];
      //원래대로
      case '3':
        return [0x5A, 0x01, 0x09, 0xA3, 0xA5];
      //멈춤
      case 'off':
        return [0x5A, 0x01, 0x09, 0xA4, 0xA5];
    }
    return null;
  }
  //setMoveFoot
  List<int>? getMoveFoot(String mode){
    switch(mode){
      //앞으로
      case '1':
        return [0x5A, 0x01, 0x10, 0xA1, 0xA5];
      //뒤로
      case '2':
        return [0x5A, 0x01, 0x10, 0xA2, 0xA5];
      //원래대로
      case '3':
        return [0x5A, 0x01, 0x10, 0xA3, 0xA5];
      //멈춤
      case 'off':
        return [0x5A, 0x01, 0x10, 0xA4, 0xA5];
    }
    return null;
  }
  //setMoving
  List<int>? getMoving(String mode){
    switch(mode){
      case 'off':
        return [0x5A, 0x01, 0x11, 0xA0, 0xA5];
      case '1':
        return [0x5A, 0x01, 0x11, 0xA1, 0xA5];
      case '2':
        return [0x5A, 0x01, 0x11, 0xA2, 0xA5];
      case '3':
        return [0x5A, 0x01, 0x11, 0xA3, 0xA5];
    }
    return null;
  }
  //heatRateLastStateGetStart (마지막 측정된 ble 온열 상태 받아오기)
  List<int> getLastHeap(){
    return [0x5A, 0x01, 0x05, 0x01, 0xA5];
  }
  //측정 시작
  List<int> measureStart = [0x5A, 0x01, 0X06, 0xA1, 0xA5];
  //측정 종료
  List<int> measureEnd = [0x5A, 0x01, 0x06, 0xA2, 0xA5];

}