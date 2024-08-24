import 'dart:io';

import 'package:taximeter/cauly/cauly.dart';

class CaulyAndroid {
  static final CaulyAndroid _instance = CaulyAndroid._().._init();
  static CaulyAndroid get instance => _instance;
  CaulyAndroid._();

  void initialize() {}
  void _init() {
    if(Platform.isAndroid) {
      instanceManager.channel.invokeMethod('_init');
    }
  }
}