// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'notion_todo';

  @override
  String get settings_view_title => '설정';

  @override
  String get settings_view_app_settings_title => '앱 설정';

  @override
  String get settings_view_notion_settings_title => 'Notion 설정';

  @override
  String get settings_view_notion_settings_description => '데이터베이스 설정이 필요합니다';

  @override
  String get settings_view_theme_settings_title => '테마';

  @override
  String get settings_view_support_title => '지원';

  @override
  String get settings_view_support_faq_title => '자주 묻는 질문';

  @override
  String get settings_view_support_feedback_title => '버그 신고・요청・문의';

  @override
  String get settings_view_support_privacy_policy_title => '개인정보 보호정책';

  @override
  String get settings_view_support_review_title => '리뷰로 응원하기';

  @override
  String get settings_view_version_title => '버전';

  @override
  String get settings_view_version_copy => '버전 정보가 복사되었습니다';

  @override
  String get notion_settings_view_title => 'Notion 설정';

  @override
  String get notion_settings_view_auth_status => '인증 상태';

  @override
  String get notion_settings_view_auth_status_connected => 'Notion에 연결됨';

  @override
  String get notion_settings_view_auth_status_disconnected => 'Notion에 연결되지 않음';

  @override
  String get notion_settings_view_auth_status_disconnect => 'Notion 연결 해제';

  @override
  String get notion_settings_view_auth_status_connect => 'Notion에 연결';

  @override
  String get notion_settings_view_database_settings_title => '데이터베이스 설정';

  @override
  String get notion_settings_view_database_settings_description =>
      '해당 속성의 이름이나 유형이 변경된 경우 재설정이 필요합니다';

  @override
  String get notion_settings_view_database_settings_database_name =>
      '데이터베이스 이름';

  @override
  String get notion_settings_view_database_settings_change_database_settings =>
      '데이터베이스 설정 변경';

  @override
  String get task_database_settings_title => '작업 데이터베이스 설정';

  @override
  String get database => '데이터베이스';

  @override
  String get status_property => '상태';

  @override
  String get status_property_todo_option => '할 일 옵션';

  @override
  String get status_property_in_progress_option => '진행 중 옵션';

  @override
  String get status_property_complete_option => '완료 옵션';

  @override
  String get date_property => '날짜';

  @override
  String get todo_option_description => '미완료로 지정할 상태';

  @override
  String get in_progress_option_description => '진행 중으로 지정할 상태';

  @override
  String get complete_option_description => '완료로 지정할 상태';

  @override
  String get status_property_description => '유형: 상태, 체크박스';

  @override
  String get date_property_description => '유형: 날짜';

  @override
  String get save => '저장';

  @override
  String get not_found_database => '접근 가능한 데이터베이스를 찾을 수 없습니다.';

  @override
  String get not_found_database_description => '설정을 다시 진행해 주세요.';

  @override
  String get notion_reconnect => 'Notion에 다시 연결';

  @override
  String get select => '선택하세요';

  @override
  String get create_property => '속성을 생성하세요';

  @override
  String get property_name => '속성 이름';

  @override
  String get property_name_input => '속성 이름을 입력하세요';

  @override
  String get property_name_error => '같은 이름의 속성이 이미 존재합니다';

  @override
  String property_added_success(String propertyName, String name) {
    return '$propertyName 속성 \"$name\"이(가) 추가되었습니다';
  }

  @override
  String get error => '오류';

  @override
  String get ok => '확인';

  @override
  String get cancel => '취소';

  @override
  String get confirm => '확인';

  @override
  String get new_create => '새로 만들기';

  @override
  String get language_settings_title => '언어 설정';

  @override
  String get language_settings_description => '앱의 언어를 설정하세요';

  @override
  String get language_settings_language => '언어';

  @override
  String get navigation_index => '인덱스';

  @override
  String get navigation_today => '오늘';

  @override
  String get task_sheet_title_hint => '작업 이름 입력';

  @override
  String get today => '오늘';

  @override
  String get yesterday => '어제';

  @override
  String get tomorrow => '내일';

  @override
  String get undetermined => '미정';

  @override
  String get select_date => '날짜 선택';

  @override
  String get no_task => '작업이 없습니다';

  @override
  String get no_task_description => '수고하셨습니다.\n좋은 하루 보내세요!';

  @override
  String add_task_success(String title) {
    return '\"$title\"이(가) 추가되었습니다';
  }

  @override
  String task_add_failed(String title) {
    return '\"$title\" 추가 실패';
  }

  @override
  String task_update_success(String title) {
    return '\"$title\"이(가) 변경되었습니다';
  }

  @override
  String task_update_failed(String title) {
    return '\"$title\" 변경 실패';
  }

  @override
  String task_update_status_success(String title) {
    return '\"$title\"이(가) 완료되었습니다 🎉';
  }

  @override
  String task_update_status_undo(String title) {
    return '\"$title\"을(를) 미완료로 되돌렸습니다';
  }

  @override
  String get task_update_status_failed => '상태 업데이트 실패';

  @override
  String task_delete_success(String title) {
    return '\"$title\"이(가) 삭제되었습니다';
  }

  @override
  String task_delete_undo(String title) {
    return '\"$title\"이(가) 복원되었습니다';
  }

  @override
  String task_delete_failed(String title) {
    return '\"$title\" 삭제 실패';
  }

  @override
  String task_delete_failed_undo(String title) {
    return '복원 실패';
  }

  @override
  String get loading_failed => '불러오기 실패';

  @override
  String get re_set_database => '재설정이 필요합니다.';

  @override
  String get not_found_property => '적절한 속성을 찾을 수 없습니다.';

  @override
  String get task_fetch_failed => '작업 가져오기 실패';

  @override
  String get load_more => '더 보기';

  @override
  String get wakelock_title => '앱 실행 중 절전 모드 방지';

  @override
  String get wakelock_description => '배터리에 영향을 줄 수 있습니다.';

  @override
  String get notion_settings_view_not_found_database_description =>
      '아직 데이터베이스가 없으신가요?';

  @override
  String get notion_settings_view_not_found_database_template_description =>
      '인증 시 \"제공된 템플릿 사용\"(위 버튼)을 선택하면 바로 사용 가능한 작업 관리 데이터베이스가 추가됩니다!';

  @override
  String get notion_settings_view_not_found_database_select_description =>
      '이미 사용 중인 데이터베이스가 있다면 \"공유할 페이지 선택\"(아래 버튼)에서 선택하세요.';

  @override
  String get go_to_settings => '설정 페이지로 이동';

  @override
  String get notion_database_settings_required => 'Notion 데이터베이스 설정이 필요합니다.';

  @override
  String updateMessage(String version) {
    return 'v$version으로 업데이트되었습니다 ✨';
  }

  @override
  String get releaseNote => '자세히 보기';

  @override
  String get settings_view_support_release_notes_title => '릴리스 노트';

  @override
  String get font_settings => '제목 글꼴 스타일';

  @override
  String get font_language => '글꼴 언어';

  @override
  String get font_family => '글꼴';

  @override
  String get italic => '기울임꼴';

  @override
  String get font_size => '크기';

  @override
  String get letter_spacing => '자간';

  @override
  String get preview => '미리보기';

  @override
  String get reset => '재설정';

  @override
  String get reset_to_default => '기본값으로 재설정';

  @override
  String get bold => '굵게';

  @override
  String get appearance_settings_title => '외관';

  @override
  String get hide_navigation_label_title => '내비게이션 라벨 숨기기';

  @override
  String get hide_navigation_label_description => '하단 내비게이션 바의 라벨을 숨깁니다';

  @override
  String get font_settings_description => '오늘 작업 목록의 날짜 제목을 사용자 정의합니다';

  @override
  String current_setting(String setting) {
    return '현재 설정: $setting';
  }

  @override
  String task_update_status_in_progress(String title) {
    return '\"$title\"을(를) 진행 중으로 변경했습니다';
  }

  @override
  String task_update_status_todo(String title) {
    return '\"$title\"을(를) 미완료로 되돌렸습니다';
  }

  @override
  String get task_star_button_dialog_title => '진행 중 옵션이 설정되지 않음';

  @override
  String get task_star_button_dialog_content =>
      '데이터베이스 설정에서 설정하고 지금 집중해야 할 작업을 확인해보세요!';

  @override
  String get task_star_button_dialog_cancel => '취소';

  @override
  String get task_star_button_dialog_settings => '설정';

  @override
  String get notifications => '알림';

  @override
  String get showNotificationBadge => '알림 배지 표시';

  @override
  String get select_time => '시간 선택';

  @override
  String get no_time => '지정 안 함';

  @override
  String get start_time => '시작 시간';

  @override
  String get duration => '소요 시간';

  @override
  String duration_format_minutes(int minutes) {
    return '$minutes분';
  }

  @override
  String duration_format_hours(int hours) {
    return '$hours시간';
  }

  @override
  String duration_format_hours_minutes(int hours, int minutes) {
    return '$hours시간 $minutes분';
  }

  @override
  String get reschedule => '일정 변경';

  @override
  String get continuous_task_addition_title => '연속 작업 추가';

  @override
  String get continuous_task_addition_description => '연속으로 새 작업을 추가할 수 있습니다';

  @override
  String get behavior_settings_title => '동작';

  @override
  String get task_completion_sound_title => '작업 완료 시 소리';

  @override
  String get task_completion_sound_description => '작업 완료 시 소리를 재생합니다';

  @override
  String get sound_settings_title => '작업 완료 시 소리';

  @override
  String get sound_enabled => '소리 활성화';

  @override
  String get sound_enabled_description => '작업 완료 시 소리를 재생합니다';

  @override
  String get morning_message => '새로운 하루가 시작되었습니다.\n무엇부터 시작하시겠습니까?';

  @override
  String get afternoon_message => '안녕하세요!\n무엇부터 시작하시겠습니까?';

  @override
  String get evening_message => '안녕하세요.\n오늘 중에 처리하고 싶은 일이 있나요?';

  @override
  String get licenses_page_title => '라이선스';

  @override
  String get licenses_page_no_licenses => '라이선스 정보가 없습니다.';

  @override
  String get sound_credit_title => '사운드 제공';

  @override
  String get sound_credit_description => 'OtoLogic (CC BY 4.0)';

  @override
  String get priority_property => '우선순위';

  @override
  String get priority_property_description => '유형: 선택';

  @override
  String get checkbox_property => '체크박스';

  @override
  String get project_property => '프로젝트';

  @override
  String get project_property_description => '유형: 관계';

  @override
  String get project_property_empty_message =>
      '프로젝트가 표시되지 않는 경우 Notion 인증에서 대상 데이터베이스도 포함하여 재인증해 주세요';

  @override
  String get title_property => '제목';

  @override
  String get task_priority_dialog_title => '우선순위 속성이 설정되지 않음';

  @override
  String get task_priority_dialog_content =>
      '작업의 우선순위를 설정하려면 데이터베이스 설정에서 우선순위 속성을 설정하세요.';

  @override
  String get task_priority_dialog_cancel => '취소';

  @override
  String get task_priority_dialog_settings => '설정';

  @override
  String get show_completed_tasks => '완료된 작업 표시';

  @override
  String get completed_tasks => '완료됨';

  @override
  String get sort_by => '정렬';

  @override
  String get sort_by_default => '기본값';

  @override
  String get group_by => '그룹';

  @override
  String get group_by_none => '없음';

  @override
  String no_property(String property) {
    return '$property 없음';
  }

  @override
  String get subscription_fetch_failed => '구독 정보를 가져오지 못했습니다';

  @override
  String subscription_purchase_success(String plan) {
    return '$plan 플랜을 구매했습니다';
  }

  @override
  String get subscription_purchase_failed => '구매 실패';

  @override
  String get subscription_purchase_error_general => '구매 처리 중 오류가 발생했습니다.';

  @override
  String get subscription_restore_success => '구매 정보가 복원되었습니다';

  @override
  String get subscription_restore_failed => '구매 정보 복원 실패';

  @override
  String get subscription_restore_none => '복원 가능한 구매가 없습니다';

  @override
  String get subscription_restore_error_general => '구매 정보 복원 중 오류가 발생했습니다.';

  @override
  String get premium_features_title => '프리미엄';

  @override
  String get monthly_subscription => '월간';

  @override
  String get yearly_subscription => '연간';

  @override
  String get lifetime_subscription => '평생';

  @override
  String get lifetime_purchase => '평생 라이선스';

  @override
  String trial_subscription_expires_in(int days) {
    return '무료 체험 $days일 남음';
  }

  @override
  String get restore_purchases => '구매 복원';

  @override
  String current_plan(String planName) {
    return '$planName';
  }

  @override
  String free_trial_days(int days) {
    return '먼저 $days일 무료 체험';
  }

  @override
  String get monthly_price => '월';

  @override
  String get yearly_price => '년';

  @override
  String get upgrade_to_premium_description =>
      '프리미엄 플랜으로 업그레이드하고 모든 기능을 잠금 해제하세요!';

  @override
  String get unlock_all_widgets_title => '모든 위젯 잠금 해제';

  @override
  String get unlock_all_widgets_description => '다양한 위젯 스타일 중에서 선택할 수 있습니다';

  @override
  String get access_all_future_features_title => '향후 추가되는 모든 기능 이용';

  @override
  String get access_all_future_features_description =>
      '새로운 기능이 추가되면 바로 사용할 수 있습니다';

  @override
  String get support_the_developer_title => '개발자 응원';

  @override
  String get support_the_developer_description => '지속적인 개발을 지원할 수 있습니다';

  @override
  String get lifetime_unlock_description => '1회 구매로 모든 기능 잠금 해제';

  @override
  String get lifetime_license_activated => '평생 라이선스 획득됨';

  @override
  String get currently_subscribed => '구독 중';

  @override
  String get refresh => '새로고침';

  @override
  String get no_projects_found => '프로젝트를 찾을 수 없습니다';

  @override
  String get error_loading_projects => '프로젝트 불러오기 실패';

  @override
  String get retry => '재시도';

  @override
  String get start_free_trial => '무료 체험 시작';

  @override
  String get yearly_price_short => '년';

  @override
  String trial_ends_then_price_per_year(
      Object trialDays, Object priceString, Object yearlyPriceShort) {
    return '$trialDays일 무료 체험 종료 후 $priceString / $yearlyPriceShort';
  }

  @override
  String get continue_purchase => '구매 계속하기';

  @override
  String get change_plan => '플랜 변경';

  @override
  String current_plan_display(Object currentPlanName) {
    return '현재 플랜: $currentPlanName';
  }

  @override
  String get terms_of_service => '이용약관';

  @override
  String get privacy_policy => '개인정보 처리방침';

  @override
  String get purchase_terms_and_conditions_part3 =>
      '구독은 언제든지 취소할 수 있습니다.\n무료 체험은 첫 구매 시에만 적용됩니다.\n구독 플랜 변경 시 현재 플랜 종료 후 자동으로 전환됩니다.';

  @override
  String get switchToLifetimeNotificationBody =>
      '구독 플랜을 이미 구매하신 경우 App Store / Google Play 계정 설정에서 자동 갱신을 중지해 주세요.';

  @override
  String get subscription_purchase_success_title => '평생 라이선스를 획득했습니다!';

  @override
  String get subscription_purchase_success_body => '이미 평생 플랜을 구매하셨습니다';

  @override
  String get account_settings_title => '계정';

  @override
  String get free_plan => '무료 플랜';

  @override
  String get premium_plan => '프리미엄 플랜 가입됨';

  @override
  String get plan_title => '플랜';

  @override
  String get copy_notion_link => 'Notion 링크 복사';

  @override
  String get copy_title => '제목 복사';

  @override
  String get open_in_notion => 'Notion에서 열기';

  @override
  String get duplicate => '복제';

  @override
  String get copy => '복사';

  @override
  String get notion_link_copied => 'Notion 링크가 복사되었습니다';

  @override
  String get title_copied => '제목이 복사되었습니다';

  @override
  String get task_duplicated => '작업이 복제되었습니다';

  @override
  String get error_no_notion_link => 'Notion 링크를 찾을 수 없습니다';

  @override
  String get error_copy_failed => '복사 실패';

  @override
  String get error_cannot_open_notion => 'Notion에서 열 수 없습니다';

  @override
  String get error_duplicate_failed => '작업 복제 실패';

  @override
  String get no_project_selected => '선택된 프로젝트가 없습니다';

  @override
  String get select_project => '프로젝트 선택';
}
