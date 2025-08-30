import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart' deferred as app_localizations_en;
import 'app_localizations_ko.dart' deferred as app_localizations_ko;

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko')
  ];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Taxi Meter'**
  String get app_title;

  /// No description provided for @donation_btn_ad_remove.
  ///
  /// In en, this message translates to:
  /// **'Ad Remove'**
  String get donation_btn_ad_remove;

  /// No description provided for @donation_btn_donate_1000.
  ///
  /// In en, this message translates to:
  /// **'Buy a coke'**
  String get donation_btn_donate_1000;

  /// No description provided for @donation_btn_donate_5000.
  ///
  /// In en, this message translates to:
  /// **'Buy a coffee'**
  String get donation_btn_donate_5000;

  /// No description provided for @donation_btn_donate_10000.
  ///
  /// In en, this message translates to:
  /// **'Buy a BigMac'**
  String get donation_btn_donate_10000;

  /// No description provided for @donation_btn_donate_50000.
  ///
  /// In en, this message translates to:
  /// **'Buy a Dinner'**
  String get donation_btn_donate_50000;

  /// No description provided for @donation_btn_restore.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase'**
  String get donation_btn_restore;

  /// No description provided for @donation_info_text.
  ///
  /// In en, this message translates to:
  /// **'Purchase Items except Advertise Remove are donation for Developer.\nIf you want to get refund, read Appstore Detail Page and send me an E-mail\n'**
  String get donation_info_text;

  /// No description provided for @donation_error_connect.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect with Appstore'**
  String get donation_error_connect;

  /// No description provided for @donation_error_process.
  ///
  /// In en, this message translates to:
  /// **'Failed to process purchase'**
  String get donation_error_process;

  /// No description provided for @donation_purchase_done.
  ///
  /// In en, this message translates to:
  /// **'Thanks for purchasing!'**
  String get donation_purchase_done;

  /// No description provided for @donation_restore_done.
  ///
  /// In en, this message translates to:
  /// **'Restored old purchases'**
  String get donation_restore_done;

  /// No description provided for @nav_donation.
  ///
  /// In en, this message translates to:
  /// **'Donation'**
  String get nav_donation;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get nav_setting;

  /// No description provided for @main_snack_gps_error.
  ///
  /// In en, this message translates to:
  /// **'Location Service is disabled. Please enable it.'**
  String get main_snack_gps_error;

  /// No description provided for @main_snack_permission_error.
  ///
  /// In en, this message translates to:
  /// **'Location Permission is denied. Please grant at System Settings.'**
  String get main_snack_permission_error;

  /// No description provided for @main_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Touch to Start'**
  String get main_subtitle;

  /// No description provided for @main_title_meter.
  ///
  /// In en, this message translates to:
  /// **'Meter'**
  String get main_title_meter;

  /// No description provided for @main_title_taxi.
  ///
  /// In en, this message translates to:
  /// **'Taxi'**
  String get main_title_taxi;

  /// No description provided for @meter_btn_percentage_night_false.
  ///
  /// In en, this message translates to:
  /// **'Night Percentage OFF'**
  String get meter_btn_percentage_night_false;

  /// No description provided for @meter_btn_percentage_night_true.
  ///
  /// In en, this message translates to:
  /// **'Night Percentage ON'**
  String get meter_btn_percentage_night_true;

  /// No description provided for @meter_btn_percentage_outcity_false.
  ///
  /// In en, this message translates to:
  /// **'Outcity Percentage OFF'**
  String get meter_btn_percentage_outcity_false;

  /// No description provided for @meter_btn_percentage_outcity_true.
  ///
  /// In en, this message translates to:
  /// **'Outcity Percentage ON'**
  String get meter_btn_percentage_outcity_true;

  /// No description provided for @meter_btn_start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get meter_btn_start;

  /// No description provided for @meter_btn_stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get meter_btn_stop;

  /// No description provided for @meter_cost.
  ///
  /// In en, this message translates to:
  /// **'₩%s'**
  String get meter_cost;

  /// No description provided for @meter_dialog_exit_content.
  ///
  /// In en, this message translates to:
  /// **'Meter will be stopped when exit.'**
  String get meter_dialog_exit_content;

  /// No description provided for @meter_dialog_exit_no.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get meter_dialog_exit_no;

  /// No description provided for @meter_dialog_exit_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get meter_dialog_exit_ok;

  /// No description provided for @meter_dialog_stop_content.
  ///
  /// In en, this message translates to:
  /// **'Cost: KRW %s\nDistance: %skm'**
  String get meter_dialog_stop_content;

  /// No description provided for @meter_dialog_stop_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get meter_dialog_stop_ok;

  /// No description provided for @meter_dialog_stop_title.
  ///
  /// In en, this message translates to:
  /// **'Finish Driving'**
  String get meter_dialog_stop_title;

  /// No description provided for @meter_info_cost_mode_base.
  ///
  /// In en, this message translates to:
  /// **'Base Cost'**
  String get meter_info_cost_mode_base;

  /// No description provided for @meter_info_cost_mode_distance.
  ///
  /// In en, this message translates to:
  /// **'Cost per Distance'**
  String get meter_info_cost_mode_distance;

  /// No description provided for @meter_info_cost_mode_time.
  ///
  /// In en, this message translates to:
  /// **'Cost per Time'**
  String get meter_info_cost_mode_time;

  /// No description provided for @meter_info_cost_mode_title.
  ///
  /// In en, this message translates to:
  /// **'Cost Mode'**
  String get meter_info_cost_mode_title;

  /// No description provided for @meter_info_distance_data.
  ///
  /// In en, this message translates to:
  /// **'%skm'**
  String get meter_info_distance_data;

  /// No description provided for @meter_info_distance_title.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get meter_info_distance_title;

  /// No description provided for @meter_info_speed_data.
  ///
  /// In en, this message translates to:
  /// **'%skm/h'**
  String get meter_info_speed_data;

  /// No description provided for @meter_info_speed_title.
  ///
  /// In en, this message translates to:
  /// **'Current Speed'**
  String get meter_info_speed_title;

  /// No description provided for @meter_info_status_gps_error.
  ///
  /// In en, this message translates to:
  /// **'Waiting for GPS...'**
  String get meter_info_status_gps_error;

  /// No description provided for @meter_info_status_not_running.
  ///
  /// In en, this message translates to:
  /// **'Not Running'**
  String get meter_info_status_not_running;

  /// No description provided for @meter_info_status_running.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get meter_info_status_running;

  /// No description provided for @meter_info_status_title.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get meter_info_status_title;

  /// No description provided for @meter_noti_gps_channel.
  ///
  /// In en, this message translates to:
  /// **'Background Running Notification'**
  String get meter_noti_gps_channel;

  /// No description provided for @meter_noti_gps_text.
  ///
  /// In en, this message translates to:
  /// **'Taxi Meter is running in background'**
  String get meter_noti_gps_text;

  /// No description provided for @meter_noti_gps_title.
  ///
  /// In en, this message translates to:
  /// **'Taxi Meter'**
  String get meter_noti_gps_title;

  /// No description provided for @meter_snack_percentage_night.
  ///
  /// In en, this message translates to:
  /// **'Night Percentage will be applied at Setted Time'**
  String get meter_snack_percentage_night;

  /// No description provided for @meter_snack_warning_location_accuracy.
  ///
  /// In en, this message translates to:
  /// **'Meter might be unstable because of Non-precise Location Information.'**
  String get meter_snack_warning_location_accuracy;

  /// No description provided for @setting_cost_custom_base.
  ///
  /// In en, this message translates to:
  /// **'Base Cost'**
  String get setting_cost_custom_base;

  /// No description provided for @setting_cost_custom_base_distance.
  ///
  /// In en, this message translates to:
  /// **'Distance for Base Cost'**
  String get setting_cost_custom_base_distance;

  /// No description provided for @setting_cost_custom_per_distance.
  ///
  /// In en, this message translates to:
  /// **'Cost per Distance (m)'**
  String get setting_cost_custom_per_distance;

  /// No description provided for @setting_cost_custom_per_time.
  ///
  /// In en, this message translates to:
  /// **'Cost per Time (s)'**
  String get setting_cost_custom_per_time;

  /// No description provided for @setting_cost_custom_percentage_night.
  ///
  /// In en, this message translates to:
  /// **'Percentage for Night'**
  String get setting_cost_custom_percentage_night;

  /// No description provided for @setting_cost_custom_percentage_night_end.
  ///
  /// In en, this message translates to:
  /// **'Percentage for Night End (24-H)'**
  String get setting_cost_custom_percentage_night_end;

  /// No description provided for @setting_cost_custom_percentage_night_start.
  ///
  /// In en, this message translates to:
  /// **'Percentage for Night Start (24-H)'**
  String get setting_cost_custom_percentage_night_start;

  /// No description provided for @setting_cost_custom_percentage_outcity.
  ///
  /// In en, this message translates to:
  /// **'Percentage for Outcity'**
  String get setting_cost_custom_percentage_outcity;

  /// No description provided for @setting_cost_info_1.
  ///
  /// In en, this message translates to:
  /// **'Base: KRW %s (First %skm)\nCost per Distance: KRW 100 per %sm\nCost per Time: KRW 100 per %ss\nOutcity Percentage: %s%%\nNight Percentace\n- %s%% (%d:00 ~ %d:00)'**
  String get setting_cost_info_1;

  /// No description provided for @setting_cost_info_2.
  ///
  /// In en, this message translates to:
  /// **'Base: KRW %s (First %skm)\nCost per Distance: KRW 100 per %sm\nCost per Time: KRW 100 per %ss\nOutcity Percentage: %s%%\nNight Percentace\n- %s%% (%d:00 ~ %d:00)\n- %s%% (%d:00 ~ %d:00)'**
  String get setting_cost_info_2;

  /// No description provided for @setting_developer_blog.
  ///
  /// In en, this message translates to:
  /// **'Developer Blog'**
  String get setting_developer_blog;

  /// No description provided for @setting_developer_github.
  ///
  /// In en, this message translates to:
  /// **'Developer GitHub'**
  String get setting_developer_github;

  /// No description provided for @setting_developer_instagram.
  ///
  /// In en, this message translates to:
  /// **'Developer Instagram'**
  String get setting_developer_instagram;

  /// No description provided for @setting_developer_nickname.
  ///
  /// In en, this message translates to:
  /// **'Dev. LR'**
  String get setting_developer_nickname;

  /// No description provided for @setting_developer_university.
  ///
  /// In en, this message translates to:
  /// **'Chung-Ang University Dept. Software since 2019'**
  String get setting_developer_university;

  /// No description provided for @setting_dialog_cost_custom_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get setting_dialog_cost_custom_save;

  /// No description provided for @setting_dialog_cost_custom_save_error.
  ///
  /// In en, this message translates to:
  /// **'Invalid Data Included.'**
  String get setting_dialog_cost_custom_save_error;

  /// No description provided for @setting_dialog_cost_custom_title.
  ///
  /// In en, this message translates to:
  /// **'Custom Cost Info'**
  String get setting_dialog_cost_custom_title;

  /// No description provided for @setting_dialog_location_title.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get setting_dialog_location_title;

  /// No description provided for @setting_dialog_theme_title.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get setting_dialog_theme_title;

  /// No description provided for @setting_info_cost.
  ///
  /// In en, this message translates to:
  /// **'Cost Info'**
  String get setting_info_cost;

  /// No description provided for @setting_info_cost_db.
  ///
  /// In en, this message translates to:
  /// **'Cost Info DB Version'**
  String get setting_info_cost_db;

  /// No description provided for @setting_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get setting_privacy_policy;

  /// No description provided for @setting_setup_location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get setting_setup_location;

  /// No description provided for @setting_setup_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get setting_setup_theme;

  /// No description provided for @setting_title_developer.
  ///
  /// In en, this message translates to:
  /// **'Developer Info'**
  String get setting_title_developer;

  /// No description provided for @setting_title_info.
  ///
  /// In en, this message translates to:
  /// **'Meter Info'**
  String get setting_title_info;

  /// No description provided for @setting_title_setup.
  ///
  /// In en, this message translates to:
  /// **'Meter Setup'**
  String get setting_title_setup;

  /// No description provided for @welcome_btn_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get welcome_btn_done;

  /// No description provided for @welcome_btn_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get welcome_btn_next;

  /// No description provided for @welcome_info_gps_text.
  ///
  /// In en, this message translates to:
  /// **'Meter function depends on Realtime GPS Information. If inside building or tunnel, meter might stopped. Please check whether Location Permission is granted properly.'**
  String get welcome_info_gps_text;

  /// No description provided for @welcome_info_location_text.
  ///
  /// In en, this message translates to:
  /// **'You can choose location for taxi cost at Setting Menu inside application. Major cities in South Korea are supported, and you can even custom your own cost info.'**
  String get welcome_info_location_text;

  /// No description provided for @welcome_info_warning_text.
  ///
  /// In en, this message translates to:
  /// **'!! Warning !!\nReceiving money using this application may be punished under the laws of the Republic of Korea.'**
  String get welcome_info_warning_text;

  /// No description provided for @welcome_init_text.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Taxi Meter!\nBefore start using, some setup must be done.\nPress Next button to start setup.'**
  String get welcome_init_text;

  /// No description provided for @welcome_permission_btn.
  ///
  /// In en, this message translates to:
  /// **'Grant Location Permission'**
  String get welcome_permission_btn;

  /// No description provided for @welcome_permission_btn_done.
  ///
  /// In en, this message translates to:
  /// **'Already Granted'**
  String get welcome_permission_btn_done;

  /// No description provided for @welcome_permission_text.
  ///
  /// In en, this message translates to:
  /// **'Taxi Meter function works based on Current Driving Information from GPS. So location permission must be granted for Taxi Meter.\nIf not, application cannot access to GPS so Meter function cannot work.'**
  String get welcome_permission_text;

  /// No description provided for @welcome_snack_permission_not_granted.
  ///
  /// In en, this message translates to:
  /// **'Location permission is not granted yet'**
  String get welcome_snack_permission_not_granted;

  /// No description provided for @welcome_snack_permission_error_retry.
  ///
  /// In en, this message translates to:
  /// **'Location permission is not granted. Please Retry.'**
  String get welcome_snack_permission_error_retry;

  /// No description provided for @welcome_snack_permission_error_setting.
  ///
  /// In en, this message translates to:
  /// **'Location permission is PERMANENTLY not granted. Goto System Settings for grant.'**
  String get welcome_snack_permission_error_setting;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return lookupAppLocalizations(locale);
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

Future<AppLocalizations> lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return app_localizations_en
          .loadLibrary()
          .then((dynamic _) => app_localizations_en.AppLocalizationsEn());
    case 'ko':
      return app_localizations_ko
          .loadLibrary()
          .then((dynamic _) => app_localizations_ko.AppLocalizationsKo());
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
