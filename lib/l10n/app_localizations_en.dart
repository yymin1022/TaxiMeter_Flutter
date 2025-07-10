// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'Taxi Meter';

  @override
  String get donation_btn_ad_remove => 'Ad Remove';

  @override
  String get donation_btn_donate_1000 => 'Buy a coke';

  @override
  String get donation_btn_donate_5000 => 'Buy a coffee';

  @override
  String get donation_btn_donate_10000 => 'Buy a BigMac';

  @override
  String get donation_btn_donate_50000 => 'Buy a Dinner';

  @override
  String get donation_btn_restore => 'Restore Purchase';

  @override
  String get donation_info_text =>
      'Purchase Items except Advertise Remove are donation for Developer.\nIf you want to get refund, read Appstore Detail Page and send me an E-mail\n';

  @override
  String get donation_error_connect => 'Failed to connect with Appstore';

  @override
  String get donation_error_process => 'Failed to process purchase';

  @override
  String get donation_purchase_done => 'Thanks for purchasing!';

  @override
  String get donation_restore_done => 'Restored old purchases';

  @override
  String get nav_donation => 'Donation';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_setting => 'Setting';

  @override
  String get main_snack_gps_error =>
      'Location Service is disabled. Please enable it.';

  @override
  String get main_snack_permission_error =>
      'Location Permission is denied. Please grant at System Settings.';

  @override
  String get main_subtitle => 'Touch to Start';

  @override
  String get main_title_meter => 'Meter';

  @override
  String get main_title_taxi => 'Taxi';

  @override
  String get meter_btn_percentage_night_false => 'Night Percentage OFF';

  @override
  String get meter_btn_percentage_night_true => 'Night Percentage ON';

  @override
  String get meter_btn_percentage_outcity_false => 'Outcity Percentage OFF';

  @override
  String get meter_btn_percentage_outcity_true => 'Outcity Percentage ON';

  @override
  String get meter_btn_start => 'Start';

  @override
  String get meter_btn_stop => 'Stop';

  @override
  String get meter_cost => '₩%s';

  @override
  String get meter_dialog_exit_content => 'Meter will be stopped when exit.';

  @override
  String get meter_dialog_exit_no => 'Cancel';

  @override
  String get meter_dialog_exit_ok => 'OK';

  @override
  String get meter_dialog_stop_content => 'Cost: KRW %s\nDistance: %skm';

  @override
  String get meter_dialog_stop_ok => 'OK';

  @override
  String get meter_dialog_stop_title => 'Finish Driving';

  @override
  String get meter_info_cost_mode_base => 'Base Cost';

  @override
  String get meter_info_cost_mode_distance => 'Cost per Distance';

  @override
  String get meter_info_cost_mode_time => 'Cost per Time';

  @override
  String get meter_info_cost_mode_title => 'Cost Mode';

  @override
  String get meter_info_distance_data => '%skm';

  @override
  String get meter_info_distance_title => 'Distance';

  @override
  String get meter_info_speed_data => '%skm/h';

  @override
  String get meter_info_speed_title => 'Current Speed';

  @override
  String get meter_info_status_gps_error => 'Waiting for GPS...';

  @override
  String get meter_info_status_not_running => 'Not Running';

  @override
  String get meter_info_status_running => 'Running';

  @override
  String get meter_info_status_title => 'Status';

  @override
  String get meter_noti_gps_channel => 'Background Running Notification';

  @override
  String get meter_noti_gps_text => 'Taxi Meter is running in background';

  @override
  String get meter_noti_gps_title => 'Taxi Meter';

  @override
  String get meter_snack_percentage_night =>
      'Night Percentage will be applied at Setted Time';

  @override
  String get meter_snack_warning_location_accuracy =>
      'Meter might be unstable because of Non-precise Location Information.';

  @override
  String get setting_cost_custom_base => 'Base Cost';

  @override
  String get setting_cost_custom_base_distance => 'Distance for Base Cost';

  @override
  String get setting_cost_custom_per_distance => 'Cost per Distance (m)';

  @override
  String get setting_cost_custom_per_time => 'Cost per Time (s)';

  @override
  String get setting_cost_custom_percentage_night => 'Percentage for Night';

  @override
  String get setting_cost_custom_percentage_night_end =>
      'Percentage for Night End (24-H)';

  @override
  String get setting_cost_custom_percentage_night_start =>
      'Percentage for Night Start (24-H)';

  @override
  String get setting_cost_custom_percentage_outcity => 'Percentage for Outcity';

  @override
  String get setting_cost_info_1 =>
      'Base: KRW %s (First %skm)\nCost per Distance: KRW 100 per %sm\nCost per Time: KRW 100 per %ss\nOutcity Percentage: %s%%\nNight Percentace\n- %s%% (%d:00 ~ %d:00)';

  @override
  String get setting_cost_info_2 =>
      'Base: KRW %s (First %skm)\nCost per Distance: KRW 100 per %sm\nCost per Time: KRW 100 per %ss\nOutcity Percentage: %s%%\nNight Percentace\n- %s%% (%d:00 ~ %d:00)\n- %s%% (%d:00 ~ %d:00)';

  @override
  String get setting_developer_blog => 'Developer Blog';

  @override
  String get setting_developer_github => 'Developer GitHub';

  @override
  String get setting_developer_instagram => 'Developer Instagram';

  @override
  String get setting_developer_nickname => 'Dev. LR';

  @override
  String get setting_developer_university =>
      'Chung-Ang University Dept. Software since 2019';

  @override
  String get setting_dialog_cost_custom_save => 'Save';

  @override
  String get setting_dialog_cost_custom_save_error => 'Invalid Data Included.';

  @override
  String get setting_dialog_cost_custom_title => 'Custom Cost Info';

  @override
  String get setting_dialog_location_title => 'Location';

  @override
  String get setting_dialog_theme_title => 'Theme';

  @override
  String get setting_info_cost => 'Cost Info';

  @override
  String get setting_info_cost_db => 'Cost Info DB Version';

  @override
  String get setting_privacy_policy => 'Privacy Policy';

  @override
  String get setting_setup_location => 'Location';

  @override
  String get setting_setup_theme => 'Theme';

  @override
  String get setting_title_developer => 'Developer Info';

  @override
  String get setting_title_info => 'Meter Info';

  @override
  String get setting_title_setup => 'Meter Setup';

  @override
  String get welcome_btn_done => 'Done';

  @override
  String get welcome_btn_next => 'Next';

  @override
  String get welcome_info_gps_text =>
      'Meter function depends on Realtime GPS Information. If inside building or tunnel, meter might stopped. Please check whether Location Permission is granted properly.';

  @override
  String get welcome_info_location_text =>
      'You can choose location for taxi cost at Setting Menu inside application. Major cities in South Korea are supported, and you can even custom your own cost info.';

  @override
  String get welcome_info_warning_text =>
      '!! Warning !!\nReceiving money using this application may be punished under the laws of the Republic of Korea.';

  @override
  String get welcome_init_text =>
      'Welcome to Taxi Meter!\nBefore start using, some setup must be done.\nPress Next button to start setup.';

  @override
  String get welcome_permission_btn => 'Grant Location Permission';

  @override
  String get welcome_permission_btn_done => 'Already Granted';

  @override
  String get welcome_permission_text =>
      'Taxi Meter function works based on Current Driving Information from GPS. So location permission must be granted for Taxi Meter.\nIf not, application cannot access to GPS so Meter function cannot work.';

  @override
  String get welcome_snack_permission_not_granted =>
      'Location permission is not granted yet';

  @override
  String get welcome_snack_permission_error_retry =>
      'Location permission is not granted. Please Retry.';

  @override
  String get welcome_snack_permission_error_setting =>
      'Location permission is PERMANENTLY not granted. Goto System Settings for grant.';
}
