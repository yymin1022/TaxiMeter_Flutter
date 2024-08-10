import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:taximeter/utils/color_util.dart";
import "package:taximeter/utils/meter_util.dart";
import "package:taximeter/utils/preference_util.dart";

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
  void initState() {
    super.initState();

    if(meterUtil.meterStatus == MeterStatus.METER_NOT_RUNNING) {
      meterUtil.initMeter().then((_) => updateMeterView());
    } else {
      updateMeterView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MeterColor.meterBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MeterAnimation(meterUtil: meterUtil),
            MeterCostView(meterUtil: meterUtil),
            MeterInfo(meterUtil: meterUtil),
            MeterControl(meterUtil: meterUtil, updateCallback: updateMeterView),
          ],
        )
      )
    );
  }
}

class MeterAnimation extends StatefulWidget {
  const MeterAnimation({super.key, required this.meterUtil});

  final MeterUtil meterUtil;

  @override
  State<StatefulWidget> createState() => _MeterAnimationState();
}

class _MeterAnimationState extends State<MeterAnimation> with SingleTickerProviderStateMixin {
  MeterTheme _curMeterTheme = MeterTheme.METER_THEME_HORSE;

  AnimationController? _meterAnimationController;
  List<Image> _meterAnimationFrameList = [];

  @override
  void initState() {
    super.initState();
    _meterAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    PreferenceUtil().getPrefsValueS("pref_theme").then((res) => {
      setState(() {
        _curMeterTheme = res == "horse" ? MeterTheme.METER_THEME_HORSE : MeterTheme.METER_THEME_CIRCLE;
        _loadImages();
        _meterAnimationController!.repeat();
      })
    });
  }

  @override
  void dispose() {
    _meterAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.0,
      width: 90.0,
      child: AnimatedBuilder(
        animation: _meterAnimationController!,
        builder: (context, child) {
          return _meterAnimationFrameList.isNotEmpty
              ? _meterAnimationFrameList[(_meterAnimationController!.value * _meterAnimationFrameList.length).floor() % _meterAnimationFrameList.length]
              : Container();
        }
      )
    );
  }

  void _loadImages() {
    if(_curMeterTheme == MeterTheme.METER_THEME_CIRCLE) {
      if(widget.meterUtil.meterCurSpeed > 50) {
        _meterAnimationFrameList = List.generate(8, (index) => Image.asset("assets/images/meter_circle/ic_circle_${index + 1}.png"));
        _meterAnimationController!.duration = const Duration(milliseconds: 104);
      } else if(widget.meterUtil.meterCurSpeed > 30) {
        _meterAnimationFrameList = List.generate(8, (index) => Image.asset("assets/images/meter_circle/ic_circle_${index + 1}.png"));
        _meterAnimationController!.duration = const Duration(milliseconds: 160);
      } else if(widget.meterUtil.meterCurSpeed > 15) {
        _meterAnimationFrameList = List.generate(8, (index) => Image.asset("assets/images/meter_circle/ic_circle_${index + 1}.png"));
        _meterAnimationController!.duration = const Duration(milliseconds: 328);
      } else if(widget.meterUtil.meterCurSpeed > 0) {
        _meterAnimationFrameList = List.generate(8, (index) => Image.asset("assets/images/meter_circle/ic_circle_${index + 1}.png"));
        _meterAnimationController!.duration = const Duration(milliseconds: 1000);
      } else {
        _meterAnimationFrameList = [Image.asset("assets/images/meter_circle/ic_circle_1.png")];
        _meterAnimationController!.duration = const Duration(milliseconds: 1000);
      }
    } else if(_curMeterTheme == MeterTheme.METER_THEME_HORSE) {
      if(widget.meterUtil.meterCurSpeed > 50) {
        _meterAnimationFrameList = List.generate(3, (index) => Image.asset("assets/images/meter_horse/ic_horse_${index + 1}.png"));
        _meterAnimationController!.duration = const Duration(milliseconds: 142);
      } else if(widget.meterUtil.meterCurSpeed > 30) {
        _meterAnimationFrameList = List.generate(3, (index) => Image.asset("assets/images/meter_horse/ic_horse_${index + 1}.png"));
        _meterAnimationController!.duration = const Duration(milliseconds: 200);
      } else if(widget.meterUtil.meterCurSpeed > 20) {
        _meterAnimationFrameList = List.generate(3, (index) => Image.asset("assets/images/meter_horse/ic_horse_${index + 1}.png"));
        _meterAnimationController!.duration = const Duration(milliseconds: 250);
      } else if(widget.meterUtil.meterCurSpeed > 10) {
        _meterAnimationFrameList = List.generate(3, (index) => Image.asset("assets/images/meter_horse/ic_horse_${index + 1}.png"));
        _meterAnimationController!.duration = const Duration(milliseconds: 333);
      } else if(widget.meterUtil.meterCurSpeed > 0) {
        _meterAnimationFrameList = List.generate(3, (index) => Image.asset("assets/images/meter_horse/ic_horse_${index + 1}.png"));
        _meterAnimationController!.duration = const Duration(milliseconds: 500);
      } else {
        _meterAnimationFrameList = [Image.asset("assets/images/meter_horse/ic_horse_1.png")];
        _meterAnimationController!.duration = const Duration(milliseconds: 1000);
      }
    }
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
                  widget.meterUtil.startMeter();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${NumberFormat("#,##0").format(widget.meterUtil.meterCost)}원",
            style: const TextStyle(
              color: MeterColor.meterTextColorWhite,
              fontSize: 75.0
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
      ),
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
                      meterInfoText("${NumberFormat("#,##0.0").format(widget.meterUtil.meterCurSpeed)}km/h")
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
                      meterInfoText("${NumberFormat("#,##0.0").format(widget.meterUtil.meterSumDistance)}km")
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