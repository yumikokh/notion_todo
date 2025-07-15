// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'notion_todo';

  @override
  String get settings_view_title => '設定';

  @override
  String get settings_view_app_settings_title => 'アプリ設定';

  @override
  String get settings_view_notion_settings_title => 'Notion設定';

  @override
  String get settings_view_notion_settings_description => 'データベース設定が必要です';

  @override
  String get settings_view_theme_settings_title => 'テーマ';

  @override
  String get settings_view_support_title => 'サポート';

  @override
  String get settings_view_support_faq_title => 'よくある質問';

  @override
  String get settings_view_support_feedback_title => 'バグ報告・要望・問い合わせ';

  @override
  String get settings_view_support_privacy_policy_title => 'プライバシーポリシー';

  @override
  String get settings_view_support_review_title => 'レビューで応援する';

  @override
  String get settings_view_version_title => 'バージョン';

  @override
  String get settings_view_version_copy => 'バージョン情報をコピーしました';

  @override
  String get notion_settings_view_title => 'Notion設定';

  @override
  String get notion_settings_view_auth_status => '認証状態';

  @override
  String get notion_settings_view_auth_status_connected => 'Notionに接続されています';

  @override
  String get notion_settings_view_auth_status_disconnected =>
      'Notionに接続されていません';

  @override
  String get notion_settings_view_auth_status_disconnect => 'Notionの接続を解除';

  @override
  String get notion_settings_view_auth_status_connect => 'Notionに接続';

  @override
  String get notion_settings_view_database_settings_title => 'データベース設定';

  @override
  String get notion_settings_view_database_settings_description =>
      '該当プロパティの名前や種類などが変わった場合は、再設定が必要です';

  @override
  String get notion_settings_view_database_settings_database_name => 'データベース名';

  @override
  String get notion_settings_view_database_settings_change_database_settings =>
      'データベース設定を変更';

  @override
  String get task_database_settings_title => 'タスクデータベース設定';

  @override
  String get database => 'データベース';

  @override
  String get status_property => 'ステータス';

  @override
  String get status_property_todo_option => '未完了オプション';

  @override
  String get status_property_in_progress_option => '進行中オプション';

  @override
  String get status_property_complete_option => '完了オプション';

  @override
  String get date_property => '日付';

  @override
  String get todo_option_description => '未完了として指定するステータス';

  @override
  String get in_progress_option_description => '進行中として指定するステータス';

  @override
  String get complete_option_description => '完了として指定するステータス';

  @override
  String get status_property_description => '種類: ステータス,チェックボックス';

  @override
  String get date_property_description => '種類: 日付';

  @override
  String get save => '保存';

  @override
  String get not_found_database => 'アクセス可能なデータベースが見つかりませんでした。';

  @override
  String get not_found_database_description => '設定をやり直してください。';

  @override
  String get notion_reconnect => 'Notionに再接続';

  @override
  String get select => '選択してください';

  @override
  String get create_property => 'プロパティを作成してください';

  @override
  String get property_name => 'プロパティ名';

  @override
  String get property_name_input => 'プロパティ名を入力してください';

  @override
  String get property_name_error => 'すでに同じ名前のプロパティが存在します';

  @override
  String get error => 'エラー';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確定';

  @override
  String get new_create => '新規作成';

  @override
  String get language_settings_title => '言語設定';

  @override
  String get language_settings_description => 'アプリの言語を設定してください';

  @override
  String get language_settings_language => '言語';

  @override
  String get language_settings_language_ja => '日本語';

  @override
  String get language_settings_language_en => '英語';

  @override
  String get navigation_index => 'インデックス';

  @override
  String get navigation_today => '今日';

  @override
  String get task_sheet_title_hint => 'タスク名を入力';

  @override
  String get today => '今日';

  @override
  String get yesterday => '昨日';

  @override
  String get tomorrow => '明日';

  @override
  String get undetermined => '未定';

  @override
  String get select_date => '日付を選択';

  @override
  String get no_task => 'タスクがありません';

  @override
  String get no_task_description => 'おつかれさまでした。\nよい1日をお過ごしください！';

  @override
  String add_task_success(String title) {
    return '「$title」を追加しました';
  }

  @override
  String task_add_failed(String title) {
    return '「$title」の追加に失敗しました';
  }

  @override
  String task_update_success(String title) {
    return '「$title」を変更しました';
  }

  @override
  String task_update_failed(String title) {
    return '「$title」の変更に失敗しました';
  }

  @override
  String task_update_status_success(String title) {
    return '「$title」を完了しました 🎉';
  }

  @override
  String task_update_status_undo(String title) {
    return '「$title」を未完了に戻しました';
  }

  @override
  String get task_update_status_failed => 'ステータスの更新に失敗しました';

  @override
  String task_delete_success(String title) {
    return '「$title」を削除しました';
  }

  @override
  String task_delete_undo(String title) {
    return '「$title」を復元しました';
  }

  @override
  String task_delete_failed(String title) {
    return '「$title」の削除に失敗しました';
  }

  @override
  String task_delete_failed_undo(String title) {
    return '復元に失敗しました';
  }

  @override
  String get loading_failed => '読み込みに失敗しました';

  @override
  String get re_set_database => '再設定が必要です。';

  @override
  String get not_found_property => '適切なプロパティが見つかりませんでした。';

  @override
  String get task_fetch_failed => 'タスクの取得に失敗しました';

  @override
  String get load_more => 'もっと見る';

  @override
  String get wakelock_title => 'アプリ起動中のスリープを防ぐ';

  @override
  String get wakelock_description => 'バッテリーに影響を与える可能性があります。';

  @override
  String get notion_settings_view_not_found_database_description =>
      'データベースをまだお持ちでないですか？';

  @override
  String get notion_settings_view_not_found_database_template_description =>
      '認証時に「提供されたテンプレートを使う」（上のボタン）を選ぶと、すぐに使えるタスク管理用のデータベースが追加されます！';

  @override
  String get notion_settings_view_not_found_database_select_description =>
      'もし既にお使いのデータベースがあれば、「共有するページの選択」（下のボタン）から選んでください。';

  @override
  String get go_to_settings => '設定ページへ';

  @override
  String get notion_database_settings_required => 'Notionのデータベース設定が必要です。';

  @override
  String updateMessage(String version) {
    return 'v$version に更新されました ✨';
  }

  @override
  String get releaseNote => '詳細';

  @override
  String get settings_view_support_release_notes_title => 'リリースノート';

  @override
  String get font_settings => 'タイトルのフォントスタイル';

  @override
  String get font_language => 'フォントの言語';

  @override
  String get font_family => 'フォント';

  @override
  String get italic => 'イタリック体';

  @override
  String get font_size => 'サイズ';

  @override
  String get letter_spacing => '文字間隔';

  @override
  String get preview => 'プレビュー';

  @override
  String get reset => 'リセット';

  @override
  String get reset_to_default => 'デフォルトに戻す';

  @override
  String get bold => '太字';

  @override
  String get appearance_settings_title => '外観';

  @override
  String get hide_navigation_label_title => 'ナビゲーションラベルを非表示';

  @override
  String get hide_navigation_label_description => '下部のナビゲーションバーのラベルを非表示にします';

  @override
  String get font_settings_description => '今日のタスク一覧の日付タイトルをカスタマイズします';

  @override
  String current_setting(String setting) {
    return '現在の設定: $setting';
  }

  @override
  String task_update_status_in_progress(String title) {
    return '「$title」を進行中にしました';
  }

  @override
  String task_update_status_todo(String title) {
    return '「$title」を未完了に戻しました';
  }

  @override
  String get task_star_button_dialog_title => '進行中オプションが未設定です';

  @override
  String get task_star_button_dialog_content =>
      'データベース設定から設定して、今集中すべきタスクを確認してみましょう！';

  @override
  String get task_star_button_dialog_cancel => 'キャンセル';

  @override
  String get task_star_button_dialog_settings => '設定';

  @override
  String get notifications => '通知';

  @override
  String get showNotificationBadge => '通知バッジを表示';

  @override
  String get select_time => '時間を選択';

  @override
  String get no_time => '指定なし';

  @override
  String get start_time => '開始時間';

  @override
  String get duration => '所要時間';

  @override
  String duration_format_minutes(int minutes) {
    return '$minutes分';
  }

  @override
  String duration_format_hours(int hours) {
    return '$hours時間';
  }

  @override
  String duration_format_hours_minutes(int hours, int minutes) {
    return '$hours時間$minutes分';
  }

  @override
  String get reschedule => 'リスケジュール';

  @override
  String get continuous_task_addition_title => '連続タスク追加';

  @override
  String get continuous_task_addition_description => '連続で新規タスクを追加できるようにします';

  @override
  String get behavior_settings_title => '振る舞い';

  @override
  String get task_completion_sound_title => 'タスク完了時の音';

  @override
  String get task_completion_sound_description => 'タスク完了時に音を鳴らします';

  @override
  String get sound_settings_title => 'タスク完了時の音';

  @override
  String get sound_enabled => '音を有効にする';

  @override
  String get sound_enabled_description => 'タスク完了時に音を鳴らします';

  @override
  String get morning_message => '新しい一日の始まりです。\n何から始めますか？';

  @override
  String get afternoon_message => 'こんにちは！\n何から始めますか？';

  @override
  String get evening_message => 'こんばんは。\n今日中に取り組みたいことはありますか？';

  @override
  String get licenses_page_title => 'ライセンス';

  @override
  String get licenses_page_no_licenses => 'ライセンス情報がありません。';

  @override
  String get sound_credit_title => 'サウンド提供';

  @override
  String get sound_credit_description => 'OtoLogic (CC BY 4.0)';

  @override
  String get priority_property => '優先度';

  @override
  String get priority_property_description => '種類: セレクト';

  @override
  String get project_property => 'プロジェクト';

  @override
  String get project_property_description => '種類: セレクト';

  @override
  String get title_property => 'タイトル';

  @override
  String get task_priority_dialog_title => '優先度プロパティが未設定です';

  @override
  String get task_priority_dialog_content =>
      'タスクの優先度を設定するには、データベース設定で優先度プロパティを設定してください。';

  @override
  String get task_priority_dialog_cancel => 'キャンセル';

  @override
  String get task_priority_dialog_settings => '設定';

  @override
  String get show_completed_tasks => '完了したタスクを表示';

  @override
  String get completed_tasks => '完了済';

  @override
  String get sort_by => '並び替え';

  @override
  String get sort_by_default => 'デフォルト';

  @override
  String get group_by => 'グループ';

  @override
  String get group_by_none => 'なし';

  @override
  String no_property(String property) {
    return '$propertyなし';
  }

  @override
  String get subscription_fetch_failed => 'サブスクリプション情報の取得に失敗しました';

  @override
  String subscription_purchase_success(String plan) {
    return '$planプランを購入しました';
  }

  @override
  String get subscription_purchase_failed => '購入に失敗しました';

  @override
  String get subscription_purchase_error_general => '購入処理中にエラーが発生しました。';

  @override
  String get subscription_restore_success => '購入情報を復元しました';

  @override
  String get subscription_restore_failed => '購入情報の復元に失敗しました';

  @override
  String get subscription_restore_none => '復元可能な購入がありません';

  @override
  String get subscription_restore_error_general => '購入情報の復元中にエラーが発生しました。';

  @override
  String get premium_features_title => 'Premium';

  @override
  String get monthly_subscription => '月額';

  @override
  String get yearly_subscription => '年額';

  @override
  String get lifetime_subscription => '買い切り';

  @override
  String get lifetime_purchase => '永久ライセンス';

  @override
  String trial_subscription_expires_in(int days) {
    return '無料期間残り$days日';
  }

  @override
  String get restore_purchases => '購入を復元';

  @override
  String current_plan(String planName) {
    return '$planName';
  }

  @override
  String free_trial_days(int days) {
    return 'まずは$days日間無料で体験';
  }

  @override
  String get monthly_price => '月';

  @override
  String get yearly_price => '年';

  @override
  String get upgrade_to_premium_description =>
      'プレミアムプランへアップグレードして、すべての機能を開放しましょう！';

  @override
  String get unlock_all_widgets_title => 'すべてのウィジェットを開放';

  @override
  String get unlock_all_widgets_description => '複数のウィジェットスタイルから選べます';

  @override
  String get access_all_future_features_title => '今後追加される全機能へのアクセス';

  @override
  String get access_all_future_features_description => '新機能が追加されたらすぐに使えます';

  @override
  String get support_the_developer_title => 'デベロッパーを応援';

  @override
  String get support_the_developer_description => '継続的な開発を支援できます';

  @override
  String get lifetime_unlock_description => '1回の購入で全ての機能をアンロック';

  @override
  String get lifetime_license_activated => '永久ライセンス取得済み';

  @override
  String get currently_subscribed => '購読中';

  @override
  String get refresh => '更新';

  @override
  String get no_projects_found => 'プロジェクトが見つかりません';

  @override
  String get error_loading_projects => 'プロジェクトの読み込みに失敗しました';

  @override
  String get retry => '再試行';

  @override
  String get start_free_trial => '無料トライアルを開始';

  @override
  String get yearly_price_short => '年';

  @override
  String trial_ends_then_price_per_year(
      Object trialDays, Object priceString, Object yearlyPriceShort) {
    return '$trialDays日間の無料体験の終了後は $priceString / $yearlyPriceShort';
  }

  @override
  String get continue_purchase => '購入を続ける';

  @override
  String get change_plan => 'プランを変更';

  @override
  String current_plan_display(Object currentPlanName) {
    return '現在のプラン: $currentPlanName';
  }

  @override
  String get terms_of_service => '利用規約';

  @override
  String get privacy_policy => 'プライバシーポリシー';

  @override
  String get purchase_terms_and_conditions_part3 =>
      '定期購入はいつでもキャンセルできます。\n無料トライアルが適用されるのは、初回購入時のみです。\n定期購入プラン変更時は現在のプラン終了後に自動的に切り替わります。';

  @override
  String get switchToLifetimeNotificationBody =>
      '定期購入プランを購入済みの場合は、お手数ですがApp Store / Google Playのアカウント設定から自動更新停止をお願いいたします。';

  @override
  String get subscription_purchase_success_title => '永久ライセンスを取得しました！';

  @override
  String get subscription_purchase_success_body => '既に買い切りプランを購入済みです';

  @override
  String get account_settings_title => 'アカウント';

  @override
  String get free_plan => '無料プラン';

  @override
  String get premium_plan => 'プレミアムプラン加入済';

  @override
  String get plan_title => 'プラン';
}
