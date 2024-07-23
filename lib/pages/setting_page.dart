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
  String? curLocation;
  String? curTheme;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    String prefLocation = await PreferenceUtil().getPrefsValueS("pref_location") ?? "seoul";
    String prefTheme = await PreferenceUtil().getPrefsValueS("pref_theme") ?? "horse";

    setState(() {
      curLocation = prefLocation;
      curTheme = prefTheme;
    });
  }

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
              subtitle: Text(SettingsDataLocation.getName(curLocation ?? "seoul").ko),
              onTap: (){
                _showLocationDialog();
              },
            ),
            ListTile(
              title: Text("미터기 테마"),
              subtitle: Text(SettingsDataTheme.getName(curTheme ?? "horse").ko),
              onTap: (){
                _showThemeDialog();
              },
            ),
            const SettingListTitle("미터기 정보"),
            ListTile(
              title: Text("요금 정보"),
              subtitle: Text("기본요금 : 4800원 (최초 1.6km)"),
              onTap: (){},
            ),
            ListTile(
              title: Text("요금정보 DB 버전"),
              subtitle: Text("20240310"),
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

  void _showLocationDialog() async {
    final PreferenceUtil prefUtil = PreferenceUtil();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("위치"),
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