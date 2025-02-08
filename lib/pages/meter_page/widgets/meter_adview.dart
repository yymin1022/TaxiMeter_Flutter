import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taximeter/cauly/ad_containers.dart';
import 'package:taximeter/cauly/ad_listeners.dart';

class MeterAdview extends StatefulWidget {
  const MeterAdview({super.key});

  @override
  State<StatefulWidget> createState() => _MeterAdviewState();
}

class _MeterAdviewState extends State<MeterAdview> {
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