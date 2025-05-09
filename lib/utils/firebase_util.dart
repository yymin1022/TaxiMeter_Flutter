import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:taximeter/firebase_options.dart';
import 'package:taximeter/utils/preference_util.dart';

class FirebaseUtil {
  FirebaseUtil._privateConstructor();
  static final FirebaseUtil _instance = FirebaseUtil._privateConstructor();

  factory FirebaseUtil() {
    return _instance;
  }

  final _prefUtil = PreferenceUtil();
  late FirebaseFirestore _firestoreDB;

  Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    _firestoreDB = FirebaseFirestore.instance;
  }

  Future<bool> isUpdateAvail() async {
    var curVersion = await _prefUtil.getPrefsValueS("pref_cost_version") ?? "20001022";
    var newVersion = (await _firestoreDB.collection("cost").doc("version").get())
        .data()?["data"] ?? "20001022";
    return curVersion != newVersion;
  }

  void logAnalytics(String action, String? msg) async {
    await FirebaseAnalytics.instance.logEvent(
      name: action,
      parameters: {"detail": (msg ?? "")}
    );
  }

  void updateCostInfo() async {
    FirebaseUtil().logAnalytics("update_cost_start", null);

    var costInfoDoc = (await _firestoreDB.collection("cost").doc("info").get())
        .data()?["data"]!;
    costInfoDoc.forEach((data) {
      var curCity = data["city"];
      var curData = data["data"];
      curData.forEach((key, val) {
        _prefUtil.setPrefsValue("pref_cost_${curCity}_$key", val);
      });
    });
    var newVersion = (await _firestoreDB.collection("cost").doc("version").get())
        .data()?["data"] ?? "20001022";
    _prefUtil.setPrefsValue("pref_cost_version", newVersion);

    FirebaseUtil().logAnalytics("update_cost_done", newVersion);
  }
}