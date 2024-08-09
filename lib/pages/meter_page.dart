import 'package:flutter/material.dart';
import 'package:taximeter/utils/color_util.dart';
import 'package:taximeter/utils/meter_util.dart';

class MeterPage extends StatefulWidget {
  const MeterPage({super.key});

  @override
  State<StatefulWidget> createState() => _MeterPageState();
}

class _MeterPageState extends State<MeterPage> {
  var meterUtil = MeterUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: MeterColor.meterBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MeterInfo(meterUtil: meterUtil),
              MeterControl(meterUtil: meterUtil),
            ],
          ),
        )
      )
    );
  }
}

class MeterControl extends StatefulWidget {
  const MeterControl({super.key, required this.meterUtil});

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
            MeterButton(
              btnColor: MeterColor.meterBlue,
              btnText: "주행 시작",
              onClickFunction: (){}
            ),
            MeterButton(
              btnColor: MeterColor.meterYellow,
              btnText: "주행 종료",
              onClickFunction: (){}
            ),
          ],
        ),
        Row(
          children: [
            MeterButton(
              btnColor: MeterColor.meterGreen,
              btnText: MeterUtil().meterIsPercNight ? "야간할증 적용" : "야간할증 미적용",
              onClickFunction: (){
                setState(() {
                  widget.meterUtil.setPercNight(!widget.meterUtil.meterIsPercNight);
                });
              }
            ),
            MeterButton(
              btnColor: MeterColor.meterRed,
              btnText: MeterUtil().meterIsPercCity ? "시외할증 적용" : "시외할증 미적용",
              onClickFunction: (){
                setState(() {
                  widget.meterUtil.setPercCity((!widget.meterUtil.meterIsPercCity));
                });
              }
            ),
          ],
        ),
      ],
    );
  }
}

class MeterInfo extends StatefulWidget {
  const MeterInfo({super.key, required this.meterUtil});

  final MeterUtil meterUtil;

  @override
  State<StatefulWidget> createState() => _MeterInfoState();
}

class _MeterInfoState extends State<MeterInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                const Text(
                  "요금 종류",
                  style: TextStyle(color: MeterColor.meterTextColorWhite),
                ),
                Text(
                  widget.meterUtil.meterCostMode.toString(),
                  style: const TextStyle(color: MeterColor.meterTextColorWhite),
                ),
                const Text(
                  "현재 속도",
                  style: TextStyle(color: MeterColor.meterTextColorWhite),
                ),
                Text(
                  widget.meterUtil.meterCurSpeed.toString(),
                  style: const TextStyle(color: MeterColor.meterTextColorWhite),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  "운행 상태",
                  style: TextStyle(color: MeterColor.meterTextColorWhite),
                ),
                Text(
                  widget.meterUtil.meterStatus.toString(),
                  style: const TextStyle(color: MeterColor.meterTextColorWhite),
                ),
                const Text(
                  "주행 거리",
                  style: TextStyle(color: MeterColor.meterTextColorWhite),
                ),
                Text(
                  widget.meterUtil.meterSumDistance.toString(),
                  style: const TextStyle(color: MeterColor.meterTextColorWhite),
                ),
              ],
            )
          ],
        ),
      ],
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: widget.btnColor
          ),
          child: InkWell(
            onTap: widget.onClickFunction,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Text(
                  widget.btnText,
                  style: const TextStyle(
                    color: MeterColor.meterBtnText,
                    fontSize: 15.0
                  ),
                ),
              )
            ),
          )
        ),
      )
    );
  }
}