import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _welcomeIdx = 0;
  final List<Widget> _welcomePages = const [
    WelcomePageInit(),
    WelcomePagePermission(),
    WelcomePageLocation()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _welcomePages[_welcomeIdx],
      ),
    );
  }
}

class WelcomePageInit extends StatefulWidget {
  const WelcomePageInit({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomePageInitState();
}

class _WelcomePageInitState extends State<WelcomePageInit> {
  //TODO: Welcome Message

  @override
  Widget build(BuildContext context) {
    return const Text("Welcome Page 1. Init");
  }
}

class WelcomePageLocation extends StatefulWidget {
  const WelcomePageLocation({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomePageLocationState();
}

class _WelcomePageLocationState extends State<WelcomePageLocation> {
  //TODO: Warning Text / Location Setup Info

  @override
  Widget build(BuildContext context) {
    return const Text("Welcome Page 3. Location Info");
  }
}

class WelcomePagePermission extends StatefulWidget {
  const WelcomePagePermission({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomePagePermissionState();
}

class _WelcomePagePermissionState extends State<WelcomePagePermission> {
  //TODO: Location Permission

  @override
  Widget build(BuildContext context) {
    return const Text("Welcome Page 2. Permission");
  }
}