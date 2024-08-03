class MeterUtil {
  MeterUtil._privateConstructor();
  static final MeterUtil _instance = MeterUtil._privateConstructor();

  factory MeterUtil() {
    return _instance;
  }

  var cost = 0;
  var costCounter = 0;
  var curSpeed = 0.0;
  var sumDistance = 0.0;

  var costMode = CostMode.COST_BASE;
  var meterStatus = MeterStatus.METER_NOT_RUNNING;
  var meterTheme = MeterTheme.METER_THEME_HORSE;

  void initMeter() {
    if(meterStatus == MeterStatus.METER_NOT_RUNNING) {
      _initValue();

      meterStatus = MeterStatus.METER_RUNNING;
    }
  }

  void stopMeter() {
    if(meterStatus != MeterStatus.METER_NOT_RUNNING) {
      costMode = CostMode.COST_BASE;
      meterStatus = MeterStatus.METER_RUNNING;
    }
  }

  void increaseCost() {

  }

  void _initValue() {
    
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