import 'package:flutter/material.dart';
import 'package:taximeter/pages/donation_page.dart';
import 'package:taximeter/pages/main_page.dart';
import 'package:taximeter/pages/setting_page.dart';

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
  int _pageIndex = 1;
  final _pageList = [
    const SettingPage(),
    const MainPage(),
    const DonationPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pageList[_pageIndex]
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.money),
            label: 'Donation',
          ),
        ],
        selectedIndex: _pageIndex,
        onDestinationSelected: _onBottomNavBarTapped,
      ),
    );
  }

  void _onBottomNavBarTapped(int idx){
    setState(() {
      _pageIndex = idx;
    });
  }
}
