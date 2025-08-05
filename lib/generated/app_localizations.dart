import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'notion_todo'**
  String get appTitle;

  /// No description provided for @settings_view_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_view_title;

  /// No description provided for @settings_view_app_settings_title.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get settings_view_app_settings_title;

  /// No description provided for @settings_view_notion_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Notion Settings'**
  String get settings_view_notion_settings_title;

  /// No description provided for @settings_view_notion_settings_description.
  ///
  /// In en, this message translates to:
  /// **'Database settings are required'**
  String get settings_view_notion_settings_description;

  /// No description provided for @settings_view_theme_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_view_theme_settings_title;

  /// No description provided for @settings_view_support_title.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settings_view_support_title;

  /// No description provided for @settings_view_support_faq_title.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get settings_view_support_faq_title;

  /// No description provided for @settings_view_support_feedback_title.
  ///
  /// In en, this message translates to:
  /// **'Bug Report・Request・Contact'**
  String get settings_view_support_feedback_title;

  /// No description provided for @settings_view_support_privacy_policy_title.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settings_view_support_privacy_policy_title;

  /// No description provided for @settings_view_support_review_title.
  ///
  /// In en, this message translates to:
  /// **'Support with a Review'**
  String get settings_view_support_review_title;

  /// No description provided for @settings_view_version_title.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settings_view_version_title;

  /// No description provided for @settings_view_version_copy.
  ///
  /// In en, this message translates to:
  /// **'Version information copied'**
  String get settings_view_version_copy;

  /// No description provided for @notion_settings_view_title.
  ///
  /// In en, this message translates to:
  /// **'Notion Settings'**
  String get notion_settings_view_title;

  /// No description provided for @notion_settings_view_auth_status.
  ///
  /// In en, this message translates to:
  /// **'Authentication Status'**
  String get notion_settings_view_auth_status;

  /// No description provided for @notion_settings_view_auth_status_connected.
  ///
  /// In en, this message translates to:
  /// **'Connected to Notion'**
  String get notion_settings_view_auth_status_connected;

  /// No description provided for @notion_settings_view_auth_status_disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected from Notion'**
  String get notion_settings_view_auth_status_disconnected;

  /// No description provided for @notion_settings_view_auth_status_disconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect from Notion'**
  String get notion_settings_view_auth_status_disconnect;

  /// No description provided for @notion_settings_view_auth_status_connect.
  ///
  /// In en, this message translates to:
  /// **'Connect to Notion'**
  String get notion_settings_view_auth_status_connect;

  /// No description provided for @notion_settings_view_database_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Database Settings'**
  String get notion_settings_view_database_settings_title;

  /// No description provided for @notion_settings_view_database_settings_description.
  ///
  /// In en, this message translates to:
  /// **'If the name or type of the corresponding property changes, re-setting is required'**
  String get notion_settings_view_database_settings_description;

  /// No description provided for @notion_settings_view_database_settings_database_name.
  ///
  /// In en, this message translates to:
  /// **'Database Name'**
  String get notion_settings_view_database_settings_database_name;

  /// No description provided for @notion_settings_view_database_settings_change_database_settings.
  ///
  /// In en, this message translates to:
  /// **'Change Database Settings'**
  String get notion_settings_view_database_settings_change_database_settings;

  /// No description provided for @task_database_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Task Database Settings'**
  String get task_database_settings_title;

  /// No description provided for @database.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get database;

  /// No description provided for @status_property.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status_property;

  /// No description provided for @status_property_todo_option.
  ///
  /// In en, this message translates to:
  /// **'To-do Option'**
  String get status_property_todo_option;

  /// No description provided for @status_property_in_progress_option.
  ///
  /// In en, this message translates to:
  /// **'In Progress Option'**
  String get status_property_in_progress_option;

  /// No description provided for @status_property_complete_option.
  ///
  /// In en, this message translates to:
  /// **'Complete Option'**
  String get status_property_complete_option;

  /// No description provided for @date_property.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date_property;

  /// No description provided for @todo_option_description.
  ///
  /// In en, this message translates to:
  /// **'Status for not completed'**
  String get todo_option_description;

  /// No description provided for @in_progress_option_description.
  ///
  /// In en, this message translates to:
  /// **'Status for in progress'**
  String get in_progress_option_description;

  /// No description provided for @complete_option_description.
  ///
  /// In en, this message translates to:
  /// **'Status for completed'**
  String get complete_option_description;

  /// No description provided for @status_property_description.
  ///
  /// In en, this message translates to:
  /// **'Type: Status, Checkbox'**
  String get status_property_description;

  /// No description provided for @date_property_description.
  ///
  /// In en, this message translates to:
  /// **'Type: Date'**
  String get date_property_description;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @not_found_database.
  ///
  /// In en, this message translates to:
  /// **'No accessible database found.'**
  String get not_found_database;

  /// No description provided for @not_found_database_description.
  ///
  /// In en, this message translates to:
  /// **'Please reset the settings.'**
  String get not_found_database_description;

  /// No description provided for @notion_reconnect.
  ///
  /// In en, this message translates to:
  /// **'Reconnect to Notion'**
  String get notion_reconnect;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @create_property.
  ///
  /// In en, this message translates to:
  /// **'Create Property'**
  String get create_property;

  /// No description provided for @property_name.
  ///
  /// In en, this message translates to:
  /// **'Property Name'**
  String get property_name;

  /// No description provided for @property_name_input.
  ///
  /// In en, this message translates to:
  /// **'Enter the property name'**
  String get property_name_input;

  /// No description provided for @property_name_error.
  ///
  /// In en, this message translates to:
  /// **'A property with the same name already exists'**
  String get property_name_error;

  /// No description provided for @property_added_success.
  ///
  /// In en, this message translates to:
  /// **'{propertyName} property \"{name}\" has been added'**
  String property_added_success(String propertyName, String name);

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @new_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get new_create;

  /// No description provided for @language_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get language_settings_title;

  /// No description provided for @language_settings_description.
  ///
  /// In en, this message translates to:
  /// **'Set the language of the app'**
  String get language_settings_description;

  /// No description provided for @language_settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_settings_language;

  /// No description provided for @navigation_index.
  ///
  /// In en, this message translates to:
  /// **'Index'**
  String get navigation_index;

  /// No description provided for @navigation_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navigation_today;

  /// No description provided for @task_sheet_title_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter the task name'**
  String get task_sheet_title_hint;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @undetermined.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get undetermined;

  /// No description provided for @select_date.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get select_date;

  /// No description provided for @no_task.
  ///
  /// In en, this message translates to:
  /// **'No task found'**
  String get no_task;

  /// No description provided for @no_task_description.
  ///
  /// In en, this message translates to:
  /// **'Excellent job!\nHave a good day.'**
  String get no_task_description;

  /// No description provided for @add_task_success.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" Added.'**
  String add_task_success(String title);

  /// No description provided for @task_add_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add \"{title}\"'**
  String task_add_failed(String title);

  /// No description provided for @task_update_success.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" Updated.'**
  String task_update_success(String title);

  /// No description provided for @task_update_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update \"{title}\"'**
  String task_update_failed(String title);

  /// No description provided for @task_update_status_success.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" completed 🎉'**
  String task_update_status_success(String title);

  /// No description provided for @task_update_status_undo.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" marked as incomplete'**
  String task_update_status_undo(String title);

  /// No description provided for @task_update_status_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update status'**
  String get task_update_status_failed;

  /// No description provided for @task_delete_success.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" deleted'**
  String task_delete_success(String title);

  /// No description provided for @task_delete_undo.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" Restored.'**
  String task_delete_undo(String title);

  /// No description provided for @task_delete_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete \"{title}\"'**
  String task_delete_failed(String title);

  /// No description provided for @task_delete_failed_undo.
  ///
  /// In en, this message translates to:
  /// **'Failed to restore \"{title}\"'**
  String task_delete_failed_undo(String title);

  /// No description provided for @loading_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load'**
  String get loading_failed;

  /// No description provided for @re_set_database.
  ///
  /// In en, this message translates to:
  /// **'Re-setting is required.'**
  String get re_set_database;

  /// No description provided for @not_found_property.
  ///
  /// In en, this message translates to:
  /// **'No appropriate property found.'**
  String get not_found_property;

  /// No description provided for @task_fetch_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch tasks'**
  String get task_fetch_failed;

  /// No description provided for @load_more.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get load_more;

  /// No description provided for @wakelock_title.
  ///
  /// In en, this message translates to:
  /// **'Prevent sleep while the app is running'**
  String get wakelock_title;

  /// No description provided for @wakelock_description.
  ///
  /// In en, this message translates to:
  /// **'Battery consumption may be affected.'**
  String get wakelock_description;

  /// No description provided for @notion_settings_view_not_found_database_description.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have a database yet?'**
  String get notion_settings_view_not_found_database_description;

  /// No description provided for @notion_settings_view_not_found_database_template_description.
  ///
  /// In en, this message translates to:
  /// **'Select \"Use a template provided\" (button above) during authentication to get a ready-to-use task management database!'**
  String get notion_settings_view_not_found_database_template_description;

  /// No description provided for @notion_settings_view_not_found_database_select_description.
  ///
  /// In en, this message translates to:
  /// **'If you already have your own database, choose \"Select pages to share\" (button below) to use it.'**
  String get notion_settings_view_not_found_database_select_description;

  /// No description provided for @go_to_settings.
  ///
  /// In en, this message translates to:
  /// **'Go to Settings'**
  String get go_to_settings;

  /// No description provided for @notion_database_settings_required.
  ///
  /// In en, this message translates to:
  /// **'Notion database settings are required.'**
  String get notion_database_settings_required;

  /// No description provided for @updateMessage.
  ///
  /// In en, this message translates to:
  /// **'Updated to v{version} ✨'**
  String updateMessage(String version);

  /// No description provided for @releaseNote.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get releaseNote;

  /// No description provided for @settings_view_support_release_notes_title.
  ///
  /// In en, this message translates to:
  /// **'Release Notes'**
  String get settings_view_support_release_notes_title;

  /// No description provided for @font_settings.
  ///
  /// In en, this message translates to:
  /// **'Title Font Style'**
  String get font_settings;

  /// No description provided for @font_language.
  ///
  /// In en, this message translates to:
  /// **'Font Language'**
  String get font_language;

  /// No description provided for @font_family.
  ///
  /// In en, this message translates to:
  /// **'Font Family'**
  String get font_family;

  /// No description provided for @italic.
  ///
  /// In en, this message translates to:
  /// **'Italic'**
  String get italic;

  /// No description provided for @font_size.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get font_size;

  /// No description provided for @letter_spacing.
  ///
  /// In en, this message translates to:
  /// **'Letter Spacing'**
  String get letter_spacing;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @reset_to_default.
  ///
  /// In en, this message translates to:
  /// **'Reset to Default'**
  String get reset_to_default;

  /// No description provided for @bold.
  ///
  /// In en, this message translates to:
  /// **'Bold'**
  String get bold;

  /// No description provided for @appearance_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance_settings_title;

  /// No description provided for @hide_navigation_label_title.
  ///
  /// In en, this message translates to:
  /// **'Hide Navigation Labels'**
  String get hide_navigation_label_title;

  /// No description provided for @hide_navigation_label_description.
  ///
  /// In en, this message translates to:
  /// **'Hide labels in the bottom navigation bar'**
  String get hide_navigation_label_description;

  /// No description provided for @font_settings_description.
  ///
  /// In en, this message translates to:
  /// **'Customize the date title of the today task list'**
  String get font_settings_description;

  /// No description provided for @current_setting.
  ///
  /// In en, this message translates to:
  /// **'Current: {setting}'**
  String current_setting(String setting);

  /// No description provided for @task_update_status_in_progress.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" marked as in progress'**
  String task_update_status_in_progress(String title);

  /// No description provided for @task_update_status_todo.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" marked as to-do'**
  String task_update_status_todo(String title);

  /// No description provided for @task_star_button_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'In Progress Option Not Set'**
  String get task_star_button_dialog_title;

  /// No description provided for @task_star_button_dialog_content.
  ///
  /// In en, this message translates to:
  /// **'Set up the In Progress option in database settings to track what you should focus on!'**
  String get task_star_button_dialog_content;

  /// No description provided for @task_star_button_dialog_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get task_star_button_dialog_cancel;

  /// No description provided for @task_star_button_dialog_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get task_star_button_dialog_settings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @showNotificationBadge.
  ///
  /// In en, this message translates to:
  /// **'Show notification badge'**
  String get showNotificationBadge;

  /// No description provided for @select_time.
  ///
  /// In en, this message translates to:
  /// **'Select time'**
  String get select_time;

  /// No description provided for @no_time.
  ///
  /// In en, this message translates to:
  /// **'No time'**
  String get no_time;

  /// No description provided for @start_time.
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get start_time;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @duration_format_minutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes}min'**
  String duration_format_minutes(int minutes);

  /// No description provided for @duration_format_hours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String duration_format_hours(int hours);

  /// No description provided for @duration_format_hours_minutes.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}min'**
  String duration_format_hours_minutes(int hours, int minutes);

  /// No description provided for @reschedule.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get reschedule;

  /// No description provided for @continuous_task_addition_title.
  ///
  /// In en, this message translates to:
  /// **'Continuous Task Addition'**
  String get continuous_task_addition_title;

  /// No description provided for @continuous_task_addition_description.
  ///
  /// In en, this message translates to:
  /// **'Allow continuous task addition'**
  String get continuous_task_addition_description;

  /// No description provided for @behavior_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Behavior'**
  String get behavior_settings_title;

  /// No description provided for @task_completion_sound_title.
  ///
  /// In en, this message translates to:
  /// **'Task Completion Sound'**
  String get task_completion_sound_title;

  /// No description provided for @task_completion_sound_description.
  ///
  /// In en, this message translates to:
  /// **'Play a sound when a task is completed'**
  String get task_completion_sound_description;

  /// No description provided for @sound_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Task Completion Sound'**
  String get sound_settings_title;

  /// No description provided for @sound_enabled.
  ///
  /// In en, this message translates to:
  /// **'Enable Sound'**
  String get sound_enabled;

  /// No description provided for @sound_enabled_description.
  ///
  /// In en, this message translates to:
  /// **'Play a sound when a task is completed'**
  String get sound_enabled_description;

  /// No description provided for @morning_message.
  ///
  /// In en, this message translates to:
  /// **'A new day begins.\nWhat would you like to start with?'**
  String get morning_message;

  /// No description provided for @afternoon_message.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon!\nWhat would you like to start with?'**
  String get afternoon_message;

  /// No description provided for @evening_message.
  ///
  /// In en, this message translates to:
  /// **'Good evening.\nWhat would you like to accomplish today?'**
  String get evening_message;

  /// No description provided for @licenses_page_title.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses_page_title;

  /// No description provided for @licenses_page_no_licenses.
  ///
  /// In en, this message translates to:
  /// **'No license information available.'**
  String get licenses_page_no_licenses;

  /// No description provided for @sound_credit_title.
  ///
  /// In en, this message translates to:
  /// **'Sound Credit'**
  String get sound_credit_title;

  /// No description provided for @sound_credit_description.
  ///
  /// In en, this message translates to:
  /// **'OtoLogic (CC BY 4.0)'**
  String get sound_credit_description;

  /// No description provided for @priority_property.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority_property;

  /// No description provided for @priority_property_description.
  ///
  /// In en, this message translates to:
  /// **'Type: Select'**
  String get priority_property_description;

  /// No description provided for @checkbox_property.
  ///
  /// In en, this message translates to:
  /// **'Checkbox'**
  String get checkbox_property;

  /// No description provided for @project_property.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get project_property;

  /// No description provided for @project_property_description.
  ///
  /// In en, this message translates to:
  /// **'Type: Relation'**
  String get project_property_description;

  /// No description provided for @project_property_empty_message.
  ///
  /// In en, this message translates to:
  /// **'If projects are not displayed, please re-authenticate with Notion including the target database'**
  String get project_property_empty_message;

  /// No description provided for @title_property.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title_property;

  /// No description provided for @task_priority_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Priority Property Not Set'**
  String get task_priority_dialog_title;

  /// No description provided for @task_priority_dialog_content.
  ///
  /// In en, this message translates to:
  /// **'Set up the Priority property in database settings to prioritize your tasks!'**
  String get task_priority_dialog_content;

  /// No description provided for @task_priority_dialog_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get task_priority_dialog_cancel;

  /// No description provided for @task_priority_dialog_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get task_priority_dialog_settings;

  /// No description provided for @show_completed_tasks.
  ///
  /// In en, this message translates to:
  /// **'Show Completed Tasks'**
  String get show_completed_tasks;

  /// No description provided for @completed_tasks.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed_tasks;

  /// No description provided for @sort_by.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sort_by;

  /// No description provided for @sort_by_default.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get sort_by_default;

  /// No description provided for @group_by.
  ///
  /// In en, this message translates to:
  /// **'Group by'**
  String get group_by;

  /// No description provided for @group_by_none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get group_by_none;

  /// No description provided for @no_property.
  ///
  /// In en, this message translates to:
  /// **'No {property}'**
  String no_property(String property);

  /// No description provided for @subscription_fetch_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch subscription information'**
  String get subscription_fetch_failed;

  /// No description provided for @subscription_purchase_success.
  ///
  /// In en, this message translates to:
  /// **'Successfully purchased {plan} plan'**
  String subscription_purchase_success(String plan);

  /// No description provided for @subscription_purchase_failed.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed'**
  String get subscription_purchase_failed;

  /// No description provided for @subscription_purchase_error_general.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during purchase.'**
  String get subscription_purchase_error_general;

  /// No description provided for @subscription_restore_success.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored successfully'**
  String get subscription_restore_success;

  /// No description provided for @subscription_restore_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to restore purchases'**
  String get subscription_restore_failed;

  /// No description provided for @subscription_restore_none.
  ///
  /// In en, this message translates to:
  /// **'No purchases to restore'**
  String get subscription_restore_none;

  /// No description provided for @subscription_restore_error_general.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while restoring purchases.'**
  String get subscription_restore_error_general;

  /// No description provided for @premium_features_title.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium_features_title;

  /// No description provided for @monthly_subscription.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly_subscription;

  /// No description provided for @yearly_subscription.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly_subscription;

  /// No description provided for @lifetime_subscription.
  ///
  /// In en, this message translates to:
  /// **'Lifetime'**
  String get lifetime_subscription;

  /// No description provided for @lifetime_purchase.
  ///
  /// In en, this message translates to:
  /// **'Permanent License'**
  String get lifetime_purchase;

  /// No description provided for @trial_subscription_expires_in.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{Trial expires in 1 day} other{Trial expires in {days} days}}'**
  String trial_subscription_expires_in(int days);

  /// No description provided for @restore_purchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restore_purchases;

  /// No description provided for @current_plan.
  ///
  /// In en, this message translates to:
  /// **'{planName}'**
  String current_plan(String planName);

  /// No description provided for @free_trial_days.
  ///
  /// In en, this message translates to:
  /// **'First {days} days free trial'**
  String free_trial_days(int days);

  /// No description provided for @monthly_price.
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get monthly_price;

  /// No description provided for @yearly_price.
  ///
  /// In en, this message translates to:
  /// **'year'**
  String get yearly_price;

  /// No description provided for @upgrade_to_premium_description.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium and unlock all features!'**
  String get upgrade_to_premium_description;

  /// No description provided for @unlock_all_widgets_title.
  ///
  /// In en, this message translates to:
  /// **'Unlock All Widgets'**
  String get unlock_all_widgets_title;

  /// No description provided for @unlock_all_widgets_description.
  ///
  /// In en, this message translates to:
  /// **'Choose from multiple widget styles.'**
  String get unlock_all_widgets_description;

  /// No description provided for @access_all_future_features_title.
  ///
  /// In en, this message translates to:
  /// **'Access to All Future Features'**
  String get access_all_future_features_title;

  /// No description provided for @access_all_future_features_description.
  ///
  /// In en, this message translates to:
  /// **'Get new features as soon as they are added.'**
  String get access_all_future_features_description;

  /// No description provided for @support_the_developer_title.
  ///
  /// In en, this message translates to:
  /// **'Support the Developer'**
  String get support_the_developer_title;

  /// No description provided for @support_the_developer_description.
  ///
  /// In en, this message translates to:
  /// **'Help support continued development.'**
  String get support_the_developer_description;

  /// No description provided for @lifetime_unlock_description.
  ///
  /// In en, this message translates to:
  /// **'One-time purchase to unlock all features'**
  String get lifetime_unlock_description;

  /// No description provided for @lifetime_license_activated.
  ///
  /// In en, this message translates to:
  /// **'Lifetime License Activated'**
  String get lifetime_license_activated;

  /// No description provided for @currently_subscribed.
  ///
  /// In en, this message translates to:
  /// **'Currently Subscribed'**
  String get currently_subscribed;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @no_projects_found.
  ///
  /// In en, this message translates to:
  /// **'No projects found'**
  String get no_projects_found;

  /// No description provided for @error_loading_projects.
  ///
  /// In en, this message translates to:
  /// **'Failed to load projects'**
  String get error_loading_projects;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @start_free_trial.
  ///
  /// In en, this message translates to:
  /// **'Start Free Trial'**
  String get start_free_trial;

  /// No description provided for @yearly_price_short.
  ///
  /// In en, this message translates to:
  /// **'year'**
  String get yearly_price_short;

  /// No description provided for @trial_ends_then_price_per_year.
  ///
  /// In en, this message translates to:
  /// **'After {trialDays}-day free trial, then {priceString} / {yearlyPriceShort}'**
  String trial_ends_then_price_per_year(
      Object trialDays, Object priceString, Object yearlyPriceShort);

  /// No description provided for @continue_purchase.
  ///
  /// In en, this message translates to:
  /// **'Continue Purchase'**
  String get continue_purchase;

  /// No description provided for @change_plan.
  ///
  /// In en, this message translates to:
  /// **'Change Plan'**
  String get change_plan;

  /// No description provided for @current_plan_display.
  ///
  /// In en, this message translates to:
  /// **'Current Plan: {currentPlanName}'**
  String current_plan_display(Object currentPlanName);

  /// No description provided for @terms_of_service.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms_of_service;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @purchase_terms_and_conditions_part3.
  ///
  /// In en, this message translates to:
  /// **'.\nSubscriptions can be canceled at any time.\nThe free trial is applicable only for the first purchase.\nWhen changing plans, the switch will occur automatically after the current plan ends.'**
  String get purchase_terms_and_conditions_part3;

  /// No description provided for @switchToLifetimeNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'If you are subscribed to a monthly or yearly plan, please remember to cancel its auto-renewal from your App Store / Google Play account settings.'**
  String get switchToLifetimeNotificationBody;

  /// No description provided for @subscription_purchase_success_title.
  ///
  /// In en, this message translates to:
  /// **'You got the Lifetime plan!'**
  String get subscription_purchase_success_title;

  /// No description provided for @subscription_purchase_success_body.
  ///
  /// In en, this message translates to:
  /// **'You already have a lifetime plan!'**
  String get subscription_purchase_success_body;

  /// No description provided for @account_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account_settings_title;

  /// No description provided for @free_plan.
  ///
  /// In en, this message translates to:
  /// **'Free Plan'**
  String get free_plan;

  /// No description provided for @premium_plan.
  ///
  /// In en, this message translates to:
  /// **'Premium Plan Active'**
  String get premium_plan;

  /// No description provided for @plan_title.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get plan_title;

  /// No description provided for @copy_notion_link.
  ///
  /// In en, this message translates to:
  /// **'Copy Notion Link'**
  String get copy_notion_link;

  /// No description provided for @copy_title.
  ///
  /// In en, this message translates to:
  /// **'Copy Title'**
  String get copy_title;

  /// No description provided for @open_in_notion.
  ///
  /// In en, this message translates to:
  /// **'Open in Notion'**
  String get open_in_notion;

  /// No description provided for @duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicate;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @notion_link_copied.
  ///
  /// In en, this message translates to:
  /// **'Notion link copied'**
  String get notion_link_copied;

  /// No description provided for @title_copied.
  ///
  /// In en, this message translates to:
  /// **'Title copied'**
  String get title_copied;

  /// No description provided for @task_duplicated.
  ///
  /// In en, this message translates to:
  /// **'Task duplicated'**
  String get task_duplicated;

  /// No description provided for @error_no_notion_link.
  ///
  /// In en, this message translates to:
  /// **'Notion link not found'**
  String get error_no_notion_link;

  /// No description provided for @error_copy_failed.
  ///
  /// In en, this message translates to:
  /// **'Copy failed'**
  String get error_copy_failed;

  /// No description provided for @error_cannot_open_notion.
  ///
  /// In en, this message translates to:
  /// **'Cannot open in Notion'**
  String get error_cannot_open_notion;

  /// No description provided for @error_duplicate_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to duplicate task'**
  String get error_duplicate_failed;

  /// No description provided for @no_project_selected.
  ///
  /// In en, this message translates to:
  /// **'No project selected'**
  String get no_project_selected;

  /// No description provided for @select_project.
  ///
  /// In en, this message translates to:
  /// **'Select a project'**
  String get select_project;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'ja',
        'ko',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
