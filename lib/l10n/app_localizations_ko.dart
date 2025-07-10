// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get app_title => '택시미터기';

  @override
  String get donation_btn_ad_remove => '광고 제거';

  @override
  String get donation_btn_donate_1000 => '콜라 사주기';

  @override
  String get donation_btn_donate_5000 => '커피 사주기';

  @override
  String get donation_btn_donate_10000 => '빅맥 사주기';

  @override
  String get donation_btn_donate_50000 => '뷔페식사 사주기';

  @override
  String get donation_btn_restore => '구매기록 복원';

  @override
  String get donation_info_text =>
      '광고 제거를 제외한 결제항목은 미터기 개발자에게 도네이션하는 결제입니다.\n환불을 희망하는 경우, 앱스토어 내 상세 페이지를 참고하시어\n개발자에게 이메일을 보내주세요.';

  @override
  String get donation_error_connect => '앱스토어 연결에 실패하였습니다';

  @override
  String get donation_error_process => '결제 진행에 실패하였습니다';

  @override
  String get donation_purchase_done => '구매해주셔서 감사드립니다!';

  @override
  String get donation_restore_done => '기존 구매이력이 복원되었습니다.';

  @override
  String get nav_donation => '결제';

  @override
  String get nav_home => '홈';

  @override
  String get nav_setting => '설정';

  @override
  String get main_snack_gps_error => '위치정보 사용이 비활성화되었습니다. 스마트폴 설정에서 활성화해주세요.';

  @override
  String get main_snack_permission_error =>
      '위치정보 권한이 거부되었습니다. 스마트폰 설정에서 부여해주세요.';

  @override
  String get main_subtitle => '터치하여 시작하기';

  @override
  String get main_title_meter => '미터기';

  @override
  String get main_title_taxi => '택시';

  @override
  String get meter_btn_percentage_night_false => '야간할증 미적용';

  @override
  String get meter_btn_percentage_night_true => '야간할증 적용';

  @override
  String get meter_btn_percentage_outcity_false => '시외할증 미적용';

  @override
  String get meter_btn_percentage_outcity_true => '시외할증 적용';

  @override
  String get meter_btn_start => '운행 시작';

  @override
  String get meter_btn_stop => '운행 종료';

  @override
  String get meter_cost => '%s원';

  @override
  String get meter_dialog_exit_content => '미터기 동작이 종료됩니다.';

  @override
  String get meter_dialog_exit_no => '취소';

  @override
  String get meter_dialog_exit_ok => '확인';

  @override
  String get meter_dialog_stop_content => '요금: %s원\n거리: %skm';

  @override
  String get meter_dialog_stop_ok => '확인';

  @override
  String get meter_dialog_stop_title => '운행 종료';

  @override
  String get meter_info_cost_mode_base => '기본 요금';

  @override
  String get meter_info_cost_mode_distance => '거리 요금';

  @override
  String get meter_info_cost_mode_time => '시간 요금';

  @override
  String get meter_info_cost_mode_title => '요금 종류';

  @override
  String get meter_info_distance_data => '%skm';

  @override
  String get meter_info_distance_title => '운행 거리';

  @override
  String get meter_info_speed_data => '%skm/h';

  @override
  String get meter_info_speed_title => '현재 속도';

  @override
  String get meter_info_status_gps_error => 'GPS 연결 대기중...';

  @override
  String get meter_info_status_not_running => '운행 중 아님';

  @override
  String get meter_info_status_running => '운행 중';

  @override
  String get meter_info_status_title => '운행 상태';

  @override
  String get meter_noti_gps_channel => '백그라운드 실행 알림';

  @override
  String get meter_noti_gps_text => '택시미터기가 실행중입니다.';

  @override
  String get meter_noti_gps_title => '택시미터기';

  @override
  String get meter_snack_percentage_night => '야간할증은 지정된 시간에만 적용됩니다.';

  @override
  String get meter_snack_warning_location_accuracy =>
      '부정확한 위치정보로 인해 미터기 동작이 원활하지 않을 수 있습니다.';

  @override
  String get setting_cost_custom_base => '기본요금';

  @override
  String get setting_cost_custom_base_distance => '기본요금 주행거리';

  @override
  String get setting_cost_custom_per_distance => '거리요금 기준거리 (m)';

  @override
  String get setting_cost_custom_per_time => '시간요금 기준시간 (s)';

  @override
  String get setting_cost_custom_percentage_night => '야간할증 비율';

  @override
  String get setting_cost_custom_percentage_night_end => '야간할증 종료 (24시간 단위)';

  @override
  String get setting_cost_custom_percentage_night_start => '야간할증 시작 (24시간 단위)';

  @override
  String get setting_cost_custom_percentage_outcity => '시외할증 비율';

  @override
  String get setting_cost_info_1 =>
      '기본요금: %s원 (최초 %skm)\n거리요금: %sm당 100원\n시간요금: %s초당 100원\n시외할증: %s%%\n야간할증\n- %s%% (%d:00 ~ %d:00)';

  @override
  String get setting_cost_info_2 =>
      '기본요금: %s원 (최초 %skm)\n거리요금: %sm당 100원\n시간요금: %s초당 100원\n시외할증: %s%%\n야간할증\n- %s%% (%d:00 ~ %d:00)\n- %s%% (%d:00 ~ %d:00)';

  @override
  String get setting_developer_blog => '개발자 블로그';

  @override
  String get setting_developer_github => '개발자 GitHub';

  @override
  String get setting_developer_instagram => '개발자 Instagram';

  @override
  String get setting_developer_nickname => 'Dev. LR';

  @override
  String get setting_developer_university => '중앙대학교 소프트웨어학부 2019';

  @override
  String get setting_dialog_cost_custom_save => '저장';

  @override
  String get setting_dialog_cost_custom_save_error => '입력한 값이 올바르지 않습니다.';

  @override
  String get setting_dialog_cost_custom_title => '요금정보 직접 설정';

  @override
  String get setting_dialog_location_title => '위치';

  @override
  String get setting_dialog_theme_title => '테마';

  @override
  String get setting_info_cost => '요금정보';

  @override
  String get setting_info_cost_db => '요금정보 DB 버전';

  @override
  String get setting_privacy_policy => '개인정보 처리방침';

  @override
  String get setting_setup_location => '위치';

  @override
  String get setting_setup_theme => '테마';

  @override
  String get setting_title_developer => '개발자 정보';

  @override
  String get setting_title_info => '미터기 정보';

  @override
  String get setting_title_setup => '미터기 설정';

  @override
  String get welcome_btn_done => '완료';

  @override
  String get welcome_btn_next => '다음';

  @override
  String get welcome_info_gps_text =>
      '미터기 기능은 실시간 GPS에 의존하여 동작합니다. 건물이나 터널 내부에서는 동작하지 않을 수 있습니다. 올바른 동작을 위해서 위치정보 권한이 올바르게 부여되었는지 확인해주세요.';

  @override
  String get welcome_info_location_text =>
      '택시 요금정보는 앱 내 설정에서 변경할 수 있습니다. 대한민국의 주요 광역시와 도별 요금정보가 제공되며, 미지원 지역의 경우는 요금정보를 직접 설정할 수 있습니다.';

  @override
  String get welcome_info_warning_text =>
      '!! 경고 !!\n본 앱을 이용해 요금을 청구하는 경우에는 대한민국 법률에 의하여 처벌될 수 있습니다.';

  @override
  String get welcome_init_text =>
      '환영합니다!\n시작하기에 앞서, 권한 설정과 정보 안내가 필요합니다.\n시작하려면 다음 버튼을 클릭해주세요.';

  @override
  String get welcome_permission_btn => '위치정보 권한 부여';

  @override
  String get welcome_permission_btn_done => '이미 부여되었습니다';

  @override
  String get welcome_permission_text =>
      '미터기 기능은 GPS에 기반한 실시간 이동 정보를 기반으로 동작하기에 위치정보 권한이 필수적으로 요구됩니다.\n권한이 부여되지 않는 경우, GPS 정보에 접근할 수 없어 미터기 기능이 동작하지 않습니다.';

  @override
  String get welcome_snack_permission_not_granted => '위치정보 권한이 아직 부여되지 않았습니다.';

  @override
  String get welcome_snack_permission_error_retry =>
      '위치정보 권한이 부여되지 않았습니다. 다시 시도해주세요.';

  @override
  String get welcome_snack_permission_error_setting =>
      '위치정보 권한이 영구적으로 거부되었습니다. 시스템 설정에서 직접 부여해주세요.';
}
