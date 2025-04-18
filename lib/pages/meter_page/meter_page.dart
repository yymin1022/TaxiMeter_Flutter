import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:taximeter/pages/meter_page/meter_page_landscape.dart";
import "package:taximeter/pages/meter_page/meter_page_portrait.dart";
import "package:taximeter/pages/meter_page/widgets/meter_adview.dart";
import "package:taximeter/utils/color_util.dart";
import "package:taximeter/utils/firebase_util.dart";
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
    FirebaseUtil().logAnalytics("enter_meter_page", null);
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
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
            child: Stack(
              children: [
                OrientationBuilder(
                  builder: (context, orientation) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if(orientation == Orientation.portrait)
                          MeterPagePortrait(meterUtil: meterUtil!, updateCallback: updateMeterView)
                        else
                          MeterPageLandscape(meterUtil: meterUtil!, updateCallback: updateMeterView),
                        isAdRemoval ? const SizedBox.shrink() : const MeterAdview(),
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