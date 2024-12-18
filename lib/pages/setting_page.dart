import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sprintf/sprintf.dart';
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
            SettingListTitle(AppLocalizations.of(context)!.setting_title_setup),
            ListTile(
              title: Text(AppLocalizations.of(context)!.setting_setup_location),
              subtitle: Text(Localizations.localeOf(context) == const Locale("ko")
                  ? SettingsDataLocation.getName(curLocation).ko
                  : SettingsDataLocation.getName(curLocation).en),
              onTap: (){
                _showLocationDialog();
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.setting_setup_theme),
              subtitle: Text(Localizations.localeOf(context) == const Locale("ko")
                  ? SettingsDataTheme.getName(curTheme).ko
                  : SettingsDataTheme.getName(curTheme).en),
              onTap: (){
                _showThemeDialog();
              },
            ),
            SettingListTitle(AppLocalizations.of(context)!.setting_title_info),
            ListTile(
              title: Text(AppLocalizations.of(context)!.setting_info_cost),
              subtitle: Text(_getCostInfoText()),
              onTap: (){},
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.setting_info_cost_db),
              subtitle: Text(curCostVersion),
              onTap: (){},
            ),
            SettingListTitle(AppLocalizations.of(context)!.setting_title_developer),
            ListTile(
              title: Text(AppLocalizations.of(context)!.setting_developer_nickname),
              subtitle: Text(AppLocalizations.of(context)!.setting_developer_university),
              onTap: (){},
            ),
            SettingListWebItem(AppLocalizations.of(context)!.setting_developer_blog, "https://dev-lr.com"),
            SettingListWebItem(AppLocalizations.of(context)!.setting_developer_github, "https://github.com/yymin1022"),
            SettingListWebItem(AppLocalizations.of(context)!.setting_developer_instagram, "https://instagram.com/useful_min"),
            SettingListWebItem(AppLocalizations.of(context)!.setting_privacy_policy, "https://defcon.or.kr/privacy"),
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
    return sprintf(
      percNight1 == percNight2
        ? AppLocalizations.of(context)!.setting_cost_info_1
        : AppLocalizations.of(context)!.setting_cost_info_2,
        [
          costBase,
          distBase / 1000,
          costRunPer,
          costTimePer,
          percCity,
          percNight1,
          percNightStart1,
          percNightEnd1,
          percNight2,
          percNightStart2,
          percNightEnd2
        ]);
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
          title: Text(AppLocalizations.of(context)!.setting_dialog_cost_custom_title),
          contentPadding: const EdgeInsets.all(20.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: inputControllerCostBase,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.setting_cost_custom_base
                  ),
                ),
                TextField(
                  controller: inputControllerCostRunPer,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.setting_cost_custom_per_distance
                  ),
                ),
                TextField(
                  controller: inputControllerCostTimePer,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.setting_cost_custom_per_time
                  ),
                ),
                TextField(
                  controller: inputControllerDistBase,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.setting_cost_custom_base_distance
                  ),
                ),
                TextField(
                  controller: inputControllerPercCity,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.setting_cost_custom_percentage_outcity
                  ),
                ),
                TextField(
                  controller: inputControllerPercNight,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.setting_cost_custom_percentage_night
                  ),
                ),
                TextField(
                  controller: inputControllerPercNightStart,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.setting_cost_custom_percentage_night_start
                  ),
                ),
                TextField(
                  controller: inputControllerPercNightEnd,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.setting_cost_custom_percentage_night_end
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                ElevatedButton(
                  child: Text(AppLocalizations.of(context)!.setting_dialog_cost_custom_save),
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
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!.setting_dialog_cost_custom_save_error),
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
          title: Text(AppLocalizations.of(context)!.setting_dialog_location_title),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
          content: SingleChildScrollView(
            child: ListBody(
              children: SettingsDataLocation.values.map((data) {
                return RadioListTile(
                  title: Text(
                    Localizations.localeOf(context) == const Locale("ko")
                      ? data.ko
                      : data.en),
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
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_dist_base") ?? 1600,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_perc_city") ?? 20,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_perc_night_1") ?? 20,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_perc_night_2") ?? 40,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_perc_night_start_1") ?? 22,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_perc_night_start_2") ?? 23,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_perc_night_end_1") ?? 4,
                          await prefUtil.getPrefsValueI("pref_cost_${data.code}_perc_night_end_2") ?? 2);
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
          title: Text(AppLocalizations.of(context)!.setting_dialog_theme_title),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
          content: SingleChildScrollView(
            child: ListBody(
              children: SettingsDataTheme.values.map((data) {
                return RadioListTile(
                  title: Text(
                    Localizations.localeOf(context) == const Locale("ko")
                      ? data.ko
                      : data.en),
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