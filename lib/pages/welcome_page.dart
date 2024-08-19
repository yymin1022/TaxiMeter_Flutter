import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text("Welcome Page"),
      ),
    );
  }
}