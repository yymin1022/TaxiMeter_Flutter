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

  void updateMeterView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: MeterColor.meterBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MeterCostView(meterUtil: meterUtil),
              MeterInfo(meterUtil: meterUtil),
              MeterControl(meterUtil: meterUtil, updateCallback: updateMeterView),
            ],
          ),
        )
      )
    );
  }
}

class MeterControl extends StatefulWidget {
  const MeterControl({super.key, required this.meterUtil, required this.updateCallback});

  final MeterUtil meterUtil;
  final Function updateCallback;

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
              onClickFunction: () {
                setState(() {
                  widget.meterUtil.initMeter();
                  widget.updateCallback();
                });
              }
            ),
            MeterButton(
              btnColor: MeterColor.meterYellow,
              btnText: "주행 종료",
              onClickFunction: () {
                setState(() {
                  widget.meterUtil.stopMeter();
                  widget.updateCallback();
                });
              }
            ),
          ],
        ),
        Row(
          children: [
            MeterButton(
              btnColor: MeterColor.meterGreen,
              btnText: widget.meterUtil.meterIsPercNight ? "야간할증 적용" : "야간할증 미적용",
              onClickFunction: () {
                setState(() {
                  widget.meterUtil.setPercNight(!widget.meterUtil.meterIsPercNight);
                  widget.updateCallback();
                });
              }
            ),
            MeterButton(
              btnColor: MeterColor.meterRed,
              btnText: widget.meterUtil.meterIsPercCity ? "시외할증 적용" : "시외할증 미적용",
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
}

class MeterCostView extends StatefulWidget {
  const MeterCostView({super.key, required this.meterUtil});

  final MeterUtil meterUtil;

  @override
  State<StatefulWidget> createState() => _MeterCostViewState();
}

class _MeterCostViewState extends State<MeterCostView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "${widget.meterUtil.meterCost}원",
          style: const TextStyle(
            color: MeterColor.meterTextColorWhite,
            fontSize: 60.0
          ),
        ),
        Text(
          widget.meterUtil.meterCostCounter.toString(),
          style: const TextStyle(
            color: MeterColor.meterBlue,
            fontSize: 35.0
          )
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
  double meterCurSpeed = 0.0;
  double meterSumDistance = 0.0;
  String meterCostMode = "기본 요금";
  String meterStatus = "운행 중 아님";

  void updateMeterValue() {
    setState(() {
      switch(widget.meterUtil.meterCostMode) {
        case CostMode.COST_BASE: meterCostMode = "기본 요금";
        case CostMode.COST_DISTANCE: meterCostMode = "주행 요금";
        case CostMode.COST_TIME: meterCostMode = "시간 요금";
      }

      switch(widget.meterUtil.meterStatus) {
        case MeterStatus.METER_GPS_ERROR: meterStatus = "GPS 연결 대기 중";
        case MeterStatus.METER_NOT_RUNNING: meterStatus = "운행 중 아님";
        case MeterStatus.METER_RUNNING: meterStatus = "운행 중";
      }

      meterCurSpeed = widget.meterUtil.meterCurSpeed;
      meterSumDistance = widget.meterUtil.meterSumDistance;
    });
  }

  @override
  void initState() {
    super.initState();
    updateMeterValue();
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
                      meterInfoText("요금 종류"),
                      meterInfoText(meterCostMode),
                      Container(height: 10.0),
                      meterInfoText("현재 속도"),
                      meterInfoText("${meterCurSpeed.toStringAsFixed(1)}km/h")
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
                      meterInfoText("운행 상태"),
                      meterInfoText(meterStatus),
                      Container(height: 10.0),
                      meterInfoText("주행 거리"),
                      meterInfoText("${meterSumDistance.toStringAsFixed(1)}km")
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
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  widget.btnText,
                  style: const TextStyle(
                    color: MeterColor.meterBtnText,
                    fontSize: 17.5
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