// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'notion_todo';

  @override
  String get settings_view_title => 'Ajustes';

  @override
  String get settings_view_app_settings_title => 'Configuración de la App';

  @override
  String get settings_view_notion_settings_title => 'Configuración de Notion';

  @override
  String get settings_view_notion_settings_description =>
      'Se requiere configuración de base de datos';

  @override
  String get settings_view_theme_settings_title => 'Tema';

  @override
  String get settings_view_support_title => 'Soporte';

  @override
  String get settings_view_support_faq_title => 'Preguntas Frecuentes';

  @override
  String get settings_view_support_feedback_title =>
      'Reportar Error・Solicitud・Contacto';

  @override
  String get settings_view_support_privacy_policy_title =>
      'Política de Privacidad';

  @override
  String get settings_view_support_review_title => 'Apóyanos con una Reseña';

  @override
  String get settings_view_version_title => 'Versión';

  @override
  String get settings_view_version_copy => 'Información de versión copiada';

  @override
  String get notion_settings_view_title => 'Configuración de Notion';

  @override
  String get notion_settings_view_auth_status => 'Estado de Autenticación';

  @override
  String get notion_settings_view_auth_status_connected => 'Conectado a Notion';

  @override
  String get notion_settings_view_auth_status_disconnected =>
      'Desconectado de Notion';

  @override
  String get notion_settings_view_auth_status_disconnect =>
      'Desconectar de Notion';

  @override
  String get notion_settings_view_auth_status_connect => 'Conectar a Notion';

  @override
  String get notion_settings_view_database_settings_title =>
      'Configuración de Base de Datos';

  @override
  String get notion_settings_view_database_settings_description =>
      'Si cambia el nombre o tipo de la propiedad correspondiente, es necesario reconfigurar';

  @override
  String get notion_settings_view_database_settings_database_name =>
      'Nombre de Base de Datos';

  @override
  String get notion_settings_view_database_settings_change_database_settings =>
      'Cambiar Configuración de Base de Datos';

  @override
  String get task_database_settings_title =>
      'Configuración de Base de Datos de Tareas';

  @override
  String get database => 'Base de Datos';

  @override
  String get status_property => 'Estado';

  @override
  String get status_property_todo_option => 'Opción Por Hacer';

  @override
  String get status_property_in_progress_option => 'Opción En Progreso';

  @override
  String get status_property_complete_option => 'Opción Completado';

  @override
  String get date_property => 'Fecha';

  @override
  String get todo_option_description => 'Estado para no completado';

  @override
  String get in_progress_option_description => 'Estado para en progreso';

  @override
  String get complete_option_description => 'Estado para completado';

  @override
  String get status_property_description => 'Tipo: Estado, Casilla';

  @override
  String get date_property_description => 'Tipo: Fecha';

  @override
  String get save => 'Guardar';

  @override
  String get not_found_database => 'No se encontró base de datos accesible.';

  @override
  String get not_found_database_description =>
      'Por favor, reconfigure los ajustes.';

  @override
  String get notion_reconnect => 'Reconectar a Notion';

  @override
  String get select => 'Seleccionar';

  @override
  String get create_property => 'Crear Propiedad';

  @override
  String get property_name => 'Nombre de Propiedad';

  @override
  String get property_name_input => 'Ingrese el nombre de la propiedad';

  @override
  String get property_name_error =>
      'Ya existe una propiedad con el mismo nombre';

  @override
  String property_added_success(String propertyName, String name) {
    return 'Propiedad $propertyName \"$name\" ha sido añadida';
  }

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get new_create => 'Crear';

  @override
  String get language_settings_title => 'Configuración de Idioma';

  @override
  String get language_settings_description =>
      'Establecer el idioma de la aplicación';

  @override
  String get language_settings_language => 'Idioma';

  @override
  String get navigation_index => 'Índice';

  @override
  String get navigation_today => 'Hoy';

  @override
  String get task_sheet_title_hint => 'Ingrese el nombre de la tarea';

  @override
  String get today => 'Hoy';

  @override
  String get yesterday => 'Ayer';

  @override
  String get tomorrow => 'Mañana';

  @override
  String get undetermined => 'Sin determinar';

  @override
  String get select_date => 'Seleccionar Fecha';

  @override
  String get no_task => 'No hay tareas';

  @override
  String get no_task_description =>
      '¡Excelente trabajo!\nQue tengas un buen día.';

  @override
  String add_task_success(String title) {
    return '\"$title\" añadida.';
  }

  @override
  String task_add_failed(String title) {
    return 'Error al añadir \"$title\"';
  }

  @override
  String task_update_success(String title) {
    return '\"$title\" actualizada.';
  }

  @override
  String task_update_failed(String title) {
    return 'Error al actualizar \"$title\"';
  }

  @override
  String task_update_status_success(String title) {
    return '\"$title\" completada 🎉';
  }

  @override
  String task_update_status_undo(String title) {
    return '\"$title\" marcada como incompleta';
  }

  @override
  String get task_update_status_failed => 'Error al actualizar estado';

  @override
  String task_delete_success(String title) {
    return '\"$title\" eliminada';
  }

  @override
  String task_delete_undo(String title) {
    return '\"$title\" restaurada.';
  }

  @override
  String task_delete_failed(String title) {
    return 'Error al eliminar \"$title\"';
  }

  @override
  String task_delete_failed_undo(String title) {
    return 'Error al restaurar';
  }

  @override
  String get loading_failed => 'Error al cargar';

  @override
  String get re_set_database => 'Se requiere reconfiguración.';

  @override
  String get not_found_property => 'No se encontró propiedad apropiada.';

  @override
  String get task_fetch_failed => 'Error al obtener tareas';

  @override
  String get load_more => 'Cargar Más';

  @override
  String get wakelock_title =>
      'Evitar suspensión mientras la app está en ejecución';

  @override
  String get wakelock_description =>
      'El consumo de batería puede verse afectado.';

  @override
  String get notion_settings_view_not_found_database_description =>
      '¿Aún no tienes una base de datos?';

  @override
  String get notion_settings_view_not_found_database_template_description =>
      '¡Selecciona \"Usar una plantilla proporcionada\" (botón arriba) durante la autenticación para obtener una base de datos de gestión de tareas lista para usar!';

  @override
  String get notion_settings_view_not_found_database_select_description =>
      'Si ya tienes tu propia base de datos, elige \"Seleccionar páginas para compartir\" (botón abajo) para usarla.';

  @override
  String get go_to_settings => 'Ir a Configuración';

  @override
  String get notion_database_settings_required =>
      'Se requiere configuración de base de datos de Notion.';

  @override
  String updateMessage(String version) {
    return 'Actualizado a v$version ✨';
  }

  @override
  String get releaseNote => 'Detalles';

  @override
  String get settings_view_support_release_notes_title => 'Notas de Versión';

  @override
  String get font_settings => 'Estilo de Fuente del Título';

  @override
  String get font_language => 'Idioma de Fuente';

  @override
  String get font_family => 'Familia de Fuente';

  @override
  String get italic => 'Cursiva';

  @override
  String get font_size => 'Tamaño de Fuente';

  @override
  String get letter_spacing => 'Espaciado de Letras';

  @override
  String get preview => 'Vista Previa';

  @override
  String get reset => 'Restablecer';

  @override
  String get reset_to_default => 'Restablecer a Predeterminado';

  @override
  String get bold => 'Negrita';

  @override
  String get appearance_settings_title => 'Apariencia';

  @override
  String get hide_navigation_label_title => 'Ocultar Etiquetas de Navegación';

  @override
  String get hide_navigation_label_description =>
      'Ocultar etiquetas en la barra de navegación inferior';

  @override
  String get font_settings_description =>
      'Personalizar el título de fecha de la lista de tareas de hoy';

  @override
  String current_setting(String setting) {
    return 'Actual: $setting';
  }

  @override
  String task_update_status_in_progress(String title) {
    return '\"$title\" marcada como en progreso';
  }

  @override
  String task_update_status_todo(String title) {
    return '\"$title\" marcada como por hacer';
  }

  @override
  String get task_star_button_dialog_title =>
      'Opción En Progreso No Configurada';

  @override
  String get task_star_button_dialog_content =>
      '¡Configure la opción En Progreso en la configuración de base de datos para rastrear en qué debe enfocarse!';

  @override
  String get task_star_button_dialog_cancel => 'Cancelar';

  @override
  String get task_star_button_dialog_settings => 'Configuración';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get showNotificationBadge => 'Mostrar insignia de notificación';

  @override
  String get select_time => 'Seleccionar hora';

  @override
  String get no_time => 'Sin hora';

  @override
  String get start_time => 'Hora de inicio';

  @override
  String get duration => 'Duración';

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
  String get reschedule => 'Reprogramar';

  @override
  String get continuous_task_addition_title => 'Adición Continua de Tareas';

  @override
  String get continuous_task_addition_description =>
      'Permitir adición continua de tareas';

  @override
  String get behavior_settings_title => 'Comportamiento';

  @override
  String get task_completion_sound_title => 'Sonido al Completar Tarea';

  @override
  String get task_completion_sound_description =>
      'Reproducir sonido cuando se completa una tarea';

  @override
  String get sound_settings_title => 'Sonido al Completar Tarea';

  @override
  String get sound_enabled => 'Habilitar Sonido';

  @override
  String get sound_enabled_description =>
      'Reproducir sonido cuando se completa una tarea';

  @override
  String get morning_message =>
      'Comienza un nuevo día.\n¿Con qué te gustaría empezar?';

  @override
  String get afternoon_message =>
      '¡Buenas tardes!\n¿Con qué te gustaría empezar?';

  @override
  String get evening_message => 'Buenas noches.\n¿Qué te gustaría lograr hoy?';

  @override
  String get licenses_page_title => 'Licencias';

  @override
  String get licenses_page_no_licenses =>
      'No hay información de licencia disponible.';

  @override
  String get sound_credit_title => 'Crédito de Sonido';

  @override
  String get sound_credit_description => 'OtoLogic (CC BY 4.0)';

  @override
  String get priority_property => 'Prioridad';

  @override
  String get priority_property_description => 'Tipo: Selección';

  @override
  String get checkbox_property => 'Casilla';

  @override
  String get project_property => 'Proyecto';

  @override
  String get project_property_description => 'Tipo: Relación';

  @override
  String get project_property_empty_message =>
      'Si los proyectos no se muestran, vuelva a autenticarse con Notion incluyendo la base de datos de destino';

  @override
  String get title_property => 'Título';

  @override
  String get task_priority_dialog_title =>
      'Propiedad de Prioridad No Configurada';

  @override
  String get task_priority_dialog_content =>
      '¡Configure la propiedad de Prioridad en la configuración de base de datos para priorizar sus tareas!';

  @override
  String get task_priority_dialog_cancel => 'Cancelar';

  @override
  String get task_priority_dialog_settings => 'Configuración';

  @override
  String get show_completed_tasks => 'Mostrar Tareas Completadas';

  @override
  String get completed_tasks => 'Completadas';

  @override
  String get sort_by => 'Ordenar por';

  @override
  String get sort_by_default => 'Predeterminado';

  @override
  String get group_by => 'Agrupar por';

  @override
  String get group_by_none => 'Ninguno';

  @override
  String no_property(String property) {
    return 'Sin $property';
  }

  @override
  String get subscription_fetch_failed =>
      'Error al obtener información de suscripción';

  @override
  String subscription_purchase_success(String plan) {
    return 'Plan $plan comprado exitosamente';
  }

  @override
  String get subscription_purchase_failed => 'Compra fallida';

  @override
  String get subscription_purchase_error_general =>
      'Ocurrió un error durante la compra.';

  @override
  String get subscription_restore_success => 'Compras restauradas exitosamente';

  @override
  String get subscription_restore_failed => 'Error al restaurar compras';

  @override
  String get subscription_restore_none => 'No hay compras para restaurar';

  @override
  String get subscription_restore_error_general =>
      'Ocurrió un error al restaurar las compras.';

  @override
  String get premium_features_title => 'Premium';

  @override
  String get monthly_subscription => 'Mensual';

  @override
  String get yearly_subscription => 'Anual';

  @override
  String get lifetime_subscription => 'De por vida';

  @override
  String get lifetime_purchase => 'Licencia Permanente';

  @override
  String trial_subscription_expires_in(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'La prueba expira en $days días',
      one: 'La prueba expira en 1 día',
    );
    return '$_temp0';
  }

  @override
  String get restore_purchases => 'Restaurar Compras';

  @override
  String current_plan(String planName) {
    return '$planName';
  }

  @override
  String free_trial_days(int days) {
    return 'Primeros $days días de prueba gratis';
  }

  @override
  String get monthly_price => 'mes';

  @override
  String get yearly_price => 'año';

  @override
  String get upgrade_to_premium_description =>
      '¡Actualiza a Premium y desbloquea todas las funciones!';

  @override
  String get unlock_all_widgets_title => 'Desbloquear Todos los Widgets';

  @override
  String get unlock_all_widgets_description =>
      'Elige entre múltiples estilos de widgets.';

  @override
  String get access_all_future_features_title =>
      'Acceso a Todas las Funciones Futuras';

  @override
  String get access_all_future_features_description =>
      'Obtén nuevas funciones tan pronto como se agreguen.';

  @override
  String get support_the_developer_title => 'Apoyar al Desarrollador';

  @override
  String get support_the_developer_description =>
      'Ayuda a apoyar el desarrollo continuo.';

  @override
  String get lifetime_unlock_description =>
      'Compra única para desbloquear todas las funciones';

  @override
  String get lifetime_license_activated => 'Licencia de Por Vida Activada';

  @override
  String get currently_subscribed => 'Actualmente Suscrito';

  @override
  String get refresh => 'Actualizar';

  @override
  String get no_projects_found => 'No se encontraron proyectos';

  @override
  String get error_loading_projects => 'Error al cargar proyectos';

  @override
  String get retry => 'Reintentar';

  @override
  String get start_free_trial => 'Iniciar Prueba Gratuita';

  @override
  String get yearly_price_short => 'año';

  @override
  String trial_ends_then_price_per_year(
      Object trialDays, Object priceString, Object yearlyPriceShort) {
    return 'Después de $trialDays días de prueba gratuita, luego $priceString / $yearlyPriceShort';
  }

  @override
  String get continue_purchase => 'Continuar Compra';

  @override
  String get change_plan => 'Cambiar Plan';

  @override
  String current_plan_display(Object currentPlanName) {
    return 'Plan Actual: $currentPlanName';
  }

  @override
  String get terms_of_service => 'Términos de Servicio';

  @override
  String get privacy_policy => 'Política de Privacidad';

  @override
  String get purchase_terms_and_conditions_part3 =>
      'Las suscripciones se pueden cancelar en cualquier momento.\nLa prueba gratuita es aplicable solo para la primera compra.\nAl cambiar de plan, el cambio ocurrirá automáticamente después de que termine el plan actual.';

  @override
  String get switchToLifetimeNotificationBody =>
      'Si está suscrito a un plan mensual o anual, recuerde cancelar su renovación automática desde la configuración de su cuenta de App Store / Google Play.';

  @override
  String get subscription_purchase_success_title =>
      '¡Obtuviste el plan de por vida!';

  @override
  String get subscription_purchase_success_body =>
      '¡Ya tienes un plan de por vida!';

  @override
  String get account_settings_title => 'Cuenta';

  @override
  String get free_plan => 'Plan Gratuito';

  @override
  String get premium_plan => 'Plan Premium Activo';

  @override
  String get plan_title => 'Plan';

  @override
  String get copy_notion_link => 'Copiar Enlace de Notion';

  @override
  String get copy_title => 'Copiar Título';

  @override
  String get open_in_notion => 'Abrir en Notion';

  @override
  String get duplicate => 'Duplicar';

  @override
  String get copy => 'Copiar';

  @override
  String get notion_link_copied => 'Enlace de Notion copiado';

  @override
  String get title_copied => 'Título copiado';

  @override
  String get task_duplicated => 'Tarea duplicada';

  @override
  String get error_no_notion_link => 'Enlace de Notion no encontrado';

  @override
  String get error_copy_failed => 'Error al copiar';

  @override
  String get error_cannot_open_notion => 'No se puede abrir en Notion';

  @override
  String get error_duplicate_failed => 'Error al duplicar tarea';

  @override
  String get no_project_selected => 'No hay proyecto seleccionado';

  @override
  String get select_project => 'Seleccionar un proyecto';
}
