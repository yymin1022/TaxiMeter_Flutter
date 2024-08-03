import 'package:taximeter/utils/preference_util.dart';

class MeterUtil {
  MeterUtil._privateConstructor();
  static final MeterUtil _instance = MeterUtil._privateConstructor();

  factory MeterUtil() {
    return _instance;
  }

  var meterCost = 0;
  var meterCostCounter = 0;
  var meterCurSpeed = 0.0;
  var meterSumDistance = 0.0;

  var meterIsPercCity = false;
  var meterIsPercNight = false;

  var meterCostMode = CostMode.COST_BASE;
  var meterStatus = MeterStatus.METER_NOT_RUNNING;
  var meterTheme = MeterTheme.METER_THEME_HORSE;

  var prefCostBase = 0;
  var prefCostRunPer = 0;
  var prefCostTimePer = 0;
  var prefDistBase = 0;
  var prefPercCity = 0;
  var prefPercNight1 = 20;
  var prefPercNight2 = 40;
  var prefPercNightEnd1 = 4;
  var prefPercNightEnd2 = 2;
  var prefPercNightStart1 = 22;
  var prefPercNightStart2 = 23;
  var prefTheme = "horse";

  void initMeter() async {
    if(meterStatus == MeterStatus.METER_NOT_RUNNING) {
      await _initValue();

      meterStatus = MeterStatus.METER_RUNNING;
    }
  }

  void stopMeter() {
    if(meterStatus != MeterStatus.METER_NOT_RUNNING) {
      meterCostMode = CostMode.COST_BASE;
      meterStatus = MeterStatus.METER_RUNNING;
    }
  }

  void increaseCost() {

  }

  void setPercCity(bool isEnabled) {
    if(meterIsPercCity != isEnabled) {
      meterIsPercCity = isEnabled;
    }
  }

  void setPercNight(bool isEnabled) {
    if(meterIsPercNight != isEnabled) {
      meterIsPercNight = isEnabled;
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
    prefTheme = await PreferenceUtil().getPrefsValueS("pref_theme") ?? "horse";

    meterCost = prefCostBase;
    meterCostCounter = prefDistBase;
    meterCostMode = CostMode.COST_BASE;
    meterCurSpeed = 0.0;
    meterTheme = prefTheme == "horse" ? MeterTheme.METER_THEME_HORSE : MeterTheme.METER_THEME_CIRCLE;
    meterSumDistance = 0.0;
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