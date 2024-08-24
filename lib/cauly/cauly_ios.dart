import 'dart:io';

class CaulyIos {
  static final CaulyIos _instance = CaulyIos._().._init();
  static CaulyIos get instance => _instance;
  CaulyIos._();

  void initialize() {}
  void _init() {
    if(Platform.isIOS) {
      //TODO: Initialize iOS MethodChannel
    }
  }
}