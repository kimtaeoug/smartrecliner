import 'package:flutter/cupertino.dart';

class ShakeProvider with ChangeNotifier{
  bool? _isShakeOn;
  bool? _isShakeChecked;
  DateTime? _shakeTime;
  int? _itemIndex;
  ShakeProvider(this._isShakeOn, this._isShakeChecked, this._shakeTime, this._itemIndex);

  void setShakeOn(bool on){
    _isShakeOn = on;
    notifyListeners();
  }
  getShakeOn() => _isShakeOn;

  void setShakeChecked(bool check){
    _isShakeChecked = check;
    notifyListeners();
  }
  getShakeCheck() => _isShakeChecked;

  void setShakeTime(DateTime? time){
    _shakeTime = time;
    notifyListeners();
  }
  getShakeTime() => _shakeTime;
  void setItemIndex(int? idx){
    _itemIndex = idx;
    notifyListeners();
  }
  getItemIndex() => _itemIndex;
}