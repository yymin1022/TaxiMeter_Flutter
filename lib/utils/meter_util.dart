class MeterUtil {
  MeterUtil._privateConstructor();
  static final MeterUtil _instance = MeterUtil._privateConstructor();

  factory MeterUtil() {
    return _instance;
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