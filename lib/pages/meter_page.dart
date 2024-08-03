import 'package:flutter/material.dart';

class MeterPage extends StatelessWidget {
  const MeterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child:
        Center(
          child: Column(
            children: [
              Text("Meter Page")
            ],
          ),
        )
      )
    );
  }
}