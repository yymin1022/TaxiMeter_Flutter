import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taximeter/utils/color_util.dart';
import 'package:taximeter/utils/firebase_util.dart';
import 'package:taximeter/utils/preference_util.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _welcomeIdx = 0;
  late final List<Widget> _welcomePages = [
    WelcomePageInit(goNext: goNext),
    WelcomePagePermission(goNext: goNext),
    WelcomePageLocation(goNext: goNext),
  ];

  @override
  void initState() {
    super.initState();
    FirebaseUtil().logAnalytics("enter_welcome_page", null);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: _welcomePages[_welcomeIdx]
            ),
          ),
        ),
      ),
    );
  }

  void goNext() {
    setState(() {
      if(_welcomeIdx == 2 && mounted) {
        PreferenceUtil().setPrefsValue("is_setup_done", true)
          .then((res) => Navigator.of(context).pop());
      } else {
        _welcomeIdx++;
      }
    });
  }
}

class WelcomePageInit extends StatefulWidget {
  const WelcomePageInit({super.key, required this.goNext});

  final Function goNext;

  @override
  State<StatefulWidget> createState() => _WelcomePageInitState();
}

class _WelcomePageInitState extends State<WelcomePageInit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.local_taxi,
            size: 100.0,
          ),
          const SizedBox(height: 20.0),
          Text(
            AppLocalizations.of(context)!.welcome_init_text,
            style: const TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          OutlinedButton(
            onPressed: () { widget.goNext(); },
            child: Text(AppLocalizations.of(context)!.welcome_btn_next),
          ),
        ],
      ),
    );
  }
}

class WelcomePageLocation extends StatefulWidget {
  const WelcomePageLocation({super.key, required this.goNext});

  final Function goNext;

  @override
  State<StatefulWidget> createState() => _WelcomePageLocationState();
}

class _WelcomePageLocationState extends State<WelcomePageLocation> {
  @override
  void initState() {
    super.initState();

    FirebaseUtil().initFirebase()
      .then((res) => FirebaseUtil().updateCostInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.checklist,
            size: 100.0,
          ),
          const SizedBox(height: 20.0),
          Text(
            AppLocalizations.of(context)!.welcome_info_warning_text,
            style: const TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30.0),
          Text(
            AppLocalizations.of(context)!.welcome_info_location_text,
            style: const TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30.0),
          Text(
            AppLocalizations.of(context)!.welcome_info_gps_text,
            style: const TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30.0),
          OutlinedButton(
            onPressed: () { widget.goNext(); },
            child: Text(AppLocalizations.of(context)!.welcome_btn_done),
          ),
        ],
      ),
    );
  }
}

class WelcomePagePermission extends StatefulWidget {
  const WelcomePagePermission({super.key, required this.goNext});

  final Function goNext;

  @override
  State<StatefulWidget> createState() => _WelcomePagePermissionState();
}

class _WelcomePagePermissionState extends State<WelcomePagePermission> {
  bool isTriedGrant = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.gps_fixed,
            size: 100.0,
          ),
          const SizedBox(height: 20.0),
          Text(
            AppLocalizations.of(context)!.welcome_permission_text,
            style: const TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          OutlinedButton(
            onPressed: () {
              if(!isTriedGrant) {
                requestPermissions().then(
                  (res) => setState(() {
                    isTriedGrant = true;
                  })
                );
              } else {
                widget.goNext();
              }
            },
            child: Text(
              AppLocalizations.of(context)!.welcome_btn_next,
              style: const TextStyle(
                color: MeterColor.btnTextEnabled
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> requestPermissions() async {
    LocationPermission permissionResult = await Geolocator.requestPermission();

    if(permissionResult == LocationPermission.deniedForever && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.welcome_snack_permission_error_setting),
          duration: const Duration(seconds: 2),
        )
      );
      return false;
    } else if(permissionResult == LocationPermission.denied && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.welcome_snack_permission_error_retry),
          duration: const Duration(seconds: 2),
        )
      );
      return false;
    }

    return true;
  }
}