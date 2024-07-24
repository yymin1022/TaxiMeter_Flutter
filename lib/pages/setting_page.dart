import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  int costBase = 4800;
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

    int prefCostBase = await PreferenceUtil().getPrefsValueI("pref_cost_base") ?? 4800;
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

  void _setPrefCostData(String location,
      int inputCostBase, int inputCostRunPer, int inputCostTimePer, int inputDistBase,
      int inputPercCity, int inputPercNight1, int inputPercNight2,
      int inputPercNightStart1, int inputPercNightStart2,
      int inputPercNightEnd1, int inputPercNightEnd2) {
    final PreferenceUtil prefUtil = PreferenceUtil();

    prefUtil.setPrefsValue("pref_cost_base", inputCostBase);
    prefUtil.setPrefsValue("pref_cost_run_per", inputCostRunPer);
    prefUtil.setPrefsValue("pref_cost_time_per", inputCostTimePer);
    prefUtil.setPrefsValue("pref_dist_base", inputDistBase);
    prefUtil.setPrefsValue("pref_perc_city", inputPercCity);
    prefUtil.setPrefsValue("pref_perc_night_1", inputPercNight1);
    prefUtil.setPrefsValue("pref_perc_night_2", inputPercNight2);
    prefUtil.setPrefsValue("pref_perc_night_start_1", inputPercNightStart1);
    prefUtil.setPrefsValue("pref_perc_night_start_2", inputPercNightStart2);
    prefUtil.setPrefsValue("pref_perc_night_end_1", inputPercNightEnd1);
    prefUtil.setPrefsValue("pref_perc_night_end_2", inputPercNightEnd2);
    prefUtil.setPrefsValue("pref_location", location);
    didChangeDependencies();
  }

  void _showCustomCostDialog() async {
    final inputControllerCostBase = TextEditingController();
    final inputControllerCostRunPer = TextEditingController();
    final inputControllerCostTimePer = TextEditingController();
    final inputControllerDistBase = TextEditingController();
    final inputControllerPercCity = TextEditingController();
    final inputControllerPercNight = TextEditingController();
    final inputControllerPercNightStart = TextEditingController();
    final inputControllerPercNightEnd = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("요금정보 직접 설정"),
          contentPadding: const EdgeInsets.all(20.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: inputControllerCostBase,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "기본요금"
                  ),
                ),
                TextField(
                  controller: inputControllerCostRunPer,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "거리요금 기준 거리 (미터)"
                  ),
                ),
                TextField(
                  controller: inputControllerCostTimePer,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "거리요금 기준 시간 (초)"
                  ),
                ),
                TextField(
                  controller: inputControllerDistBase,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "기본요금 주행 거리 (미터)"
                  ),
                ),
                TextField(
                  controller: inputControllerPercCity,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "시외할증 비율"
                  ),
                ),
                TextField(
                  controller: inputControllerPercNight,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "야간할증 비율"
                  ),
                ),
                TextField(
                  controller: inputControllerPercNightStart,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "야간할증 시작 (24시간 단위)"
                  ),
                ),
                TextField(
                  controller: inputControllerPercNightEnd,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "야간할증 종료 (24시간 단위)"
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                ElevatedButton(
                  child: Text("저장"),
                  onPressed: () {
                    Navigator.of(context).pop();

                    try {
                      int inputCostBase = int.parse(inputControllerCostBase.text);
                      int inputCostRunPer = int.parse(inputControllerCostRunPer.text);
                      int inputCostTimePer = int.parse(inputControllerCostTimePer.text);
                      int inputDistBase = int.parse(inputControllerDistBase.text);
                      int inputPercCity = int.parse(inputControllerPercCity.text);
                      int inputPercNight = int.parse(inputControllerPercNight.text);
                      int inputPercNightStart = int.parse(inputControllerPercNightStart.text);
                      int inputPercNightEnd = int.parse(inputControllerPercNightEnd.text);

                      _setPrefCostData("custom",
                          inputCostBase, inputCostRunPer, inputCostTimePer, inputDistBase,
                          inputPercCity, inputPercNight, inputPercNight,
                          inputPercNightStart, inputPercNightStart,
                          inputPercNightEnd, inputPercNightEnd);
                    } catch(e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("입력한 정보가 올바르지 않습니다."),
                        )
                      );
                    }
                  },
                )
              ]
            ),
          ),
        );
      },
    );
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
                  onChanged: (value) async {
                    Navigator.of(context).pop();
                    if(value == "custom") {
                      _showCustomCostDialog();
                    } else {
                      prefUtil.setPrefsValue("pref_location", data.code);
                      _setPrefCostData(data.code,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_cost_base") ?? 4800,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_cost_run_per") ?? 131,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_cost_time_per") ?? 30,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_cost_dist_base") ?? 1600,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_cost_perc_city") ?? 20,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_cost_perc_night_1") ?? 20,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_cost_perc_night_2") ?? 40,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_cost_perc_night_start_1") ?? 22,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_cost_perc_night_start_2") ?? 23,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_cost_perc_night_end_1") ?? 4,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_cost_perc_night_end_2") ?? 2);
                    }
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
                    didChangeDependencies();
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