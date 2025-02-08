import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:intl/intl.dart";
import "package:sprintf/sprintf.dart";
import "package:taximeter/cauly/cauly.dart";
import "package:taximeter/pages/meter_page/widgets/meter_animation.dart";
import "package:taximeter/pages/meter_page/widgets/meter_control.dart";
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
        if(Platform.isAndroid
            && !res && context.mounted
            && await _showExitDialog() == true) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: MeterColor.meterBackground,
        body: SafeArea(
          child: Stack(
            children: [
              OrientationBuilder(
                builder: (context, orientation) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MeterAnimation(meterUtil: meterUtil!),
                      MeterCostView(meterUtil: meterUtil!),
                      MeterInfo(meterUtil: meterUtil!),
                      MeterControl(meterUtil: meterUtil!, updateCallback: updateMeterView),
                      isAdRemoval ? const SizedBox.shrink() : const MeterAdvertisement(),
                    ],
                  );
                }
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: MeterColor.meterTextColorWhite,
                ),
                onPressed: () async {
                  if(context.mounted
                      && await _showExitDialog() == true) {
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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