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
              Row(
                children: [
                  MeterButton(btnColor: Colors.blue, btnText: "주행 시작", onClickFunction: (){}),
                  MeterButton(btnColor: Colors.yellow, btnText: "주행 종료", onClickFunction: (){}),
                ],
              ),
              Row(
                children: [
                  MeterButton(btnColor: Colors.green, btnText: "야간할증 미적용", onClickFunction: (){}),
                  MeterButton(btnColor: Colors.pink, btnText: "시외할증 미적용", onClickFunction: (){}),
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}

class MeterButton extends StatefulWidget {
  const MeterButton({super.key, required this.btnColor, required this.btnText, required this.onClickFunction});

  final Color btnColor;
  final String btnText;
  final void Function() onClickFunction;

  @override
  State<StatefulWidget> createState() => _MeterButtonState();
}

class _MeterButtonState extends State<MeterButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Container(
          color: widget.btnColor,
          child: InkWell(
            onTap: widget.onClickFunction,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Text(widget.btnText),
              )
            ),
          )
        ),
      )
    );
  }
}