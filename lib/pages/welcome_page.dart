import 'package:flutter/material.dart';

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
  //TODO: Welcome Message

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { widget.goNext(); },
      child: const Text("Welcome Page 1. Init")
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