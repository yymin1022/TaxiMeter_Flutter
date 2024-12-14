import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:intl/intl.dart";
import "package:sprintf/sprintf.dart";
import "package:taximeter/cauly/cauly.dart";
import "package:taximeter/utils/color_util.dart";
import "package:taximeter/utils/meter_util.dart";
import "package:taximeter/utils/preference_util.dart";

class MeterPage extends StatefulWidget {
  const MeterPage({super.key});

  @override
  State<StatefulWidget> createState() => _MeterPageState();
}

class _MeterPageState extends State<MeterPage> {
  bool isAdRemoval = false;
  MeterUtil? meterUtil;

  void updateMeterView() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    meterUtil = MeterUtil(updateView: updateMeterView);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    PreferenceUtil().getPrefesValueB("ad_remove")
        .then((res) => setState(() {
      isAdRemoval = res ?? false;
    }));
  }

  @override
  void dispose() {
    super.dispose();
    meterUtil?.stopMeter();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (res, _) async {
        if(!res && context.mounted && await _showExitDialog() == true) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: MeterColor.meterBackground,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MeterAnimation(meterUtil: meterUtil!),
                  MeterCostView(meterUtil: meterUtil!),
                  MeterInfo(meterUtil: meterUtil!),
                  MeterControl(meterUtil: meterUtil!, updateCallback: updateMeterView),
                  isAdRemoval ? const SizedBox.shrink() : const MeterAdvertisement(),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: MeterColor.meterTextColorWhite,
                ),
                onPressed: () async {
                  if(context.mounted && await _showExitDialog() == true) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        )
      )
    );
  }

  Future<bool?> _showExitDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(30.0),
          content: Text(
            AppLocalizations.of(context)!.meter_dialog_exit_content,
            style: const TextStyle(fontSize: 17.0),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.meter_dialog_exit_no,
                style: const TextStyle(fontSize: 17.0),
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.meter_dialog_exit_ok,
                style: const TextStyle(fontSize: 17.0),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      }
    );
  }
}

class MeterAdvertisement extends StatefulWidget {
  const MeterAdvertisement({super.key});

  @override
  State<StatefulWidget> createState() => _MeterAdvertisementState();
}

class _MeterAdvertisementState extends State<MeterAdvertisement> {
  BannerAd? _bannerAdView;

  @override
  void initState() {
    super.initState();

    if(Platform.isAndroid) {
      _createBannerAdViewAndroid();
    } else {
      _createBannerAdViewIOS();
    }
  }

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid) {
      return SizedBox(
        height: _bannerAdView!.bannerSizeHeight.toDouble(),
        child: AdWidget(ad: _bannerAdView!),
      );
    } else {
      return const SizedBox(
        height: 50,
        child: UiKitView(
          viewType: 'bannerViewType',
          layoutDirection: null,
          creationParams: {"param": "bannerViewParam"},
          creationParamsCodec: StandardMessageCodec(),
        ),
      );
    }
  }

  void _createBannerAdViewAndroid() {
    _bannerAdView = BannerAd(
      listener: BannerAdListener(
        onReceiveAd: (ad) {
          debugPrint('BannerAdListener onReceiveAd!!!');
        },
        onFailedToReceiveAd: (ad, errorCode, errorMessage) {
          debugPrint('BannerAdListener onFailedToReceiveAd : $errorCode $errorMessage');
        },
      ),
      adInfo: AdInfo(
        dotenv.get("CAULY_APP_CODE_ANDROID"),
        BannerHeightEnum.adaptive, 320, 50));
    _bannerAdView!.load();
  }

  void _createBannerAdViewIOS() {
    const methodChannel = MethodChannel('samples.flutter.dev/caulyIos');
    methodChannel.invokeMethod('initialize', <String, dynamic>{'identifier':'TAXI_METER', 'code': dotenv.get("CAULY_APP_CODE_IOS"), 'useDynamicReload': true, 'closeLanding': true });
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
              btnText: AppLocalizations.of(context)!.meter_btn_start,
              onClickFunction: () {
                setState(() {
                  widget.meterUtil.startMeter(context);
                  widget.updateCallback();
                });
              }
            ),
            MeterButton(
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
            MeterButton(
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
            MeterButton(
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(30.0),
          content: Text(
            sprintf(AppLocalizations.of(context)!.meter_dialog_stop_content, [NumberFormat("#,##0").format(widget.meterUtil.meterCost), NumberFormat("#,##0.0").format(widget.meterUtil.meterSumDistance / 1000)]),
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
            sprintf(AppLocalizations.of(context)!.meter_cost, [NumberFormat("#,##0").format(widget.meterUtil.meterCost)]),
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
        case CostMode.COST_BASE: meterCostMode = AppLocalizations.of(context)!.meter_info_cost_mode_base;
        case CostMode.COST_DISTANCE: meterCostMode = AppLocalizations.of(context)!.meter_info_cost_mode_distance;
        case CostMode.COST_TIME: meterCostMode = AppLocalizations.of(context)!.meter_info_cost_mode_time;
      }

      switch(widget.meterUtil.meterStatus) {
        case MeterStatus.METER_GPS_ERROR: meterStatus = AppLocalizations.of(context)!.meter_info_status_gps_error;
        case MeterStatus.METER_NOT_RUNNING: meterStatus = AppLocalizations.of(context)!.meter_info_status_not_running;
        case MeterStatus.METER_RUNNING: meterStatus = AppLocalizations.of(context)!.meter_info_status_running;
      }

      meterCurSpeed = widget.meterUtil.meterCurSpeed;
      meterSumDistance = widget.meterUtil.meterSumDistance;
    });
  }

  @override
  void initState() {
    super.initState();
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
                      meterInfoText(AppLocalizations.of(context)!.meter_info_cost_mode_title),
                      meterInfoText(meterCostMode),
                      Container(height: 10.0),
                      meterInfoText(AppLocalizations.of(context)!.meter_info_speed_title),
                      meterInfoText(sprintf(AppLocalizations.of(context)!.meter_info_speed_data, [NumberFormat("#,##0.0").format(widget.meterUtil.meterCurSpeed)])),
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
                      meterInfoText(AppLocalizations.of(context)!.meter_info_status_title),
                      meterInfoText(meterStatus),
                      Container(height: 10.0),
                      meterInfoText(AppLocalizations.of(context)!.meter_info_distance_title),
                      meterInfoText(sprintf(AppLocalizations.of(context)!.meter_info_distance_data, [NumberFormat("#,##0.0").format(widget.meterUtil.meterSumDistance / 1000)])),
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
                  textAlign: TextAlign.center,
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