import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taximeter/pages/donation_page.dart';
import 'package:taximeter/pages/main_page.dart';
import 'package:taximeter/pages/setting_page.dart';
import 'package:taximeter/utils/firebase_util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseUtil = FirebaseUtil();
  await firebaseUtil.initFirebase();

  if(await firebaseUtil.isUpdateAvail()) {
    firebaseUtil.updateCostInfo();
  }

  runApp(const TaxiMeterApp());
}

class TaxiMeterApp extends StatelessWidget {
  const TaxiMeterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Taxi Meter",
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.nav_setting,
          ),
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.nav_home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.money),
            label: AppLocalizations.of(context)!.nav_donation,
          ),
        ],
        selectedIndex: _pageIndex,
        onDestinationSelected: _onNavBarTapped,
      ),
    );
  }

  void _onNavBarTapped(int idx){
    setState(() {
      _pageIndex = idx;
    });
  }
}
