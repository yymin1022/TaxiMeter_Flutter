import 'package:flutter/material.dart';
import 'package:taximeter/utils/meter_util.dart';
import 'package:taximeter/utils/preference_util.dart';

class MeterAnimation extends StatefulWidget {
  const MeterAnimation({super.key, required this.meterUtil});

  final MeterUtil meterUtil;

  @override
  State<StatefulWidget> createState() => _MeterAnimationState();
}

class _MeterAnimationState extends State<MeterAnimation> with SingleTickerProviderStateMixin {
  MeterTheme _curMeterTheme = MeterTheme.METER_THEME_HORSE;

  AnimationController? _meterAnimationController;
  final List<Image> _meterCircleFrames = List.generate(8, (index) => Image.asset("assets/images/meter_circle/ic_circle_${index + 1}.png"));
  final List<Image> _meterHorseFrames = List.generate(3, (index) => Image.asset("assets/images/meter_horse/ic_horse_${index + 1}.png"));

  @override
  void initState() {
    super.initState();
    _meterAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    PreferenceUtil().getPrefsValueS("pref_theme").then((res) => {
      setState(() {
        _curMeterTheme = res == "circle" ? MeterTheme.METER_THEME_CIRCLE : MeterTheme.METER_THEME_HORSE;
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
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
          height: 90.0,
          width: 90.0,
          child: AnimatedBuilder(
              animation: _meterAnimationController!,
              builder: (context, child) {
                _updateDuration();

                if(_curMeterTheme == MeterTheme.METER_THEME_CIRCLE) {
                  return _meterCircleFrames[(_meterAnimationController!.value * 8).floor() % 8];
                } else {
                  return _meterHorseFrames[(_meterAnimationController!.value * 3).floor() % 3];
                }
              }
          )
      ),
    );
  }

  void _updateDuration() {
    _meterAnimationController!.repeat();
    if(_curMeterTheme == MeterTheme.METER_THEME_CIRCLE) {
      if(widget.meterUtil.meterCurSpeed > 50) {
        _meterAnimationController!.duration = const Duration(milliseconds: 104);
      } else if(widget.meterUtil.meterCurSpeed > 30) {
        _meterAnimationController!.duration = const Duration(milliseconds: 160);
      } else if(widget.meterUtil.meterCurSpeed > 15) {
        _meterAnimationController!.duration = const Duration(milliseconds: 328);
      } else if(widget.meterUtil.meterCurSpeed > 0) {
        _meterAnimationController!.duration = const Duration(milliseconds: 1000);
      } else {
        _meterAnimationController!.stop();
      }
    } else if(_curMeterTheme == MeterTheme.METER_THEME_HORSE) {
      if(widget.meterUtil.meterCurSpeed > 50) {
        _meterAnimationController!.duration = const Duration(milliseconds: 142);
      } else if(widget.meterUtil.meterCurSpeed > 30) {
        _meterAnimationController!.duration = const Duration(milliseconds: 200);
      } else if(widget.meterUtil.meterCurSpeed > 20) {
        _meterAnimationController!.duration = const Duration(milliseconds: 250);
      } else if(widget.meterUtil.meterCurSpeed > 10) {
        _meterAnimationController!.duration = const Duration(milliseconds: 333);
      } else if(widget.meterUtil.meterCurSpeed > 0) {
        _meterAnimationController!.duration = const Duration(milliseconds: 500);
      } else {
        _meterAnimationController!.stop();
      }
    }
  }
}