import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';
import 'package:taximeter/l10n/app_localizations.dart';
import 'package:taximeter/pages/meter_page/widgets/meter_control_button.dart';
import 'package:taximeter/utils/color_util.dart';
import 'package:taximeter/utils/firebase_util.dart';
import 'package:taximeter/utils/meter_util.dart';

class MeterControl extends StatefulWidget {
  const MeterControl({super.key, required this.meterUtil, required this.updateCallback});

  final Function updateCallback;
  final MeterUtil meterUtil;

  @override
  State<StatefulWidget> createState() => _MeterControlState();
}

class _MeterControlState extends State<MeterControl> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            MeterControlButton(
              btnColor: MeterColor.meterBlue,
              btnText: AppLocalizations.of(context)!.meter_btn_start,
              onClickFunction: () {
                FirebaseUtil().logAnalytics("meter_start", null);
                setState(() {
                  widget.meterUtil.startMeter(context);
                  widget.updateCallback();
                });
              }
            ),
            MeterControlButton(
              btnColor: MeterColor.meterYellow,
              btnText: AppLocalizations.of(context)!.meter_btn_stop,
              onClickFunction: () {
                setState(() {
                  if(widget.meterUtil.meterStatus != MeterStatus.METER_NOT_RUNNING) {
                    _showStopDialog();
                  }
                });
              }
            ),
          ],
        ),
        Row(
          children: [
            MeterControlButton(
              btnColor: MeterColor.meterGreen,
              btnText: widget.meterUtil.meterIsPercNight
                  ? AppLocalizations.of(context)!.meter_btn_percentage_night_true
                  : AppLocalizations.of(context)!.meter_btn_percentage_night_false,
              onClickFunction: () {
                setState(() {
                  widget.meterUtil.setPercNight(!widget.meterUtil.meterIsPercNight);
                  widget.updateCallback();
                });

                if(widget.meterUtil.meterIsPercNight) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!.meter_snack_percentage_night),
                        duration: const Duration(seconds: 2),
                      )
                  );
                }
              }
            ),
            MeterControlButton(
              btnColor: MeterColor.meterRed,
              btnText: widget.meterUtil.meterIsPercCity
                  ? AppLocalizations.of(context)!.meter_btn_percentage_outcity_true
                  : AppLocalizations.of(context)!.meter_btn_percentage_outcity_false,
              onClickFunction: () {
                setState(() {
                  widget.meterUtil.setPercCity((!widget.meterUtil.meterIsPercCity));
                  widget.updateCallback();
                });
              }
            ),
          ],
        ),
        Container(height: 20.0),
      ],
    );
  }

  void _showStopDialog() {
    var meterCost = widget.meterUtil.meterCost;
    var meterDistance = widget.meterUtil.meterSumDistance;
    var meterPercNight = widget.meterUtil.meterIsPercNight;
    var meterPercCity = widget.meterUtil.meterIsPercCity;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(30.0),
            content: Text(
              sprintf(AppLocalizations.of(context)!.meter_dialog_stop_content, [NumberFormat("#,##0").format(meterCost), NumberFormat("#,##0.0").format(meterDistance / 1000)]),
              style: const TextStyle(fontSize: 17.0),
            ),
            title: Text(AppLocalizations.of(context)!.meter_dialog_stop_title),
            actions: <Widget>[
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.meter_dialog_stop_ok,
                  style: const TextStyle(fontSize: 17.0),
                ),
                onPressed: () {
                  FirebaseUtil().logAnalytics("meter_stop", "Cost: $meterCost / Distance: $meterDistance} / OutCity: $meterPercCity / Night: $meterPercNight");
                  widget.meterUtil.stopMeter();
                  widget.updateCallback();
                  Navigator.pop(context);
                }
              ),
            ],
          );
        }
    );
  }
}