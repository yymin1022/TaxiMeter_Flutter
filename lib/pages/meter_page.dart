import 'package:flutter/material.dart';
import 'package:taximeter/utils/meter_util.dart';

class MeterPage extends StatelessWidget {
  const MeterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Cost : ${MeterUtil().meterCost}"),
              Text("Counter : ${MeterUtil().meterCostCounter}"),
              Text("Cost Mode : ${MeterUtil().meterCostMode}"),
              Text("Meter Status : ${MeterUtil().meterStatus}"),
              Text("Current Speed : ${MeterUtil().meterCurSpeed}"),
              Text("Drived Distance : ${MeterUtil().meterSumDistance}"),
            ],
          ),
        )
      )
    );
  }
}