import 'dart:io';

import 'package:taximeter/cauly/ad_instance_manager.dart';

class CaulyAndroid {
  CaulyAndroid._();

  static final CaulyAndroid _instance = CaulyAndroid._().._init();

  static CaulyAndroid get instance => _instance;

  void initialize() {}

  void _init() {
    if (Platform.isAndroid) {
      instanceManager.channel.invokeMethod('_init');
    }
  }
}