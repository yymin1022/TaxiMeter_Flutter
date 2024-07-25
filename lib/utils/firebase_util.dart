import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:taximeter/firebase_options.dart';
import 'package:taximeter/utils/preference_util.dart';

class FirebaseUtil {
  FirebaseUtil();

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

  void updateCostInfo() async {
    var costInfoDoc = (await _firestoreDB.collection("cost").doc("info").get())
        .data()?["data"]!;
    costInfoDoc.forEach((data) {
      var curCity = data["city"];
      var curData = data["data"];
      curData.forEach((key, val) {
        _prefUtil.setPrefsValue("pref_cost_${curCity}_$key", val);
      });
    });
  }
}