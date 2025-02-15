import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';
import 'package:taximeter/utils/color_util.dart';
import 'package:taximeter/utils/meter_util.dart';

class MeterInfo extends StatefulWidget {
  const MeterInfo({super.key, required this.meterUtil});

  final MeterUtil meterUtil;

  @override
  State<StatefulWidget> createState() => _MeterInfoState();
}

class _MeterInfoState extends State<MeterInfo> {
  double meterCurSpeed = 0.0;
  double meterSumDistance = 0.0;
  String meterCostMode = "기본 요금";
  String meterStatus = "운행 중 아님";

  void updateMeterValue() {
    setState(() {
      switch(widget.meterUtil.meterCostMode) {
        case CostMode.COST_BASE: meterCostMode = AppLocalizations.of(context)!.meter_info_cost_mode_base;
        case CostMode.COST_DISTANCE: meterCostMode = AppLocalizations.of(context)!.meter_info_cost_mode_distance;
        case CostMode.COST_TIME: meterCostMode = AppLocalizations.of(context)!.meter_info_cost_mode_time;
      }

      switch(widget.meterUtil.meterStatus) {
        case MeterStatus.METER_GPS_ERROR: meterStatus = AppLocalizations.of(context)!.meter_info_status_gps_error;
        case MeterStatus.METER_NOT_RUNNING: meterStatus = AppLocalizations.of(context)!.meter_info_status_not_running;
        case MeterStatus.METER_RUNNING: meterStatus = AppLocalizations.of(context)!.meter_info_status_running;
      }

      meterCurSpeed = widget.meterUtil.meterCurSpeed;
      meterSumDistance = widget.meterUtil.meterSumDistance;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MeterInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateMeterValue();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 30.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      meterInfoText(AppLocalizations.of(context)!.meter_info_cost_mode_title),
                      meterInfoText(meterCostMode),
                      Container(height: 10.0),
                      meterInfoText(AppLocalizations.of(context)!.meter_info_speed_title),
                      meterInfoText(sprintf(AppLocalizations.of(context)!.meter_info_speed_data, [NumberFormat("#,##0.0").format(widget.meterUtil.meterCurSpeed)])),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      meterInfoText(AppLocalizations.of(context)!.meter_info_status_title),
                      meterInfoText(meterStatus),
                      Container(height: 10.0),
                      meterInfoText(AppLocalizations.of(context)!.meter_info_distance_title),
                      meterInfoText(sprintf(AppLocalizations.of(context)!.meter_info_distance_data, [NumberFormat("#,##0.0").format(widget.meterUtil.meterSumDistance / 1000)])),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text meterInfoText(String str) {
    return Text(
        str,
        style: const TextStyle(
          color: MeterColor.meterTextColorWhite,
          fontSize: 20.0,
        )
    );
  }
}