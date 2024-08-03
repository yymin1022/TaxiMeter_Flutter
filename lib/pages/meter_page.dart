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
            children: [
              Text("Cost : ${MeterUtil().cost}"),
              Text("Counter : ${MeterUtil().costCounter}"),
              Text("Cost Mode : ${MeterUtil().costMode}"),
              Text("Meter Status : ${MeterUtil().meterStatus}"),
              Text("Current Speed : ${MeterUtil().curSpeed}"),
              Text("Drived Distance : ${MeterUtil().sumDistance}"),
            ],
          ),
        )
      )
    );
  }
}