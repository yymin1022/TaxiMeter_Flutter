import 'package:flutter/material.dart';
import 'package:taximeter/pages/meter_page/widgets/meter_animation.dart';
import 'package:taximeter/pages/meter_page/widgets/meter_control.dart';
import 'package:taximeter/pages/meter_page/widgets/meter_costview.dart';
import 'package:taximeter/pages/meter_page/widgets/meter_info.dart';
import 'package:taximeter/utils/meter_util.dart';

class MeterPageLandscape extends StatefulWidget {
  const MeterPageLandscape({super.key, required this.meterUtil, required this.updateCallback});

  final Function updateCallback;
  final MeterUtil meterUtil;

  @override
  State<StatefulWidget> createState() => _MeterPageLandscapeState();
}

class _MeterPageLandscapeState extends State<MeterPageLandscape> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              MeterCostView(meterUtil: widget.meterUtil),
              MeterInfo(meterUtil: widget.meterUtil),
            ],
          )
        ),
        Expanded(
          child: Column(
            children: [
              MeterAnimation(meterUtil: widget.meterUtil),
              MeterControl(meterUtil: widget.meterUtil, updateCallback: widget.updateCallback),
            ],
          )
        ),
      ],
    );
  }
}