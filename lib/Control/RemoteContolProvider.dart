import 'package:flutter/cupertino.dart';

class RemoteContolProvider with ChangeNotifier{
  bool _openControl;
  RemoteContolProvider(this._openControl);

  void setOpenControl(bool open){
    _openControl = open;
    notifyListeners();
  }
  getOpenControl() => _openControl;
}