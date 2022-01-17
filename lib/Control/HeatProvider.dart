import 'package:flutter/cupertino.dart';

class HeatProvider with ChangeNotifier{
  bool? _isHeatOn;
  bool? _isHeatChecked;
  DateTime? _heatTime;
  int? _itemIndex;
  HeatProvider(this._isHeatOn, this._isHeatChecked, this._heatTime, this._itemIndex);

  void setHeatOn(bool on){
    _isHeatOn = on;
    notifyListeners();
  }
  getHeatOn() => _isHeatOn;

  void setHeatChecked(bool check){
    _isHeatChecked = check;
    notifyListeners();
  }
  getHeatCheck() => _isHeatChecked;

  void setHeatTime(DateTime? time){
    _heatTime = time;
    notifyListeners();
  }
  getHeatTime() => _heatTime;

  void setItemIndex(int? idx){
    _itemIndex = idx;
    notifyListeners();
  }
  getItemIndex() => _itemIndex;
}