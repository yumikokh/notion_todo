// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'notion_todo';

  @override
  String get settings_view_title => 'Einstellungen';

  @override
  String get settings_view_app_settings_title => 'App-Einstellungen';

  @override
  String get settings_view_notion_settings_title => 'Notion-Einstellungen';

  @override
  String get settings_view_notion_settings_description =>
      'Datenbankeinstellungen sind erforderlich';

  @override
  String get settings_view_theme_settings_title => 'Design';

  @override
  String get settings_view_support_title => 'Support';

  @override
  String get settings_view_support_faq_title => 'FAQ';

  @override
  String get settings_view_support_feedback_title =>
      'Fehlerbericht・Anfrage・Kontakt';

  @override
  String get settings_view_support_privacy_policy_title =>
      'Datenschutzerklärung';

  @override
  String get settings_view_support_review_title =>
      'Mit einer Bewertung unterstützen';

  @override
  String get settings_view_version_title => 'Version';

  @override
  String get settings_view_version_copy => 'Versionsinformationen kopiert';

  @override
  String get notion_settings_view_title => 'Notion-Einstellungen';

  @override
  String get notion_settings_view_auth_status => 'Authentifizierungsstatus';

  @override
  String get notion_settings_view_auth_status_connected =>
      'Mit Notion verbunden';

  @override
  String get notion_settings_view_auth_status_disconnected =>
      'Von Notion getrennt';

  @override
  String get notion_settings_view_auth_status_disconnect =>
      'Von Notion trennen';

  @override
  String get notion_settings_view_auth_status_connect => 'Mit Notion verbinden';

  @override
  String get notion_settings_view_database_settings_title =>
      'Datenbankeinstellungen';

  @override
  String get notion_settings_view_database_settings_description =>
      'Wenn sich der Name oder Typ der entsprechenden Eigenschaft ändert, ist eine Neueinstellung erforderlich';

  @override
  String get notion_settings_view_database_settings_database_name =>
      'Datenbankname';

  @override
  String get notion_settings_view_database_settings_change_database_settings =>
      'Datenbankeinstellungen ändern';

  @override
  String get task_database_settings_title => 'Aufgaben-Datenbankeinstellungen';

  @override
  String get database => 'Datenbank';

  @override
  String get status_property => 'Status';

  @override
  String get status_property_todo_option => 'Zu erledigen-Option';

  @override
  String get status_property_in_progress_option => 'In Bearbeitung-Option';

  @override
  String get status_property_complete_option => 'Abgeschlossen-Option';

  @override
  String get date_property => 'Datum';

  @override
  String get todo_option_description => 'Status für nicht abgeschlossen';

  @override
  String get in_progress_option_description => 'Status für in Bearbeitung';

  @override
  String get complete_option_description => 'Status für abgeschlossen';

  @override
  String get status_property_description => 'Typ: Status, Checkbox';

  @override
  String get date_property_description => 'Typ: Datum';

  @override
  String get save => 'Speichern';

  @override
  String get not_found_database => 'Keine zugängliche Datenbank gefunden.';

  @override
  String get not_found_database_description =>
      'Bitte setzen Sie die Einstellungen zurück.';

  @override
  String get notion_reconnect => 'Erneut mit Notion verbinden';

  @override
  String get select => 'Auswählen';

  @override
  String get create_property => 'Eigenschaft erstellen';

  @override
  String get property_name => 'Eigenschaftsname';

  @override
  String get property_name_input => 'Geben Sie den Eigenschaftsnamen ein';

  @override
  String get property_name_error =>
      'Eine Eigenschaft mit demselben Namen existiert bereits';

  @override
  String property_added_success(String propertyName, String name) {
    return '$propertyName-Eigenschaft \"$name\" wurde hinzugefügt';
  }

  @override
  String get error => 'Fehler';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get new_create => 'Erstellen';

  @override
  String get language_settings_title => 'Spracheinstellungen';

  @override
  String get language_settings_description =>
      'Legen Sie die Sprache der App fest';

  @override
  String get language_settings_language => 'Sprache';

  @override
  String get navigation_index => 'Index';

  @override
  String get navigation_today => 'Heute';

  @override
  String get task_sheet_title_hint => 'Geben Sie den Aufgabennamen ein';

  @override
  String get today => 'Heute';

  @override
  String get yesterday => 'Gestern';

  @override
  String get tomorrow => 'Morgen';

  @override
  String get undetermined => 'Nicht festgelegt';

  @override
  String get select_date => 'Datum auswählen';

  @override
  String get no_task => 'Keine Aufgabe gefunden';

  @override
  String get no_task_description =>
      'Hervorragende Arbeit!\nHaben Sie einen schönen Tag.';

  @override
  String add_task_success(String title) {
    return '\"$title\" hinzugefügt.';
  }

  @override
  String task_add_failed(String title) {
    return 'Fehler beim Hinzufügen von \"$title\"';
  }

  @override
  String task_update_success(String title) {
    return '\"$title\" aktualisiert.';
  }

  @override
  String task_update_failed(String title) {
    return 'Fehler beim Aktualisieren von \"$title\"';
  }

  @override
  String task_update_status_success(String title) {
    return '\"$title\" abgeschlossen 🎉';
  }

  @override
  String task_update_status_undo(String title) {
    return '\"$title\" als unvollständig markiert';
  }

  @override
  String get task_update_status_failed =>
      'Fehler beim Aktualisieren des Status';

  @override
  String task_delete_success(String title) {
    return '\"$title\" gelöscht';
  }

  @override
  String task_delete_undo(String title) {
    return '\"$title\" wiederhergestellt.';
  }

  @override
  String task_delete_failed(String title) {
    return 'Fehler beim Löschen von \"$title\"';
  }

  @override
  String task_delete_failed_undo(String title) {
    return 'Fehler beim Wiederherstellen von \"$title\"';
  }

  @override
  String get loading_failed => 'Laden fehlgeschlagen';

  @override
  String get re_set_database => 'Neueinstellung erforderlich.';

  @override
  String get not_found_property => 'Keine passende Eigenschaft gefunden.';

  @override
  String get task_fetch_failed => 'Fehler beim Abrufen von Aufgaben';

  @override
  String get load_more => 'Mehr laden';

  @override
  String get wakelock_title => 'Ruhezustand verhindern, während die App läuft';

  @override
  String get wakelock_description =>
      'Der Akkuverbrauch kann beeinträchtigt werden.';

  @override
  String get notion_settings_view_not_found_database_description =>
      'Haben Sie noch keine Datenbank?';

  @override
  String get notion_settings_view_not_found_database_template_description =>
      'Wählen Sie während der Authentifizierung \"Eine bereitgestellte Vorlage verwenden\" (Schaltfläche oben), um eine einsatzbereite Aufgabenverwaltungsdatenbank zu erhalten!';

  @override
  String get notion_settings_view_not_found_database_select_description =>
      'Wenn Sie bereits eine eigene Datenbank haben, wählen Sie \"Seiten zum Teilen auswählen\" (Schaltfläche unten), um sie zu verwenden.';

  @override
  String get go_to_settings => 'Zu den Einstellungen';

  @override
  String get notion_database_settings_required =>
      'Notion-Datenbankeinstellungen sind erforderlich.';

  @override
  String updateMessage(String version) {
    return 'Auf v$version aktualisiert ✨';
  }

  @override
  String get releaseNote => 'Details';

  @override
  String get settings_view_support_release_notes_title => 'Versionshinweise';

  @override
  String get font_settings => 'Titel-Schriftstil';

  @override
  String get font_language => 'Schriftsprache';

  @override
  String get font_family => 'Schriftfamilie';

  @override
  String get italic => 'Kursiv';

  @override
  String get font_size => 'Schriftgröße';

  @override
  String get letter_spacing => 'Buchstabenabstand';

  @override
  String get preview => 'Vorschau';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get reset_to_default => 'Auf Standard zurücksetzen';

  @override
  String get bold => 'Fett';

  @override
  String get appearance_settings_title => 'Darstellung';

  @override
  String get hide_navigation_label_title =>
      'Navigationsbeschriftungen ausblenden';

  @override
  String get hide_navigation_label_description =>
      'Beschriftungen in der unteren Navigationsleiste ausblenden';

  @override
  String get font_settings_description =>
      'Passen Sie den Datumstitel der heutigen Aufgabenliste an';

  @override
  String current_setting(String setting) {
    return 'Aktuell: $setting';
  }

  @override
  String task_update_status_in_progress(String title) {
    return '\"$title\" als in Bearbeitung markiert';
  }

  @override
  String task_update_status_todo(String title) {
    return '\"$title\" als zu erledigen markiert';
  }

  @override
  String get task_star_button_dialog_title =>
      'In Bearbeitung-Option nicht festgelegt';

  @override
  String get task_star_button_dialog_content =>
      'Richten Sie die In Bearbeitung-Option in den Datenbankeinstellungen ein, um zu verfolgen, worauf Sie sich konzentrieren sollten!';

  @override
  String get task_star_button_dialog_cancel => 'Abbrechen';

  @override
  String get task_star_button_dialog_settings => 'Einstellungen';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get showNotificationBadge => 'Benachrichtigungsabzeichen anzeigen';

  @override
  String get select_time => 'Zeit auswählen';

  @override
  String get no_time => 'Keine Zeit';

  @override
  String get start_time => 'Startzeit';

  @override
  String get duration => 'Dauer';

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
  String get reschedule => 'Neu planen';

  @override
  String get continuous_task_addition_title =>
      'Kontinuierliche Aufgabenhinzufügung';

  @override
  String get continuous_task_addition_description =>
      'Kontinuierliche Aufgabenhinzufügung erlauben';

  @override
  String get behavior_settings_title => 'Verhalten';

  @override
  String get task_completion_sound_title => 'Aufgabenabschluss-Sound';

  @override
  String get task_completion_sound_description =>
      'Einen Ton abspielen, wenn eine Aufgabe abgeschlossen wird';

  @override
  String get sound_settings_title => 'Aufgabenabschluss-Sound';

  @override
  String get sound_enabled => 'Sound aktivieren';

  @override
  String get sound_enabled_description =>
      'Einen Ton abspielen, wenn eine Aufgabe abgeschlossen wird';

  @override
  String get morning_message =>
      'Ein neuer Tag beginnt.\nWomit möchten Sie anfangen?';

  @override
  String get afternoon_message => 'Guten Tag!\nWomit möchten Sie anfangen?';

  @override
  String get evening_message =>
      'Guten Abend.\nWas möchten Sie heute noch erreichen?';

  @override
  String get licenses_page_title => 'Lizenzen';

  @override
  String get licenses_page_no_licenses =>
      'Keine Lizenzinformationen verfügbar.';

  @override
  String get sound_credit_title => 'Sound-Credit';

  @override
  String get sound_credit_description => 'OtoLogic (CC BY 4.0)';

  @override
  String get priority_property => 'Priorität';

  @override
  String get priority_property_description => 'Typ: Auswahl';

  @override
  String get checkbox_property => 'Checkbox';

  @override
  String get project_property => 'Projekt';

  @override
  String get project_property_description => 'Typ: Verknüpfung';

  @override
  String get project_property_empty_message =>
      'Wenn Projekte nicht angezeigt werden, authentifizieren Sie sich bitte erneut bei Notion und schließen Sie die Zieldatenbank ein';

  @override
  String get title_property => 'Titel';

  @override
  String get task_priority_dialog_title =>
      'Prioritätseigenschaft nicht festgelegt';

  @override
  String get task_priority_dialog_content =>
      'Richten Sie die Prioritätseigenschaft in den Datenbankeinstellungen ein, um Ihre Aufgaben zu priorisieren!';

  @override
  String get task_priority_dialog_cancel => 'Abbrechen';

  @override
  String get task_priority_dialog_settings => 'Einstellungen';

  @override
  String get show_completed_tasks => 'Abgeschlossene Aufgaben anzeigen';

  @override
  String get completed_tasks => 'Abgeschlossen';

  @override
  String get sort_by => 'Sortieren nach';

  @override
  String get sort_by_default => 'Standard';

  @override
  String get group_by => 'Gruppieren nach';

  @override
  String get group_by_none => 'Keine';

  @override
  String no_property(String property) {
    return 'Keine $property';
  }

  @override
  String get subscription_fetch_failed =>
      'Fehler beim Abrufen der Abonnementinformationen';

  @override
  String subscription_purchase_success(String plan) {
    return '$plan-Plan erfolgreich erworben';
  }

  @override
  String get subscription_purchase_failed => 'Kauf fehlgeschlagen';

  @override
  String get subscription_purchase_error_general =>
      'Beim Kauf ist ein Fehler aufgetreten.';

  @override
  String get subscription_restore_success =>
      'Käufe erfolgreich wiederhergestellt';

  @override
  String get subscription_restore_failed =>
      'Fehler beim Wiederherstellen der Käufe';

  @override
  String get subscription_restore_none => 'Keine Käufe zum Wiederherstellen';

  @override
  String get subscription_restore_error_general =>
      'Beim Wiederherstellen der Käufe ist ein Fehler aufgetreten.';

  @override
  String get premium_features_title => 'Premium';

  @override
  String get monthly_subscription => 'Monatlich';

  @override
  String get yearly_subscription => 'Jährlich';

  @override
  String get lifetime_subscription => 'Lebenslang';

  @override
  String get lifetime_purchase => 'Dauerhafte Lizenz';

  @override
  String trial_subscription_expires_in(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Testversion läuft in $days Tagen ab',
      one: 'Testversion läuft in 1 Tag ab',
    );
    return '$_temp0';
  }

  @override
  String get restore_purchases => 'Käufe wiederherstellen';

  @override
  String current_plan(String planName) {
    return '$planName';
  }

  @override
  String free_trial_days(int days) {
    return 'Erste $days Tage kostenlose Testversion';
  }

  @override
  String get monthly_price => 'Monat';

  @override
  String get yearly_price => 'Jahr';

  @override
  String get upgrade_to_premium_description =>
      'Upgraden Sie auf Premium und schalten Sie alle Funktionen frei!';

  @override
  String get unlock_all_widgets_title => 'Alle Widgets freischalten';

  @override
  String get unlock_all_widgets_description =>
      'Wählen Sie aus mehreren Widget-Stilen.';

  @override
  String get access_all_future_features_title =>
      'Zugriff auf alle zukünftigen Funktionen';

  @override
  String get access_all_future_features_description =>
      'Erhalten Sie neue Funktionen, sobald sie hinzugefügt werden.';

  @override
  String get support_the_developer_title => 'Den Entwickler unterstützen';

  @override
  String get support_the_developer_description =>
      'Helfen Sie bei der Unterstützung der kontinuierlichen Entwicklung.';

  @override
  String get lifetime_unlock_description =>
      'Einmalkauf zur Freischaltung aller Funktionen';

  @override
  String get lifetime_license_activated => 'Lebenslange Lizenz aktiviert';

  @override
  String get currently_subscribed => 'Derzeit abonniert';

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get no_projects_found => 'Keine Projekte gefunden';

  @override
  String get error_loading_projects => 'Fehler beim Laden der Projekte';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get start_free_trial => 'Kostenlose Testversion starten';

  @override
  String get yearly_price_short => 'Jahr';

  @override
  String trial_ends_then_price_per_year(
      Object trialDays, Object priceString, Object yearlyPriceShort) {
    return 'Nach $trialDays-tägiger kostenloser Testversion, dann $priceString / $yearlyPriceShort';
  }

  @override
  String get continue_purchase => 'Kauf fortsetzen';

  @override
  String get change_plan => 'Plan ändern';

  @override
  String current_plan_display(Object currentPlanName) {
    return 'Aktueller Plan: $currentPlanName';
  }

  @override
  String get terms_of_service => 'Nutzungsbedingungen';

  @override
  String get privacy_policy => 'Datenschutzerklärung';

  @override
  String get purchase_terms_and_conditions_part3 =>
      '.\nAbonnements können jederzeit gekündigt werden.\nDie kostenlose Testversion gilt nur für den ersten Kauf.\nBei einem Planwechsel erfolgt die Umstellung automatisch nach Ablauf des aktuellen Plans.';

  @override
  String get switchToLifetimeNotificationBody =>
      'Wenn Sie ein Monats- oder Jahresabonnement haben, denken Sie bitte daran, die automatische Verlängerung in Ihren App Store / Google Play-Kontoeinstellungen zu kündigen.';

  @override
  String get subscription_purchase_success_title =>
      'Sie haben den Lebenslang-Plan erhalten!';

  @override
  String get subscription_purchase_success_body =>
      'Sie haben bereits einen lebenslangen Plan!';

  @override
  String get account_settings_title => 'Konto';

  @override
  String get free_plan => 'Kostenloser Plan';

  @override
  String get premium_plan => 'Premium-Plan aktiv';

  @override
  String get plan_title => 'Plan';

  @override
  String get copy_notion_link => 'Notion-Link kopieren';

  @override
  String get copy_title => 'Titel kopieren';

  @override
  String get open_in_notion => 'In Notion öffnen';

  @override
  String get duplicate => 'Duplizieren';

  @override
  String get copy => 'Kopieren';

  @override
  String get notion_link_copied => 'Notion-Link kopiert';

  @override
  String get title_copied => 'Titel kopiert';

  @override
  String get task_duplicated => 'Aufgabe dupliziert';

  @override
  String get error_no_notion_link => 'Notion-Link nicht gefunden';

  @override
  String get error_copy_failed => 'Kopieren fehlgeschlagen';

  @override
  String get error_cannot_open_notion => 'Kann nicht in Notion geöffnet werden';

  @override
  String get error_duplicate_failed => 'Fehler beim Duplizieren der Aufgabe';

  @override
  String get no_project_selected => 'Kein Projekt ausgewählt';

  @override
  String get select_project => 'Wählen Sie ein Projekt';
}
