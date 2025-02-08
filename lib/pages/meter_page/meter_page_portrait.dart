import 'package:flutter/material.dart';
import 'package:taximeter/pages/meter_page/widgets/meter_animation.dart';
import 'package:taximeter/pages/meter_page/widgets/meter_control.dart';
import 'package:taximeter/pages/meter_page/widgets/meter_costview.dart';
import 'package:taximeter/pages/meter_page/widgets/meter_info.dart';
import 'package:taximeter/utils/meter_util.dart';

class MeterPagePortrait extends StatefulWidget {
  const MeterPagePortrait({super.key, required this.meterUtil, required this.updateCallback});

  final Function updateCallback;
  final MeterUtil meterUtil;

  @override
  State<StatefulWidget> createState() => _MeterPagePortraitState();
}

class _MeterPagePortraitState extends State<MeterPagePortrait> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MeterAnimation(meterUtil: widget.meterUtil),
        MeterCostView(meterUtil: widget.meterUtil),
        MeterInfo(meterUtil: widget.meterUtil),
        MeterControl(meterUtil: widget.meterUtil, updateCallback: widget.updateCallback),
      ],
    );
  }
}