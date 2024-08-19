import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    WelcomePageLocation(goNext: goNext)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _welcomePages[_welcomeIdx],
      ),
    );
  }

  void goNext() {
    setState(() {
      if(_welcomeIdx == 2) {
        Navigator.of(context).pop();
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
            child: Text(AppLocalizations.of(context)!.welcome_btn_next)
          )
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
  //TODO: Warning Text / Location Setup Info

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { widget.goNext(); },
      child: const Text("Welcome Page 3. Location Info")
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
  //TODO: Location Permission

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { widget.goNext(); },
      child: const Text("Welcome Page 2. Permission")
    );
  }
}