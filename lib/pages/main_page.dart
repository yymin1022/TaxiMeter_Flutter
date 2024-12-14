import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taximeter/pages/meter_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: InkWell(
        onTap: (){
          Geolocator.checkPermission()
            .then((res) {
              if(res == LocationPermission.always
                || res == LocationPermission.whileInUse) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const MeterPage();
                  }
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.main_snack_permission_error),
                    duration: const Duration(seconds: 2),
                  )
                );
              }
          });
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.local_taxi,
                size: 224.0
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.main_title_taxi,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                    AppLocalizations.of(context)!.main_title_meter,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 48.0
                    )
                  )
                ],
              ),
              Text(
                AppLocalizations.of(context)!.main_subtitle,
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 24.0
                )
              )
            ],
          ),
        )
      )
    );
  }
}