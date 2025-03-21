import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:taximeter/utils/preference_util.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class MeterUtil {
  MeterUtil({required this.updateView}) {
    _initValue().then((res) => updateView());
  }

  final Function updateView;

  var meterCost = 0;
  var meterCostCounter = 0;
  var meterCurSpeed = 0.0;
  var meterSumDistance = 0.0;

  var meterIsPercCity = false;
  var meterIsPercNight = false;

  var meterCostMode = CostMode.COST_BASE;
  var meterStatus = MeterStatus.METER_NOT_RUNNING;

  var prefCostBase = 4800;
  var prefCostRunPer = 132;
  var prefCostTimePer = 31;
  var prefDistBase = 1600;
  var prefPercCity = 20;
  var prefPercNight1 = 20;
  var prefPercNight2 = 40;
  var prefPercNightEnd1 = 4;
  var prefPercNightEnd2 = 2;
  var prefPercNightStart1 = 22;
  var prefPercNightStart2 = 23;

  late Timer _gpsTimer;
  late LocationSettings _locationSettings;
  int _lastUpdateTime = 0;

  void startMeter(BuildContext context) async {
    if(meterStatus == MeterStatus.METER_NOT_RUNNING) {
      meterStatus = MeterStatus.METER_GPS_ERROR;
      increaseCost(null);

      if(Platform.isIOS) {
        Geolocator.requestTemporaryFullAccuracy(purposeKey: "METER_UTIL")
          .then((accuracyStatus) async {
            if (accuracyStatus != LocationAccuracyStatus.precise && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!
                      .meter_snack_warning_location_accuracy),
                  duration: const Duration(seconds: 2),
                )
              );
            }
          });
      }

      if(Platform.isAndroid) {
        _locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
          forceLocationManager: true,
          foregroundNotificationConfig: ForegroundNotificationConfig(
            notificationChannelName: AppLocalizations.of(context)!.meter_noti_gps_channel,
            notificationTitle: AppLocalizations.of(context)!.meter_noti_gps_title,
            notificationText: AppLocalizations.of(context)!.meter_noti_gps_text,
            setOngoing: true
          ),
          intervalDuration: const Duration(milliseconds: 0),
          timeLimit: const Duration(seconds: 1)
        );
      } else {
        _locationSettings = AppleSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          activityType: ActivityType.automotiveNavigation,
          allowBackgroundLocationUpdates: true,
          distanceFilter: 0,
          pauseLocationUpdatesAutomatically: false,
          showBackgroundLocationIndicator: true,
          timeLimit: const Duration(seconds: 1)
        );
      }

      _gpsTimer = Timer.periodic(
        const Duration(seconds: 1), (_) async {
          try {
            increaseCost(await Geolocator.getCurrentPosition(
              locationSettings: _locationSettings
            ));
          } on TimeoutException catch(_) {
            increaseCost(await Geolocator.getLastKnownPosition());
          }
        }
      );

      meterStatus = MeterStatus.METER_RUNNING;
      WakelockPlus.enable();
    }
  }

  void stopMeter() {
    if(meterStatus != MeterStatus.METER_NOT_RUNNING) {
      WakelockPlus.disable();
      _gpsTimer.cancel();
      _initValue();
    }
  }

  void increaseCost(Position? curPosition) {
    if(meterStatus == MeterStatus.METER_NOT_RUNNING) {
      return;
    }

    final curTime = DateTime.now().millisecondsSinceEpoch;
    if(_lastUpdateTime == 0) {
      _lastUpdateTime = curTime;
      return;
    }

    final deltaTime = (curTime - _lastUpdateTime) / 1000.0;
    if(curPosition != null && curPosition.accuracy.toInt() < 50) {
      final curSpeed = curPosition.speed.toInt();
      meterCurSpeed = curSpeed * 3.6;
      meterStatus = MeterStatus.METER_RUNNING;

      meterCostCounter -= (curSpeed * deltaTime).toInt();
      meterSumDistance += curSpeed * deltaTime;
    } else {
      meterCurSpeed = 0;
      meterStatus = MeterStatus.METER_GPS_ERROR;
    }

    if(meterCurSpeed < 15) {
      meterCostCounter -= (prefCostRunPer / prefCostTimePer * deltaTime).toInt();

      if(meterCostMode == CostMode.COST_DISTANCE) {
        meterCostMode = CostMode.COST_TIME;
      }
    } else {
      if(meterCostMode == CostMode.COST_TIME) {
        meterCostMode = CostMode.COST_DISTANCE;
      }
    }

    _lastUpdateTime = curTime;

    if(meterCostCounter <= 0) {
      meterCost += 100;
      meterCostCounter += prefCostRunPer;

      if(meterCostCounter < 0) {
        meterCostCounter = 0;
      }

      if(meterIsPercNight) {
        final curH = int.parse(DateFormat('HH').format(DateTime.now()));
        if ((curH >= 20 && curH >= prefPercNightStart1) || (curH <= 5 && curH < prefPercNightEnd1)) {
          meterCost += (curH >= 20 && curH >= prefPercNightStart2) || (curH <= 5 && curH < prefPercNightEnd2)
              ? prefPercNight2 : prefPercNight1;
        }
      }

      if(meterIsPercCity) {
        meterCost += prefPercCity;
      }

      if(meterCostMode == CostMode.COST_BASE) {
        meterCostMode = CostMode.COST_DISTANCE;
      }
    }

    updateView();
  }

  void setPercCity(bool isEnabled) {
    meterIsPercCity = isEnabled;
    if(isEnabled) {
      meterCost += prefCostBase * prefPercCity ~/ 100;
    } else {
      meterCost -= prefCostBase * prefPercCity ~/ 100;
    }
  }

  void setPercNight(bool isEnabled) {
    meterIsPercNight = isEnabled;

    int curH = int.parse(DateFormat('HH').format(DateTime.now()));
    int premiumCost = 0;

    if((curH >= 20 && curH >= prefPercNightStart1) || (curH <= 5 && curH < prefPercNightEnd1)) {
      premiumCost = (curH >= 20 && curH >= prefPercNightStart2) || (curH <= 5 && curH < prefPercNightEnd2)
          ? prefCostBase * prefPercNight2 ~/ 100
          : prefCostBase * prefPercNight1 ~/ 100;
    }

    if(isEnabled) {
      meterCost += premiumCost;
    } else {
      meterCost -= premiumCost;
    }
  }

  Future<void> _initValue() async {
    prefCostBase = await PreferenceUtil().getPrefsValueI("pref_cost_base") ?? 4800;
    prefCostRunPer = await PreferenceUtil().getPrefsValueI("pref_cost_run_per") ?? 131;
    prefCostTimePer = await PreferenceUtil().getPrefsValueI("pref_cost_time_per") ?? 30;
    prefDistBase = await PreferenceUtil().getPrefsValueI("pref_dist_base") ?? 1600;
    prefPercCity = await PreferenceUtil().getPrefsValueI("pref_perc_city") ?? 20;
    prefPercNight1 = await PreferenceUtil().getPrefsValueI("pref_perc_night_1") ?? 20;
    prefPercNight2 = await PreferenceUtil().getPrefsValueI("pref_perc_night_2") ?? 40;
    prefPercNightEnd1 = await PreferenceUtil().getPrefsValueI("pref_perc_night_end_1") ?? 4;
    prefPercNightEnd2 = await PreferenceUtil().getPrefsValueI("pref_perc_night_end_2") ?? 2;
    prefPercNightStart1 = await PreferenceUtil().getPrefsValueI("pref_perc_night_start_1") ?? 22;
    prefPercNightStart2 = await PreferenceUtil().getPrefsValueI("pref_perc_night_start_2") ?? 23;

    _lastUpdateTime = 0;

    meterCost = prefCostBase;
    meterCostCounter = prefDistBase;
    meterCurSpeed = 0.0;
    meterSumDistance = 0.0;

    meterIsPercCity = false;
    meterIsPercNight = false;

    meterCostMode = CostMode.COST_BASE;
    meterStatus = MeterStatus.METER_NOT_RUNNING;
  }
}

enum CostMode {
  COST_BASE,
  COST_DISTANCE,
  COST_TIME
}

enum MeterStatus {
  METER_NOT_RUNNING,
  METER_RUNNING,
  METER_GPS_ERROR
}

enum MeterTheme {
  METER_THEME_CIRCLE,
  METER_THEME_HORSE
}