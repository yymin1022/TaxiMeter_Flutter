import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:taximeter/utils/preference_util.dart';
import 'package:taximeter/utils/settings_data.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String curCostVersion = "20001022";
  String curLocation = "seoul";
  String curTheme = "horse";

  int costBase = 0;
  int costRunPer = 131;
  int costTimePer = 30;
  int distBase = 1600;
  int percCity = 20;
  int percNight1 = 20;
  int percNight2 = 40;
  int percNightEnd1 = 4;
  int percNightEnd2 = 2;
  int percNightStart1 = 22;
  int percNightStart2 = 23;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: ListView(
          children: [
            const SettingListTitle("미터기 설정"),
            ListTile(
              title: Text("위치"),
              subtitle: Text(SettingsDataLocation.getName(curLocation).ko),
              onTap: (){
                _showLocationDialog();
              },
            ),
            ListTile(
              title: Text("미터기 테마"),
              subtitle: Text(SettingsDataTheme.getName(curTheme).ko),
              onTap: (){
                _showThemeDialog();
              },
            ),
            const SettingListTitle("미터기 정보"),
            ListTile(
              title: Text("요금 정보"),
              subtitle: Text(_getCostInfoText()),
              onTap: (){},
            ),
            ListTile(
              title: Text("요금정보 DB 버전"),
              subtitle: Text(curCostVersion),
              onTap: (){},
            ),
            const SettingListTitle("개발자 정보"),
            ListTile(
              title: Text("Dev. LR"),
              subtitle: Text("중앙대학교 소프트웨어학부 2019"),
              onTap: (){},
            ),
            const SettingListWebItem("개발자 블로그", "https://dev-lr.com"),
            const SettingListWebItem("개발자 GitHub", "https://github.com/yymin1022"),
            const SettingListWebItem("개발자 Instagram", "https://instagram.com/useful_min"),
            const SettingListWebItem("개인정보 처리방침", "https://defcon.or.kr/privacy")
          ],
        ),
      )
    );
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    String prefCostVersion = await PreferenceUtil().getPrefsValueS("pref_cost_version") ?? "20001022";
    String prefLocation = await PreferenceUtil().getPrefsValueS("pref_location") ?? "seoul";
    String prefTheme = await PreferenceUtil().getPrefsValueS("pref_theme") ?? "horse";

    int prefCostBase = await PreferenceUtil().getPrefsValueI("pref_cost_base") ?? 0;
    int prefCostRunPer = await PreferenceUtil().getPrefsValueI("pref_cost_run_per") ?? 131;
    int prefCostTimePer = await PreferenceUtil().getPrefsValueI("pref_cost_time_per") ?? 30;
    int prefDistBase = await PreferenceUtil().getPrefsValueI("pref_dist_base") ?? 1600;
    int prefPercCity = await PreferenceUtil().getPrefsValueI("pref_perc_city") ?? 20;
    int prefPercNight1 = await PreferenceUtil().getPrefsValueI("pref_perc_night_1") ?? 20;
    int prefPercNight2 = await PreferenceUtil().getPrefsValueI("pref_perc_night_2") ?? 40;
    int prefPercNightEnd1 = await PreferenceUtil().getPrefsValueI("pref_perc_night_end_1") ?? 4;
    int prefPercNightEnd2 = await PreferenceUtil().getPrefsValueI("pref_perc_night_end_2") ?? 2;
    int prefPercNightStart1 = await PreferenceUtil().getPrefsValueI("pref_perc_night_start_1") ?? 22;
    int prefPercNightStart2 = await PreferenceUtil().getPrefsValueI("pref_perc_night_start_2") ?? 23;

    setState(() {
      curCostVersion = prefCostVersion;
      curLocation = prefLocation;
      curTheme = prefTheme;

      costBase = prefCostBase;
      costRunPer = prefCostRunPer;
      costTimePer = prefCostTimePer;
      distBase = prefDistBase;
      percCity = prefPercCity;
      percNight1 = prefPercNight1;
      percNight2 = prefPercNight2;
      percNightEnd1 = prefPercNightEnd1;
      percNightEnd2 = prefPercNightEnd2;
      percNightStart1 = prefPercNightStart1;
      percNightStart2 = prefPercNightStart2;
    });
  }

  String _getCostInfoText() {
    if(percNight1 == percNight2) {
      return "기본요금 : $costBase원 (최초 ${distBase / 1000}km)\n거리요금 $costRunPer당 100원\n시간요금 $costTimePer초당 100원\n"
          "시외할증 $percCity%\n야간할증\n - $percNight1% ($percNightStart1:00 ~ $percNightEnd1:00)";
    } else {
      return "기본요금 : $costBase원 (최초 ${distBase / 1000}km)\n거리요금 $costRunPer당 100원\n시간요금 $costTimePer초당 100원\n"
          "시외할증 $percCity%\n야간할증\n - $percNight1% ($percNightStart1:00 ~ $percNightEnd1:00)\n - $percNight2% ($percNightStart2:00 ~ $percNightEnd2:00)";
    }
  }

  void _showLocationDialog() async {
    final PreferenceUtil prefUtil = PreferenceUtil();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("위치"),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
          content: SingleChildScrollView(
            child: ListBody(
              children: SettingsDataLocation.values.map((data) {
                return RadioListTile(
                  title: Text(data.ko),
                  groupValue: curLocation,
                  value: data.code,
                  onChanged: (value) {
                    prefUtil.setPrefsValue("pref_location", data.code);
                    setState(() {
                      curLocation = data.code;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList() as List<Widget>
            ),
          ),
        );
      },
    );
  }

  void _showThemeDialog() async {
    final prefUtil = PreferenceUtil();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("미터기 테마"),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
          content: SingleChildScrollView(
            child: ListBody(
              children: SettingsDataTheme.values.map((data) {
                return RadioListTile(
                  title: Text(data.ko),
                  groupValue: curTheme,
                  value: data.code,
                  onChanged: (value) {
                    prefUtil.setPrefsValue("pref_theme", data.code);
                    setState(() {
                      curTheme = data.code;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList() as List<Widget>
            ),
          ),
        );
      },
    );
  }
}

class SettingListTitle extends StatelessWidget {
  const SettingListTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
      child: Text(text,
        style: const TextStyle(
          color: Colors.black38,
          fontSize: 15.0
        )
      )
    );
  }
}

class SettingListWebItem extends StatelessWidget {
  const SettingListWebItem(this.title, this.url, {super.key});
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(url),
      onTap: () async {
        await launchUrl(Uri.parse(url));
      },
    );
  }
}