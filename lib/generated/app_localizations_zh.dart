// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'notion_todo';

  @override
  String get settings_view_title => '設定';

  @override
  String get settings_view_app_settings_title => '應用程式設定';

  @override
  String get settings_view_notion_settings_title => 'Notion 設定';

  @override
  String get settings_view_notion_settings_description => '需要資料庫設定';

  @override
  String get settings_view_theme_settings_title => '主題';

  @override
  String get settings_view_support_title => '支援';

  @override
  String get settings_view_support_faq_title => '常見問題';

  @override
  String get settings_view_support_feedback_title => '錯誤回報・需求・聯絡';

  @override
  String get settings_view_support_privacy_policy_title => '隱私權政策';

  @override
  String get settings_view_support_review_title => '留下評論支持我們';

  @override
  String get settings_view_version_title => '版本';

  @override
  String get settings_view_version_copy => '版本資訊已複製';

  @override
  String get notion_settings_view_title => 'Notion 設定';

  @override
  String get notion_settings_view_auth_status => '驗證狀態';

  @override
  String get notion_settings_view_auth_status_connected => '已連接至 Notion';

  @override
  String get notion_settings_view_auth_status_disconnected => '未連接至 Notion';

  @override
  String get notion_settings_view_auth_status_disconnect => '中斷 Notion 連接';

  @override
  String get notion_settings_view_auth_status_connect => '連接至 Notion';

  @override
  String get notion_settings_view_database_settings_title => '資料庫設定';

  @override
  String get notion_settings_view_database_settings_description =>
      '如果相關屬性的名稱或類型已更改，需要重新設定';

  @override
  String get notion_settings_view_database_settings_database_name => '資料庫名稱';

  @override
  String get notion_settings_view_database_settings_change_database_settings =>
      '變更資料庫設定';

  @override
  String get task_database_settings_title => '任務資料庫設定';

  @override
  String get database => '資料庫';

  @override
  String get status_property => '狀態';

  @override
  String get status_property_todo_option => '待辦選項';

  @override
  String get status_property_in_progress_option => '進行中選項';

  @override
  String get status_property_complete_option => '完成選項';

  @override
  String get date_property => '日期';

  @override
  String get todo_option_description => '指定為未完成的狀態';

  @override
  String get in_progress_option_description => '指定為進行中的狀態';

  @override
  String get complete_option_description => '指定為完成的狀態';

  @override
  String get status_property_description => '類型：狀態、核取方塊';

  @override
  String get date_property_description => '類型：日期';

  @override
  String get save => '儲存';

  @override
  String get not_found_database => '找不到可存取的資料庫。';

  @override
  String get not_found_database_description => '請重新設定。';

  @override
  String get notion_reconnect => '重新連接至 Notion';

  @override
  String get select => '請選擇';

  @override
  String get create_property => '請建立屬性';

  @override
  String get property_name => '屬性名稱';

  @override
  String get property_name_input => '請輸入屬性名稱';

  @override
  String get property_name_error => '已存在相同名稱的屬性';

  @override
  String property_added_success(String propertyName, String name) {
    return '$propertyName property \"$name\" has been added';
  }

  @override
  String get error => '錯誤';

  @override
  String get ok => '確定';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '確認';

  @override
  String get new_create => '新建';

  @override
  String get language_settings_title => '語言設定';

  @override
  String get language_settings_description => '設定應用程式的語言';

  @override
  String get language_settings_language => '語言';

  @override
  String get language_settings_language_ja => '日文';

  @override
  String get language_settings_language_en => '英文';

  @override
  String get navigation_index => '索引';

  @override
  String get navigation_today => '今天';

  @override
  String get task_sheet_title_hint => '輸入任務名稱';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get tomorrow => '明天';

  @override
  String get undetermined => '未定';

  @override
  String get select_date => '選擇日期';

  @override
  String get no_task => '沒有任務';

  @override
  String get no_task_description => '辛苦了！\n祝您有美好的一天！';

  @override
  String add_task_success(String title) {
    return '已新增「$title」';
  }

  @override
  String task_add_failed(String title) {
    return '新增「$title」失敗';
  }

  @override
  String task_update_success(String title) {
    return '已變更「$title」';
  }

  @override
  String task_update_failed(String title) {
    return '變更「$title」失敗';
  }

  @override
  String task_update_status_success(String title) {
    return '「$title」已完成 🎉';
  }

  @override
  String task_update_status_undo(String title) {
    return '「$title」已恢復為未完成';
  }

  @override
  String get task_update_status_failed => '狀態更新失敗';

  @override
  String task_delete_success(String title) {
    return '已刪除「$title」';
  }

  @override
  String task_delete_undo(String title) {
    return '已復原「$title」';
  }

  @override
  String task_delete_failed(String title) {
    return '刪除「$title」失敗';
  }

  @override
  String task_delete_failed_undo(String title) {
    return '復原失敗';
  }

  @override
  String get loading_failed => '載入失敗';

  @override
  String get re_set_database => '需要重新設定。';

  @override
  String get not_found_property => '找不到適當的屬性。';

  @override
  String get task_fetch_failed => '取得任務失敗';

  @override
  String get load_more => '載入更多';

  @override
  String get wakelock_title => '應用程式執行時防止休眠';

  @override
  String get wakelock_description => '可能會影響電池續航力。';

  @override
  String get notion_settings_view_not_found_database_description => '還沒有資料庫嗎？';

  @override
  String get notion_settings_view_not_found_database_template_description =>
      '驗證時選擇「使用提供的範本」（上方按鈕），即可新增可立即使用的任務管理資料庫！';

  @override
  String get notion_settings_view_not_found_database_select_description =>
      '如果您已經有在使用的資料庫，請從「選擇要分享的頁面」（下方按鈕）中選擇。';

  @override
  String get go_to_settings => '前往設定頁面';

  @override
  String get notion_database_settings_required => '需要 Notion 資料庫設定。';

  @override
  String updateMessage(String version) {
    return '已更新至 v$version ✨';
  }

  @override
  String get releaseNote => '詳細資訊';

  @override
  String get settings_view_support_release_notes_title => '版本說明';

  @override
  String get font_settings => '標題字型樣式';

  @override
  String get font_language => '字型語言';

  @override
  String get font_family => '字型';

  @override
  String get italic => '斜體';

  @override
  String get font_size => '大小';

  @override
  String get letter_spacing => '字元間距';

  @override
  String get preview => '預覽';

  @override
  String get reset => '重設';

  @override
  String get reset_to_default => '恢復為預設值';

  @override
  String get bold => '粗體';

  @override
  String get appearance_settings_title => '外觀';

  @override
  String get hide_navigation_label_title => '隱藏導覽標籤';

  @override
  String get hide_navigation_label_description => '隱藏底部導覽列的標籤';

  @override
  String get font_settings_description => '自訂今日任務清單的日期標題';

  @override
  String current_setting(String setting) {
    return '目前設定：$setting';
  }

  @override
  String task_update_status_in_progress(String title) {
    return '「$title」已設為進行中';
  }

  @override
  String task_update_status_todo(String title) {
    return '「$title」已恢復為待辦';
  }

  @override
  String get task_star_button_dialog_title => '未設定進行中選項';

  @override
  String get task_star_button_dialog_content => '在資料庫設定中設定，確認現在應該專注的任務！';

  @override
  String get task_star_button_dialog_cancel => '取消';

  @override
  String get task_star_button_dialog_settings => '設定';

  @override
  String get notifications => '通知';

  @override
  String get showNotificationBadge => '顯示通知徽章';

  @override
  String get select_time => '選擇時間';

  @override
  String get no_time => '未指定';

  @override
  String get start_time => '開始時間';

  @override
  String get duration => '所需時間';

  @override
  String duration_format_minutes(int minutes) {
    return '$minutes分鐘';
  }

  @override
  String duration_format_hours(int hours) {
    return '$hours小時';
  }

  @override
  String duration_format_hours_minutes(int hours, int minutes) {
    return '$hours小時$minutes分鐘';
  }

  @override
  String get reschedule => '重新排程';

  @override
  String get continuous_task_addition_title => '連續新增任務';

  @override
  String get continuous_task_addition_description => '允許連續新增任務';

  @override
  String get behavior_settings_title => '行為';

  @override
  String get task_completion_sound_title => '任務完成時的聲音';

  @override
  String get task_completion_sound_description => '任務完成時播放聲音';

  @override
  String get sound_settings_title => '任務完成時的聲音';

  @override
  String get sound_enabled => '啟用聲音';

  @override
  String get sound_enabled_description => '任務完成時播放聲音';

  @override
  String get morning_message => '新的一天開始了。\n您想從什麼開始？';

  @override
  String get afternoon_message => '午安！\n您想從什麼開始？';

  @override
  String get evening_message => '晚安。\n今天還有什麼想要完成的事嗎？';

  @override
  String get licenses_page_title => '授權';

  @override
  String get licenses_page_no_licenses => '沒有授權資訊。';

  @override
  String get sound_credit_title => '聲音提供';

  @override
  String get sound_credit_description => 'OtoLogic (CC BY 4.0)';

  @override
  String get priority_property => '優先順序';

  @override
  String get priority_property_description => '類型：選擇';

  @override
  String get checkbox_property => 'Checkbox';

  @override
  String get project_property => '專案';

  @override
  String get project_property_description => '類型：關聯';

  @override
  String get project_property_empty_message =>
      '如果專案未顯示，請在 Notion 驗證中包含目標資料庫重新驗證';

  @override
  String get title_property => '標題';

  @override
  String get task_priority_dialog_title => '未設定優先順序屬性';

  @override
  String get task_priority_dialog_content => '若要設定任務的優先順序，請在資料庫設定中設定優先順序屬性。';

  @override
  String get task_priority_dialog_cancel => '取消';

  @override
  String get task_priority_dialog_settings => '設定';

  @override
  String get show_completed_tasks => '顯示已完成的任務';

  @override
  String get completed_tasks => '已完成';

  @override
  String get sort_by => '排序';

  @override
  String get sort_by_default => '預設';

  @override
  String get group_by => '分組';

  @override
  String get group_by_none => '無';

  @override
  String no_property(String property) {
    return '無$property';
  }

  @override
  String get subscription_fetch_failed => '無法取得訂閱資訊';

  @override
  String subscription_purchase_success(String plan) {
    return '已購買$plan方案';
  }

  @override
  String get subscription_purchase_failed => '購買失敗';

  @override
  String get subscription_purchase_error_general => '購買處理過程中發生錯誤。';

  @override
  String get subscription_restore_success => '購買資訊已復原';

  @override
  String get subscription_restore_failed => '購買資訊復原失敗';

  @override
  String get subscription_restore_none => '沒有可復原的購買';

  @override
  String get subscription_restore_error_general => '復原購買資訊時發生錯誤。';

  @override
  String get premium_features_title => '高級版';

  @override
  String get monthly_subscription => '月費';

  @override
  String get yearly_subscription => '年費';

  @override
  String get lifetime_subscription => '買斷';

  @override
  String get lifetime_purchase => '永久授權';

  @override
  String trial_subscription_expires_in(int days) {
    return '免費試用剩餘$days天';
  }

  @override
  String get restore_purchases => '復原購買';

  @override
  String current_plan(String planName) {
    return '$planName';
  }

  @override
  String free_trial_days(int days) {
    return '先享$days天免費試用';
  }

  @override
  String get monthly_price => '月';

  @override
  String get yearly_price => '年';

  @override
  String get upgrade_to_premium_description => '升級至高級版方案，解鎖所有功能！';

  @override
  String get unlock_all_widgets_title => '解鎖所有小工具';

  @override
  String get unlock_all_widgets_description => '可從多種小工具樣式中選擇';

  @override
  String get access_all_future_features_title => '存取所有未來功能';

  @override
  String get access_all_future_features_description => '新功能推出後立即可用';

  @override
  String get support_the_developer_title => '支持開發者';

  @override
  String get support_the_developer_description => '支持持續開發';

  @override
  String get lifetime_unlock_description => '一次購買解鎖所有功能';

  @override
  String get lifetime_license_activated => '已取得永久授權';

  @override
  String get currently_subscribed => '訂閱中';

  @override
  String get refresh => '重新整理';

  @override
  String get no_projects_found => '找不到專案';

  @override
  String get error_loading_projects => '載入專案失敗';

  @override
  String get retry => '重試';

  @override
  String get start_free_trial => '開始免費試用';

  @override
  String get yearly_price_short => '年';

  @override
  String trial_ends_then_price_per_year(
      Object trialDays, Object priceString, Object yearlyPriceShort) {
    return '$trialDays天免費試用結束後 $priceString / $yearlyPriceShort';
  }

  @override
  String get continue_purchase => '繼續購買';

  @override
  String get change_plan => '變更方案';

  @override
  String current_plan_display(Object currentPlanName) {
    return '目前方案：$currentPlanName';
  }

  @override
  String get terms_of_service => '使用條款';

  @override
  String get privacy_policy => '隱私權政策';

  @override
  String get purchase_terms_and_conditions_part3 =>
      '訂閱可隨時取消。\n免費試用僅適用於首次購買。\n變更訂閱方案時，將在目前方案結束後自動切換。';

  @override
  String get switchToLifetimeNotificationBody =>
      '如果您已購買訂閱方案，請至 App Store / Google Play 帳戶設定中停止自動續訂。';

  @override
  String get subscription_purchase_success_title => '已取得永久授權！';

  @override
  String get subscription_purchase_success_body => '您已經購買了買斷方案';

  @override
  String get account_settings_title => '帳戶';

  @override
  String get free_plan => '免費方案';

  @override
  String get premium_plan => '已加入高級版方案';

  @override
  String get plan_title => '方案';

  @override
  String get copy_notion_link => '複製 Notion 連結';

  @override
  String get copy_title => '複製標題';

  @override
  String get open_in_notion => '在 Notion 中開啟';

  @override
  String get duplicate => '複製';

  @override
  String get copy => '複製';

  @override
  String get notion_link_copied => '已複製 Notion 連結';

  @override
  String get title_copied => '已複製標題';

  @override
  String get task_duplicated => '已複製任務';

  @override
  String get error_no_notion_link => '找不到 Notion 連結';

  @override
  String get error_copy_failed => '複製失敗';

  @override
  String get error_cannot_open_notion => '無法在 Notion 中開啟';

  @override
  String get error_duplicate_failed => '任務複製失敗';

  @override
  String get no_project_selected => '未選擇專案';

  @override
  String get select_project => '選擇專案';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => 'notion_todo';

  @override
  String get settings_view_title => '設定';

  @override
  String get settings_view_app_settings_title => '應用程式設定';

  @override
  String get settings_view_notion_settings_title => 'Notion 設定';

  @override
  String get settings_view_notion_settings_description => '需要資料庫設定';

  @override
  String get settings_view_theme_settings_title => '主題';

  @override
  String get settings_view_support_title => '支援';

  @override
  String get settings_view_support_faq_title => '常見問題';

  @override
  String get settings_view_support_feedback_title => '錯誤回報・需求・聯絡';

  @override
  String get settings_view_support_privacy_policy_title => '隱私權政策';

  @override
  String get settings_view_support_review_title => '留下評論支持我們';

  @override
  String get settings_view_version_title => '版本';

  @override
  String get settings_view_version_copy => '版本資訊已複製';

  @override
  String get notion_settings_view_title => 'Notion 設定';

  @override
  String get notion_settings_view_auth_status => '驗證狀態';

  @override
  String get notion_settings_view_auth_status_connected => '已連接至 Notion';

  @override
  String get notion_settings_view_auth_status_disconnected => '未連接至 Notion';

  @override
  String get notion_settings_view_auth_status_disconnect => '中斷 Notion 連接';

  @override
  String get notion_settings_view_auth_status_connect => '連接至 Notion';

  @override
  String get notion_settings_view_database_settings_title => '資料庫設定';

  @override
  String get notion_settings_view_database_settings_description =>
      '如果相關屬性的名稱或類型已更改，需要重新設定';

  @override
  String get notion_settings_view_database_settings_database_name => '資料庫名稱';

  @override
  String get notion_settings_view_database_settings_change_database_settings =>
      '變更資料庫設定';

  @override
  String get task_database_settings_title => '任務資料庫設定';

  @override
  String get database => '資料庫';

  @override
  String get status_property => '狀態';

  @override
  String get status_property_todo_option => '待辦選項';

  @override
  String get status_property_in_progress_option => '進行中選項';

  @override
  String get status_property_complete_option => '完成選項';

  @override
  String get date_property => '日期';

  @override
  String get todo_option_description => '指定為未完成的狀態';

  @override
  String get in_progress_option_description => '指定為進行中的狀態';

  @override
  String get complete_option_description => '指定為完成的狀態';

  @override
  String get status_property_description => '類型：狀態、核取方塊';

  @override
  String get date_property_description => '類型：日期';

  @override
  String get save => '儲存';

  @override
  String get not_found_database => '找不到可存取的資料庫。';

  @override
  String get not_found_database_description => '請重新設定。';

  @override
  String get notion_reconnect => '重新連接至 Notion';

  @override
  String get select => '請選擇';

  @override
  String get create_property => '請建立屬性';

  @override
  String get property_name => '屬性名稱';

  @override
  String get property_name_input => '請輸入屬性名稱';

  @override
  String get property_name_error => '已存在相同名稱的屬性';

  @override
  String get error => '錯誤';

  @override
  String get ok => '確定';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '確認';

  @override
  String get new_create => '新建';

  @override
  String get language_settings_title => '語言設定';

  @override
  String get language_settings_description => '設定應用程式的語言';

  @override
  String get language_settings_language => '語言';

  @override
  String get language_settings_language_ja => '日文';

  @override
  String get language_settings_language_en => '英文';

  @override
  String get navigation_index => '索引';

  @override
  String get navigation_today => '今天';

  @override
  String get task_sheet_title_hint => '輸入任務名稱';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get tomorrow => '明天';

  @override
  String get undetermined => '未定';

  @override
  String get select_date => '選擇日期';

  @override
  String get no_task => '沒有任務';

  @override
  String get no_task_description => '辛苦了！\n祝您有美好的一天！';

  @override
  String add_task_success(String title) {
    return '已新增「$title」';
  }

  @override
  String task_add_failed(String title) {
    return '新增「$title」失敗';
  }

  @override
  String task_update_success(String title) {
    return '已變更「$title」';
  }

  @override
  String task_update_failed(String title) {
    return '變更「$title」失敗';
  }

  @override
  String task_update_status_success(String title) {
    return '「$title」已完成 🎉';
  }

  @override
  String task_update_status_undo(String title) {
    return '「$title」已恢復為未完成';
  }

  @override
  String get task_update_status_failed => '狀態更新失敗';

  @override
  String task_delete_success(String title) {
    return '已刪除「$title」';
  }

  @override
  String task_delete_undo(String title) {
    return '已復原「$title」';
  }

  @override
  String task_delete_failed(String title) {
    return '刪除「$title」失敗';
  }

  @override
  String task_delete_failed_undo(String title) {
    return '復原失敗';
  }

  @override
  String get loading_failed => '載入失敗';

  @override
  String get re_set_database => '需要重新設定。';

  @override
  String get not_found_property => '找不到適當的屬性。';

  @override
  String get task_fetch_failed => '取得任務失敗';

  @override
  String get load_more => '載入更多';

  @override
  String get wakelock_title => '應用程式執行時防止休眠';

  @override
  String get wakelock_description => '可能會影響電池續航力。';

  @override
  String get notion_settings_view_not_found_database_description => '還沒有資料庫嗎？';

  @override
  String get notion_settings_view_not_found_database_template_description =>
      '驗證時選擇「使用提供的範本」（上方按鈕），即可新增可立即使用的任務管理資料庫！';

  @override
  String get notion_settings_view_not_found_database_select_description =>
      '如果您已經有在使用的資料庫，請從「選擇要分享的頁面」（下方按鈕）中選擇。';

  @override
  String get go_to_settings => '前往設定頁面';

  @override
  String get notion_database_settings_required => '需要 Notion 資料庫設定。';

  @override
  String updateMessage(String version) {
    return '已更新至 v$version ✨';
  }

  @override
  String get releaseNote => '詳細資訊';

  @override
  String get settings_view_support_release_notes_title => '版本說明';

  @override
  String get font_settings => '標題字型樣式';

  @override
  String get font_language => '字型語言';

  @override
  String get font_family => '字型';

  @override
  String get italic => '斜體';

  @override
  String get font_size => '大小';

  @override
  String get letter_spacing => '字元間距';

  @override
  String get preview => '預覽';

  @override
  String get reset => '重設';

  @override
  String get reset_to_default => '恢復為預設值';

  @override
  String get bold => '粗體';

  @override
  String get appearance_settings_title => '外觀';

  @override
  String get hide_navigation_label_title => '隱藏導覽標籤';

  @override
  String get hide_navigation_label_description => '隱藏底部導覽列的標籤';

  @override
  String get font_settings_description => '自訂今日任務清單的日期標題';

  @override
  String current_setting(String setting) {
    return '目前設定：$setting';
  }

  @override
  String task_update_status_in_progress(String title) {
    return '「$title」已設為進行中';
  }

  @override
  String task_update_status_todo(String title) {
    return '「$title」已恢復為待辦';
  }

  @override
  String get task_star_button_dialog_title => '未設定進行中選項';

  @override
  String get task_star_button_dialog_content => '在資料庫設定中設定，確認現在應該專注的任務！';

  @override
  String get task_star_button_dialog_cancel => '取消';

  @override
  String get task_star_button_dialog_settings => '設定';

  @override
  String get notifications => '通知';

  @override
  String get showNotificationBadge => '顯示通知徽章';

  @override
  String get select_time => '選擇時間';

  @override
  String get no_time => '未指定';

  @override
  String get start_time => '開始時間';

  @override
  String get duration => '所需時間';

  @override
  String duration_format_minutes(int minutes) {
    return '$minutes分鐘';
  }

  @override
  String duration_format_hours(int hours) {
    return '$hours小時';
  }

  @override
  String duration_format_hours_minutes(int hours, int minutes) {
    return '$hours小時$minutes分鐘';
  }

  @override
  String get reschedule => '重新排程';

  @override
  String get continuous_task_addition_title => '連續新增任務';

  @override
  String get continuous_task_addition_description => '允許連續新增任務';

  @override
  String get behavior_settings_title => '行為';

  @override
  String get task_completion_sound_title => '任務完成時的聲音';

  @override
  String get task_completion_sound_description => '任務完成時播放聲音';

  @override
  String get sound_settings_title => '任務完成時的聲音';

  @override
  String get sound_enabled => '啟用聲音';

  @override
  String get sound_enabled_description => '任務完成時播放聲音';

  @override
  String get morning_message => '新的一天開始了。\n您想從什麼開始？';

  @override
  String get afternoon_message => '午安！\n您想從什麼開始？';

  @override
  String get evening_message => '晚安。\n今天還有什麼想要完成的事嗎？';

  @override
  String get licenses_page_title => '授權';

  @override
  String get licenses_page_no_licenses => '沒有授權資訊。';

  @override
  String get sound_credit_title => '聲音提供';

  @override
  String get sound_credit_description => 'OtoLogic (CC BY 4.0)';

  @override
  String get priority_property => '優先順序';

  @override
  String get priority_property_description => '類型：選擇';

  @override
  String get project_property => '專案';

  @override
  String get project_property_description => '類型：關聯';

  @override
  String get project_property_empty_message =>
      '如果專案未顯示，請在 Notion 驗證中包含目標資料庫重新驗證';

  @override
  String get title_property => '標題';

  @override
  String get task_priority_dialog_title => '未設定優先順序屬性';

  @override
  String get task_priority_dialog_content => '若要設定任務的優先順序，請在資料庫設定中設定優先順序屬性。';

  @override
  String get task_priority_dialog_cancel => '取消';

  @override
  String get task_priority_dialog_settings => '設定';

  @override
  String get show_completed_tasks => '顯示已完成的任務';

  @override
  String get completed_tasks => '已完成';

  @override
  String get sort_by => '排序';

  @override
  String get sort_by_default => '預設';

  @override
  String get group_by => '分組';

  @override
  String get group_by_none => '無';

  @override
  String no_property(String property) {
    return '無$property';
  }

  @override
  String get subscription_fetch_failed => '無法取得訂閱資訊';

  @override
  String subscription_purchase_success(String plan) {
    return '已購買$plan方案';
  }

  @override
  String get subscription_purchase_failed => '購買失敗';

  @override
  String get subscription_purchase_error_general => '購買處理過程中發生錯誤。';

  @override
  String get subscription_restore_success => '購買資訊已復原';

  @override
  String get subscription_restore_failed => '購買資訊復原失敗';

  @override
  String get subscription_restore_none => '沒有可復原的購買';

  @override
  String get subscription_restore_error_general => '復原購買資訊時發生錯誤。';

  @override
  String get premium_features_title => '高級版';

  @override
  String get monthly_subscription => '月費';

  @override
  String get yearly_subscription => '年費';

  @override
  String get lifetime_subscription => '買斷';

  @override
  String get lifetime_purchase => '永久授權';

  @override
  String trial_subscription_expires_in(int days) {
    return '免費試用剩餘$days天';
  }

  @override
  String get restore_purchases => '復原購買';

  @override
  String current_plan(String planName) {
    return '$planName';
  }

  @override
  String free_trial_days(int days) {
    return '先享$days天免費試用';
  }

  @override
  String get monthly_price => '月';

  @override
  String get yearly_price => '年';

  @override
  String get upgrade_to_premium_description => '升級至高級版方案，解鎖所有功能！';

  @override
  String get unlock_all_widgets_title => '解鎖所有小工具';

  @override
  String get unlock_all_widgets_description => '可從多種小工具樣式中選擇';

  @override
  String get access_all_future_features_title => '存取所有未來功能';

  @override
  String get access_all_future_features_description => '新功能推出後立即可用';

  @override
  String get support_the_developer_title => '支持開發者';

  @override
  String get support_the_developer_description => '支持持續開發';

  @override
  String get lifetime_unlock_description => '一次購買解鎖所有功能';

  @override
  String get lifetime_license_activated => '已取得永久授權';

  @override
  String get currently_subscribed => '訂閱中';

  @override
  String get refresh => '重新整理';

  @override
  String get no_projects_found => '找不到專案';

  @override
  String get error_loading_projects => '載入專案失敗';

  @override
  String get retry => '重試';

  @override
  String get start_free_trial => '開始免費試用';

  @override
  String get yearly_price_short => '年';

  @override
  String trial_ends_then_price_per_year(
      Object trialDays, Object priceString, Object yearlyPriceShort) {
    return '$trialDays天免費試用結束後 $priceString / $yearlyPriceShort';
  }

  @override
  String get continue_purchase => '繼續購買';

  @override
  String get change_plan => '變更方案';

  @override
  String current_plan_display(Object currentPlanName) {
    return '目前方案：$currentPlanName';
  }

  @override
  String get terms_of_service => '使用條款';

  @override
  String get privacy_policy => '隱私權政策';

  @override
  String get purchase_terms_and_conditions_part3 =>
      '訂閱可隨時取消。\n免費試用僅適用於首次購買。\n變更訂閱方案時，將在目前方案結束後自動切換。';

  @override
  String get switchToLifetimeNotificationBody =>
      '如果您已購買訂閱方案，請至 App Store / Google Play 帳戶設定中停止自動續訂。';

  @override
  String get subscription_purchase_success_title => '已取得永久授權！';

  @override
  String get subscription_purchase_success_body => '您已經購買了買斷方案';

  @override
  String get account_settings_title => '帳戶';

  @override
  String get free_plan => '免費方案';

  @override
  String get premium_plan => '已加入高級版方案';

  @override
  String get plan_title => '方案';

  @override
  String get copy_notion_link => '複製 Notion 連結';

  @override
  String get copy_title => '複製標題';

  @override
  String get open_in_notion => '在 Notion 中開啟';

  @override
  String get duplicate => '複製';

  @override
  String get copy => '複製';

  @override
  String get notion_link_copied => '已複製 Notion 連結';

  @override
  String get title_copied => '已複製標題';

  @override
  String get task_duplicated => '已複製任務';

  @override
  String get error_no_notion_link => '找不到 Notion 連結';

  @override
  String get error_copy_failed => '複製失敗';

  @override
  String get error_cannot_open_notion => '無法在 Notion 中開啟';

  @override
  String get error_duplicate_failed => '任務複製失敗';

  @override
  String get no_project_selected => '未選擇專案';

  @override
  String get select_project => '選擇專案';
}
