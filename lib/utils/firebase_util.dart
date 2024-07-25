import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:taximeter/firebase_options.dart';
import 'package:taximeter/utils/preference_util.dart';

class FirebaseUtil {
  FirebaseUtil();

  final PreferenceUtil prefUtil = PreferenceUtil();

  void initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  bool isUpdateAvail() {
    return false;
  }

  void updateCostInfo() {

  }
}