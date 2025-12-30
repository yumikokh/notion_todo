// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'notion_todo';

  @override
  String get settings_view_title => 'Paramètres';

  @override
  String get settings_view_app_settings_title => 'Paramètres de l\'application';

  @override
  String get settings_view_notion_settings_title => 'Paramètres Notion';

  @override
  String get settings_view_notion_settings_description =>
      'Les paramètres de base de données sont requis';

  @override
  String get settings_view_theme_settings_title => 'Thème';

  @override
  String get settings_view_support_title => 'Support';

  @override
  String get settings_view_support_faq_title => 'FAQ';

  @override
  String get settings_view_support_feedback_title =>
      'Signaler un bug・Demande・Contact';

  @override
  String get settings_view_support_privacy_policy_title =>
      'Politique de confidentialité';

  @override
  String get settings_view_support_review_title => 'Soutenir avec un avis';

  @override
  String get settings_view_version_title => 'Version';

  @override
  String get settings_view_version_copy => 'Informations de version copiées';

  @override
  String get notion_settings_view_title => 'Paramètres Notion';

  @override
  String get notion_settings_view_auth_status => 'État de l\'authentification';

  @override
  String get notion_settings_view_auth_status_connected => 'Connecté à Notion';

  @override
  String get notion_settings_view_auth_status_disconnected =>
      'Déconnecté de Notion';

  @override
  String get notion_settings_view_auth_status_disconnect =>
      'Se déconnecter de Notion';

  @override
  String get notion_settings_view_auth_status_connect =>
      'Se connecter à Notion';

  @override
  String get notion_settings_view_database_settings_title =>
      'Paramètres de base de données';

  @override
  String get notion_settings_view_database_settings_description =>
      'Si le nom ou le type de la propriété correspondante change, une reconfiguration est nécessaire';

  @override
  String get notion_settings_view_database_settings_database_name =>
      'Nom de la base de données';

  @override
  String get notion_settings_view_database_settings_change_database_settings =>
      'Modifier les paramètres de base de données';

  @override
  String get task_database_settings_title =>
      'Paramètres de base de données des tâches';

  @override
  String get database => 'Base de données';

  @override
  String get status_property => 'Statut';

  @override
  String get status_property_todo_option => 'Option À faire';

  @override
  String get status_property_in_progress_option => 'Option En cours';

  @override
  String get status_property_complete_option => 'Option Terminé';

  @override
  String get date_property => 'Date';

  @override
  String get todo_option_description => 'Statut pour non terminé';

  @override
  String get in_progress_option_description => 'Statut pour en cours';

  @override
  String get complete_option_description => 'Statut pour terminé';

  @override
  String get status_property_description => 'Type : Statut, Case à cocher';

  @override
  String get date_property_description => 'Type : Date';

  @override
  String get save => 'Enregistrer';

  @override
  String get not_found_database => 'Aucune base de données accessible trouvée.';

  @override
  String get not_found_database_description =>
      'Veuillez réinitialiser les paramètres.';

  @override
  String get notion_reconnect => 'Se reconnecter à Notion';

  @override
  String get select => 'Sélectionner';

  @override
  String get create_property => 'Créer une propriété';

  @override
  String get property_name => 'Nom de la propriété';

  @override
  String get property_name_input => 'Entrez le nom de la propriété';

  @override
  String get property_name_error =>
      'Une propriété avec le même nom existe déjà';

  @override
  String property_added_success(String propertyName, String name) {
    return 'La propriété $propertyName \"$name\" a été ajoutée';
  }

  @override
  String get error => 'Erreur';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get new_create => 'Créer';

  @override
  String get language_settings_title => 'Paramètres de langue';

  @override
  String get language_settings_description =>
      'Définir la langue de l\'application';

  @override
  String get language_settings_language => 'Langue';

  @override
  String get navigation_index => 'Index';

  @override
  String get navigation_today => 'Aujourd\'hui';

  @override
  String get task_sheet_title_hint => 'Entrez le nom de la tâche';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get yesterday => 'Hier';

  @override
  String get tomorrow => 'Demain';

  @override
  String get undetermined => 'Non défini';

  @override
  String get select_date => 'Sélectionner une date';

  @override
  String get no_task => 'Aucune tâche trouvée';

  @override
  String get no_task_description =>
      'Excellent travail !\nPassez une bonne journée.';

  @override
  String add_task_success(String title) {
    return '\"$title\" ajouté.';
  }

  @override
  String task_add_failed(String title) {
    return 'Échec de l\'ajout de \"$title\"';
  }

  @override
  String task_update_success(String title) {
    return '\"$title\" mis à jour.';
  }

  @override
  String task_update_failed(String title) {
    return 'Échec de la mise à jour de \"$title\"';
  }

  @override
  String task_update_status_success(String title) {
    return '\"$title\" terminé 🎉';
  }

  @override
  String task_update_status_undo(String title) {
    return '\"$title\" marqué comme non terminé';
  }

  @override
  String get task_update_status_failed => 'Échec de la mise à jour du statut';

  @override
  String task_delete_success(String title) {
    return '\"$title\" supprimé';
  }

  @override
  String task_delete_undo(String title) {
    return '\"$title\" restauré.';
  }

  @override
  String task_delete_failed(String title) {
    return 'Échec de la suppression de \"$title\"';
  }

  @override
  String task_delete_failed_undo(String title) {
    return 'Échec de la restauration de \"$title\"';
  }

  @override
  String get loading_failed => 'Échec du chargement';

  @override
  String get re_set_database => 'Une reconfiguration est nécessaire.';

  @override
  String get not_found_property => 'Aucune propriété appropriée trouvée.';

  @override
  String get task_fetch_failed => 'Échec de la récupération des tâches';

  @override
  String get load_more => 'Charger plus';

  @override
  String get wakelock_title =>
      'Empêcher la mise en veille pendant l\'exécution de l\'application';

  @override
  String get wakelock_description =>
      'La consommation de batterie peut être affectée.';

  @override
  String get notion_settings_view_not_found_database_description =>
      'Vous n\'avez pas encore de base de données ?';

  @override
  String get notion_settings_view_not_found_database_template_description =>
      'Sélectionnez \"Utiliser un modèle fourni\" (bouton ci-dessus) lors de l\'authentification pour obtenir une base de données de gestion des tâches prête à l\'emploi !';

  @override
  String get notion_settings_view_not_found_database_select_description =>
      'Si vous avez déjà votre propre base de données, choisissez \"Sélectionner les pages à partager\" (bouton ci-dessous) pour l\'utiliser.';

  @override
  String get go_to_settings => 'Aller aux paramètres';

  @override
  String get notion_database_settings_required =>
      'Les paramètres de base de données Notion sont requis.';

  @override
  String updateMessage(String version) {
    return 'Mis à jour vers v$version ✨';
  }

  @override
  String get releaseNote => 'Détails';

  @override
  String get settings_view_support_release_notes_title => 'Notes de version';

  @override
  String get font_settings => 'Style de police du titre';

  @override
  String get font_language => 'Langue de la police';

  @override
  String get font_family => 'Famille de police';

  @override
  String get italic => 'Italique';

  @override
  String get font_size => 'Taille de police';

  @override
  String get letter_spacing => 'Espacement des lettres';

  @override
  String get preview => 'Aperçu';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get reset_to_default => 'Réinitialiser par défaut';

  @override
  String get bold => 'Gras';

  @override
  String get appearance_settings_title => 'Apparence';

  @override
  String get hide_navigation_label_title =>
      'Masquer les étiquettes de navigation';

  @override
  String get hide_navigation_label_description =>
      'Masquer les étiquettes dans la barre de navigation inférieure';

  @override
  String get font_settings_description =>
      'Personnaliser le titre de date de la liste des tâches du jour';

  @override
  String current_setting(String setting) {
    return 'Actuel : $setting';
  }

  @override
  String task_update_status_in_progress(String title) {
    return '\"$title\" marqué comme en cours';
  }

  @override
  String task_update_status_todo(String title) {
    return '\"$title\" marqué comme à faire';
  }

  @override
  String get task_star_button_dialog_title => 'Option En cours non définie';

  @override
  String get task_star_button_dialog_content =>
      'Configurez l\'option En cours dans les paramètres de base de données pour suivre ce sur quoi vous devez vous concentrer !';

  @override
  String get task_star_button_dialog_cancel => 'Annuler';

  @override
  String get task_star_button_dialog_settings => 'Paramètres';

  @override
  String get notifications => 'Notifications';

  @override
  String get showNotificationBadge => 'Afficher le badge de notification';

  @override
  String get select_time => 'Sélectionner l\'heure';

  @override
  String get no_time => 'Pas d\'heure';

  @override
  String get start_time => 'Heure de début';

  @override
  String get duration => 'Durée';

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
  String get reschedule => 'Reprogrammer';

  @override
  String get continuous_task_addition_title => 'Ajout continu de tâches';

  @override
  String get continuous_task_addition_description =>
      'Permettre l\'ajout continu de tâches';

  @override
  String get behavior_settings_title => 'Comportement';

  @override
  String get task_completion_sound_title => 'Son de complétion de tâche';

  @override
  String get task_completion_sound_description =>
      'Jouer un son lorsqu\'une tâche est terminée';

  @override
  String get sound_settings_title => 'Son de complétion de tâche';

  @override
  String get sound_enabled => 'Activer le son';

  @override
  String get sound_enabled_description =>
      'Jouer un son lorsqu\'une tâche est terminée';

  @override
  String get morning_message =>
      'Une nouvelle journée commence.\nPar quoi souhaitez-vous commencer ?';

  @override
  String get afternoon_message =>
      'Bon après-midi !\nPar quoi souhaitez-vous commencer ?';

  @override
  String get evening_message =>
      'Bonsoir.\nQu\'aimeriez-vous accomplir aujourd\'hui ?';

  @override
  String get licenses_page_title => 'Licences';

  @override
  String get licenses_page_no_licenses =>
      'Aucune information de licence disponible.';

  @override
  String get sound_credit_title => 'Crédit sonore';

  @override
  String get sound_credit_description => 'OtoLogic (CC BY 4.0)';

  @override
  String get priority_property => 'Priorité';

  @override
  String get priority_property_description => 'Type : Sélection';

  @override
  String get checkbox_property => 'Case à cocher';

  @override
  String get project_property => 'Projet';

  @override
  String get project_property_description => 'Type : Relation';

  @override
  String get project_property_empty_message =>
      'Si les projets ne s\'affichent pas, veuillez vous ré-authentifier avec Notion en incluant la base de données cible';

  @override
  String get title_property => 'Titre';

  @override
  String get task_priority_dialog_title => 'Propriété de priorité non définie';

  @override
  String get task_priority_dialog_content =>
      'Configurez la propriété de priorité dans les paramètres de base de données pour prioriser vos tâches !';

  @override
  String get task_priority_dialog_cancel => 'Annuler';

  @override
  String get task_priority_dialog_settings => 'Paramètres';

  @override
  String get show_completed_tasks => 'Afficher les tâches terminées';

  @override
  String get completed_tasks => 'Terminées';

  @override
  String get sort_by => 'Trier par';

  @override
  String get sort_by_default => 'Par défaut';

  @override
  String get group_by => 'Grouper par';

  @override
  String get group_by_none => 'Aucun';

  @override
  String no_property(String property) {
    return 'Aucun(e) $property';
  }

  @override
  String get subscription_fetch_failed =>
      'Échec de la récupération des informations d\'abonnement';

  @override
  String subscription_purchase_success(String plan) {
    return 'Plan $plan acheté avec succès';
  }

  @override
  String get subscription_purchase_failed => 'L\'achat a échoué';

  @override
  String get subscription_purchase_error_general =>
      'Une erreur s\'est produite lors de l\'achat.';

  @override
  String get subscription_restore_success => 'Achats restaurés avec succès';

  @override
  String get subscription_restore_failed =>
      'Échec de la restauration des achats';

  @override
  String get subscription_restore_none => 'Aucun achat à restaurer';

  @override
  String get subscription_restore_error_general =>
      'Une erreur s\'est produite lors de la restauration des achats.';

  @override
  String get premium_features_title => 'Premium';

  @override
  String get monthly_subscription => 'Mensuel';

  @override
  String get yearly_subscription => 'Annuel';

  @override
  String get lifetime_subscription => 'À vie';

  @override
  String get lifetime_purchase => 'Licence permanente';

  @override
  String trial_subscription_expires_in(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'L\'essai expire dans $days jours',
      one: 'L\'essai expire dans 1 jour',
    );
    return '$_temp0';
  }

  @override
  String get restore_purchases => 'Restaurer les achats';

  @override
  String current_plan(String planName) {
    return '$planName';
  }

  @override
  String free_trial_days(int days) {
    return 'Essai gratuit de $days jours';
  }

  @override
  String get monthly_price => 'mois';

  @override
  String get yearly_price => 'an';

  @override
  String get upgrade_to_premium_description =>
      'Passez à Premium et débloquez toutes les fonctionnalités !';

  @override
  String get unlock_all_widgets_title => 'Débloquer tous les widgets';

  @override
  String get unlock_all_widgets_description =>
      'Choisissez parmi plusieurs styles de widgets.';

  @override
  String get access_all_future_features_title =>
      'Accès à toutes les futures fonctionnalités';

  @override
  String get access_all_future_features_description =>
      'Obtenez les nouvelles fonctionnalités dès qu\'elles sont ajoutées.';

  @override
  String get support_the_developer_title => 'Soutenir le développeur';

  @override
  String get support_the_developer_description =>
      'Aidez à soutenir le développement continu.';

  @override
  String get lifetime_unlock_description =>
      'Achat unique pour débloquer toutes les fonctionnalités';

  @override
  String get lifetime_license_activated => 'Licence à vie activée';

  @override
  String get currently_subscribed => 'Actuellement abonné';

  @override
  String get refresh => 'Actualiser';

  @override
  String get no_projects_found => 'Aucun projet trouvé';

  @override
  String get error_loading_projects => 'Échec du chargement des projets';

  @override
  String get retry => 'Réessayer';

  @override
  String get start_free_trial => 'Commencer l\'essai gratuit';

  @override
  String get yearly_price_short => 'an';

  @override
  String trial_ends_then_price_per_year(
    Object trialDays,
    Object priceString,
    Object yearlyPriceShort,
  ) {
    return 'Après $trialDays jours d\'essai gratuit, puis $priceString / $yearlyPriceShort';
  }

  @override
  String get continue_purchase => 'Continuer l\'achat';

  @override
  String get change_plan => 'Changer de plan';

  @override
  String current_plan_display(Object currentPlanName) {
    return 'Plan actuel : $currentPlanName';
  }

  @override
  String get terms_of_service => 'Conditions d\'utilisation';

  @override
  String get privacy_policy => 'Politique de confidentialité';

  @override
  String get purchase_terms_and_conditions_part3 =>
      '.\nLes abonnements peuvent être annulés à tout moment.\nL\'essai gratuit n\'est applicable que pour le premier achat.\nLors du changement de plan, le changement s\'effectuera automatiquement après la fin du plan actuel.';

  @override
  String get switchToLifetimeNotificationBody =>
      'Si vous êtes abonné à un plan mensuel ou annuel, n\'oubliez pas d\'annuler son renouvellement automatique depuis les paramètres de votre compte App Store / Google Play.';

  @override
  String get subscription_purchase_success_title =>
      'Vous avez obtenu le plan À vie !';

  @override
  String get subscription_purchase_success_body =>
      'Vous avez déjà un plan à vie !';

  @override
  String get account_settings_title => 'Compte';

  @override
  String get free_plan => 'Plan gratuit';

  @override
  String get premium_plan => 'Plan Premium actif';

  @override
  String get plan_title => 'Plan';

  @override
  String get copy_notion_link => 'Copier le lien Notion';

  @override
  String get copy_title => 'Copier le titre';

  @override
  String get open_in_notion => 'Ouvrir dans Notion';

  @override
  String get duplicate => 'Dupliquer';

  @override
  String get copy => 'Copier';

  @override
  String get notion_link_copied => 'Lien Notion copié';

  @override
  String get title_copied => 'Titre copié';

  @override
  String get task_duplicated => 'Tâche dupliquée';

  @override
  String get error_no_notion_link => 'Lien Notion introuvable';

  @override
  String get error_copy_failed => 'La copie a échoué';

  @override
  String get error_cannot_open_notion => 'Impossible d\'ouvrir dans Notion';

  @override
  String get error_duplicate_failed => 'Échec de la duplication de la tâche';

  @override
  String get no_project_selected => 'Aucun projet sélectionné';

  @override
  String get select_project => 'Sélectionner un projet';
}
