import 'package:flutter/material.dart';

void main() {
  runApp(const TaxiMeterApp());
}

class TaxiMeterApp extends StatelessWidget {
  const TaxiMeterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Meter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: const TaxiMeterMain(),
    );
  }
}

class TaxiMeterMain extends StatefulWidget {
  const TaxiMeterMain({super.key});

  @override
  State<TaxiMeterMain> createState() => _TaxiMeterMainState();
}

class _TaxiMeterMainState extends State<TaxiMeterMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Taxi Meter"),
          ],
        ),
      ),
    );
  }
}
