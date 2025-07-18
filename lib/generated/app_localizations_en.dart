// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'notion_todo';

  @override
  String get settings_view_title => 'Settings';

  @override
  String get settings_view_app_settings_title => 'App Settings';

  @override
  String get settings_view_notion_settings_title => 'Notion Settings';

  @override
  String get settings_view_notion_settings_description =>
      'Database settings are required';

  @override
  String get settings_view_theme_settings_title => 'Theme';

  @override
  String get settings_view_support_title => 'Support';

  @override
  String get settings_view_support_faq_title => 'FAQ';

  @override
  String get settings_view_support_feedback_title =>
      'Bug Report・Request・Contact';

  @override
  String get settings_view_support_privacy_policy_title => 'Privacy Policy';

  @override
  String get settings_view_support_review_title => 'Support with a Review';

  @override
  String get settings_view_version_title => 'Version';

  @override
  String get settings_view_version_copy => 'Version information copied';

  @override
  String get notion_settings_view_title => 'Notion Settings';

  @override
  String get notion_settings_view_auth_status => 'Authentication Status';

  @override
  String get notion_settings_view_auth_status_connected =>
      'Connected to Notion';

  @override
  String get notion_settings_view_auth_status_disconnected =>
      'Disconnected from Notion';

  @override
  String get notion_settings_view_auth_status_disconnect =>
      'Disconnect from Notion';

  @override
  String get notion_settings_view_auth_status_connect => 'Connect to Notion';

  @override
  String get notion_settings_view_database_settings_title =>
      'Database Settings';

  @override
  String get notion_settings_view_database_settings_description =>
      'If the name or type of the corresponding property changes, re-setting is required';

  @override
  String get notion_settings_view_database_settings_database_name =>
      'Database Name';

  @override
  String get notion_settings_view_database_settings_change_database_settings =>
      'Change Database Settings';

  @override
  String get task_database_settings_title => 'Task Database Settings';

  @override
  String get database => 'Database';

  @override
  String get status_property => 'Status';

  @override
  String get status_property_todo_option => 'To-do Option';

  @override
  String get status_property_in_progress_option => 'In Progress Option';

  @override
  String get status_property_complete_option => 'Complete Option';

  @override
  String get date_property => 'Date';

  @override
  String get todo_option_description => 'Status for not completed';

  @override
  String get in_progress_option_description => 'Status for in progress';

  @override
  String get complete_option_description => 'Status for completed';

  @override
  String get status_property_description => 'Type: Status, Checkbox';

  @override
  String get date_property_description => 'Type: Date';

  @override
  String get save => 'Save';

  @override
  String get not_found_database => 'No accessible database found.';

  @override
  String get not_found_database_description => 'Please reset the settings.';

  @override
  String get notion_reconnect => 'Reconnect to Notion';

  @override
  String get select => 'Select';

  @override
  String get create_property => 'Create Property';

  @override
  String get property_name => 'Property Name';

  @override
  String get property_name_input => 'Enter the property name';

  @override
  String get property_name_error =>
      'A property with the same name already exists';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get new_create => 'Create';

  @override
  String get language_settings_title => 'Language Settings';

  @override
  String get language_settings_description => 'Set the language of the app';

  @override
  String get language_settings_language => 'Language';

  @override
  String get language_settings_language_ja => 'Japanese';

  @override
  String get language_settings_language_en => 'English';

  @override
  String get navigation_index => 'Index';

  @override
  String get navigation_today => 'Today';

  @override
  String get task_sheet_title_hint => 'Enter the task name';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get undetermined => 'Not set';

  @override
  String get select_date => 'Select Date';

  @override
  String get no_task => 'No task found';

  @override
  String get no_task_description => 'Excellent job!\nHave a good day.';

  @override
  String add_task_success(String title) {
    return '\"$title\" Added.';
  }

  @override
  String task_add_failed(String title) {
    return 'Failed to add \"$title\"';
  }

  @override
  String task_update_success(String title) {
    return '\"$title\" Updated.';
  }

  @override
  String task_update_failed(String title) {
    return 'Failed to update \"$title\"';
  }

  @override
  String task_update_status_success(String title) {
    return '\"$title\" completed 🎉';
  }

  @override
  String task_update_status_undo(String title) {
    return '\"$title\" marked as incomplete';
  }

  @override
  String get task_update_status_failed => 'Failed to update status';

  @override
  String task_delete_success(String title) {
    return '\"$title\" deleted';
  }

  @override
  String task_delete_undo(String title) {
    return '\"$title\" Restored.';
  }

  @override
  String task_delete_failed(String title) {
    return 'Failed to delete \"$title\"';
  }

  @override
  String task_delete_failed_undo(String title) {
    return 'Failed to restore \"$title\"';
  }

  @override
  String get loading_failed => 'Failed to load';

  @override
  String get re_set_database => 'Re-setting is required.';

  @override
  String get not_found_property => 'No appropriate property found.';

  @override
  String get task_fetch_failed => 'Failed to fetch tasks';

  @override
  String get load_more => 'Load More';

  @override
  String get wakelock_title => 'Prevent sleep while the app is running';

  @override
  String get wakelock_description => 'Battery consumption may be affected.';

  @override
  String get notion_settings_view_not_found_database_description =>
      'Don\'t have a database yet?';

  @override
  String get notion_settings_view_not_found_database_template_description =>
      'Select \"Use a template provided\" (button above) during authentication to get a ready-to-use task management database!';

  @override
  String get notion_settings_view_not_found_database_select_description =>
      'If you already have your own database, choose \"Select pages to share\" (button below) to use it.';

  @override
  String get go_to_settings => 'Go to Settings';

  @override
  String get notion_database_settings_required =>
      'Notion database settings are required.';

  @override
  String updateMessage(String version) {
    return 'Updated to v$version ✨';
  }

  @override
  String get releaseNote => 'Details';

  @override
  String get settings_view_support_release_notes_title => 'Release Notes';

  @override
  String get font_settings => 'Title Font Style';

  @override
  String get font_language => 'Font Language';

  @override
  String get font_family => 'Font Family';

  @override
  String get italic => 'Italic';

  @override
  String get font_size => 'Font Size';

  @override
  String get letter_spacing => 'Letter Spacing';

  @override
  String get preview => 'Preview';

  @override
  String get reset => 'Reset';

  @override
  String get reset_to_default => 'Reset to Default';

  @override
  String get bold => 'Bold';

  @override
  String get appearance_settings_title => 'Appearance';

  @override
  String get hide_navigation_label_title => 'Hide Navigation Labels';

  @override
  String get hide_navigation_label_description =>
      'Hide labels in the bottom navigation bar';

  @override
  String get font_settings_description =>
      'Customize the date title of the today task list';

  @override
  String current_setting(String setting) {
    return 'Current: $setting';
  }

  @override
  String task_update_status_in_progress(String title) {
    return '\"$title\" marked as in progress';
  }

  @override
  String task_update_status_todo(String title) {
    return '\"$title\" marked as to-do';
  }

  @override
  String get task_star_button_dialog_title => 'In Progress Option Not Set';

  @override
  String get task_star_button_dialog_content =>
      'Set up the In Progress option in database settings to track what you should focus on!';

  @override
  String get task_star_button_dialog_cancel => 'Cancel';

  @override
  String get task_star_button_dialog_settings => 'Settings';

  @override
  String get notifications => 'Notifications';

  @override
  String get showNotificationBadge => 'Show notification badge';

  @override
  String get select_time => 'Select time';

  @override
  String get no_time => 'No time';

  @override
  String get start_time => 'Start time';

  @override
  String get duration => 'Duration';

  @override
  String duration_format_minutes(int minutes) {
    return '${minutes}min';
  }

  @override
  String duration_format_hours(int hours) {
    return '${hours}h';
  }

  @override
  String duration_format_hours_minutes(int hours, int minutes) {
    return '${hours}h ${minutes}min';
  }

  @override
  String get reschedule => 'Reschedule';

  @override
  String get continuous_task_addition_title => 'Continuous Task Addition';

  @override
  String get continuous_task_addition_description =>
      'Allow continuous task addition';

  @override
  String get behavior_settings_title => 'Behavior';

  @override
  String get task_completion_sound_title => 'Task Completion Sound';

  @override
  String get task_completion_sound_description =>
      'Play a sound when a task is completed';

  @override
  String get sound_settings_title => 'Task Completion Sound';

  @override
  String get sound_enabled => 'Enable Sound';

  @override
  String get sound_enabled_description =>
      'Play a sound when a task is completed';

  @override
  String get morning_message =>
      'A new day begins.\nWhat would you like to start with?';

  @override
  String get afternoon_message =>
      'Good afternoon!\nWhat would you like to start with?';

  @override
  String get evening_message =>
      'Good evening.\nWhat would you like to accomplish today?';

  @override
  String get licenses_page_title => 'Licenses';

  @override
  String get licenses_page_no_licenses => 'No license information available.';

  @override
  String get sound_credit_title => 'Sound Credit';

  @override
  String get sound_credit_description => 'OtoLogic (CC BY 4.0)';

  @override
  String get priority_property => 'Priority';

  @override
  String get priority_property_description => 'Type: Select';

  @override
  String get project_property => 'Project';

  @override
  String get project_property_description => 'Type: Relation';

  @override
  String get project_property_empty_message =>
      'If projects are not displayed, please re-authenticate with Notion including the target database';

  @override
  String get title_property => 'Title';

  @override
  String get task_priority_dialog_title => 'Priority Property Not Set';

  @override
  String get task_priority_dialog_content =>
      'Set up the Priority property in database settings to prioritize your tasks!';

  @override
  String get task_priority_dialog_cancel => 'Cancel';

  @override
  String get task_priority_dialog_settings => 'Settings';

  @override
  String get show_completed_tasks => 'Show Completed Tasks';

  @override
  String get completed_tasks => 'Completed';

  @override
  String get sort_by => 'Sort by';

  @override
  String get sort_by_default => 'Default';

  @override
  String get group_by => 'Group by';

  @override
  String get group_by_none => 'None';

  @override
  String no_property(String property) {
    return 'No $property';
  }

  @override
  String get subscription_fetch_failed =>
      'Failed to fetch subscription information';

  @override
  String subscription_purchase_success(String plan) {
    return 'Successfully purchased $plan plan';
  }

  @override
  String get subscription_purchase_failed => 'Purchase failed';

  @override
  String get subscription_purchase_error_general =>
      'An error occurred during purchase.';

  @override
  String get subscription_restore_success => 'Purchases restored successfully';

  @override
  String get subscription_restore_failed => 'Failed to restore purchases';

  @override
  String get subscription_restore_none => 'No purchases to restore';

  @override
  String get subscription_restore_error_general =>
      'An error occurred while restoring purchases.';

  @override
  String get premium_features_title => 'Premium';

  @override
  String get monthly_subscription => 'Monthly';

  @override
  String get yearly_subscription => 'Yearly';

  @override
  String get lifetime_subscription => 'Lifetime';

  @override
  String get lifetime_purchase => 'Permanent License';

  @override
  String trial_subscription_expires_in(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Trial expires in $days days',
      one: 'Trial expires in 1 day',
    );
    return '$_temp0';
  }

  @override
  String get restore_purchases => 'Restore Purchases';

  @override
  String current_plan(String planName) {
    return '$planName';
  }

  @override
  String free_trial_days(int days) {
    return 'First $days days free trial';
  }

  @override
  String get monthly_price => 'month';

  @override
  String get yearly_price => 'year';

  @override
  String get upgrade_to_premium_description =>
      'Upgrade to Premium and unlock all features!';

  @override
  String get unlock_all_widgets_title => 'Unlock All Widgets';

  @override
  String get unlock_all_widgets_description =>
      'Choose from multiple widget styles.';

  @override
  String get access_all_future_features_title =>
      'Access to All Future Features';

  @override
  String get access_all_future_features_description =>
      'Get new features as soon as they are added.';

  @override
  String get support_the_developer_title => 'Support the Developer';

  @override
  String get support_the_developer_description =>
      'Help support continued development.';

  @override
  String get lifetime_unlock_description =>
      'One-time purchase to unlock all features';

  @override
  String get lifetime_license_activated => 'Lifetime License Activated';

  @override
  String get currently_subscribed => 'Currently Subscribed';

  @override
  String get refresh => 'Refresh';

  @override
  String get no_projects_found => 'No projects found';

  @override
  String get error_loading_projects => 'Failed to load projects';

  @override
  String get retry => 'Retry';

  @override
  String get start_free_trial => 'Start Free Trial';

  @override
  String get yearly_price_short => 'year';

  @override
  String trial_ends_then_price_per_year(
      Object trialDays, Object priceString, Object yearlyPriceShort) {
    return 'After $trialDays-day free trial, then $priceString / $yearlyPriceShort';
  }

  @override
  String get continue_purchase => 'Continue Purchase';

  @override
  String get change_plan => 'Change Plan';

  @override
  String current_plan_display(Object currentPlanName) {
    return 'Current Plan: $currentPlanName';
  }

  @override
  String get terms_of_service => 'Terms of Service';

  @override
  String get privacy_policy => 'Privacy Policy';

  @override
  String get purchase_terms_and_conditions_part3 =>
      '.\nSubscriptions can be canceled at any time.\nThe free trial is applicable only for the first purchase.\nWhen changing plans, the switch will occur automatically after the current plan ends.';

  @override
  String get switchToLifetimeNotificationBody =>
      'If you are subscribed to a monthly or yearly plan, please remember to cancel its auto-renewal from your App Store / Google Play account settings.';

  @override
  String get subscription_purchase_success_title =>
      'You got the Lifetime plan!';

  @override
  String get subscription_purchase_success_body =>
      'You already have a lifetime plan!';

  @override
  String get account_settings_title => 'Account';

  @override
  String get free_plan => 'Free Plan';

  @override
  String get premium_plan => 'Premium Plan Active';

  @override
  String get plan_title => 'Plan';

  @override
  String get no_project_selected => 'No project selected';

  @override
  String get select_project => 'Select a project';
}
