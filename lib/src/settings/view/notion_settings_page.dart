import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tanzaku_todo/src/helpers/haptic_helper.dart';

import '../../notion/model/index.dart';
import '../../notion/oauth/notion_oauth_viewmodel.dart';
import '../task_database/task_database_viewmodel.dart';
import '../task_database/view/task_database_setting_page.dart';

class NotionSettingsPage extends ConsumerWidget {
  static const routeName = '/settings/notion';

  const NotionSettingsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final notionOAuth = ref.watch(notionOAuthViewModelProvider.notifier);
    final isAuthenticated =
        ref.watch(notionOAuthViewModelProvider).valueOrNull?.isAuthenticated ??
            false;
    final taskDatabaseViewModel =
        ref.watch(taskDatabaseViewModelProvider.notifier);
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).valueOrNull;
    final statusProperty = taskDatabase?.status;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.notion_settings_view_title,
            style: const TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card.outlined(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.notion_settings_view_auth_status,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (isAuthenticated) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          const SizedBox(width: 8),
                          Text(l.notion_settings_view_auth_status_connected),
                        ],
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: () async {
                          await notionOAuth.deauthenticate();
                          taskDatabaseViewModel.clear();
                          HapticHelper.light();
                        },
                        icon: const Icon(Icons.link_off),
                        label:
                            Text(l.notion_settings_view_auth_status_disconnect),
                      ),
                    ],
                    if (!isAuthenticated) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.warning_rounded,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(width: 8),
                          Text(l.notion_settings_view_auth_status_disconnected),
                        ],
                      ),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: () async {
                          await notionOAuth.authenticate();
                          HapticHelper.light();
                        },
                        icon: const Icon(Icons.link),
                        label: Text(l.notion_settings_view_auth_status_connect),
                      )
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (isAuthenticated)
              Card.outlined(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            l.notion_settings_view_database_settings_title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Tooltip(
                            message: l
                                .notion_settings_view_database_settings_description,
                            triggerMode: TooltipTriggerMode.tap,
                            preferBelow: false,
                            verticalOffset: 14,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Icon(
                              Icons.warning_amber_rounded,
                              size: 22,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (taskDatabase != null) ...[
                        _buildInfoTile(
                            l.notion_settings_view_database_settings_database_name,
                            taskDatabase.name),
                        _buildInfoTile(
                            l.status_property, taskDatabase.status.name),
                        if (statusProperty is StatusCompleteStatusProperty) ...[
                          _buildInfoTile(
                            l.status_property_todo_option,
                            statusProperty.todoOption?.name ?? 'None',
                          ),
                          _buildInfoTile(
                            l.status_property_in_progress_option,
                            statusProperty.inProgressOption?.name ?? 'None',
                          ),
                          _buildInfoTile(
                            l.status_property_complete_option,
                            statusProperty.completeOption?.name ?? 'None',
                          ),
                        ],
                        _buildInfoTile(l.date_property, taskDatabase.date.name),
                        if (taskDatabase.priority != null)
                          _buildInfoTile(
                              l.priority_property, taskDatabase.priority!.name),
                        const SizedBox(height: 16),
                      ],
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(TaskDatabaseSettingPage.routeName);
                            HapticHelper.light();
                          },
                          icon: const Icon(Icons.settings),
                          label: Text(l
                              .notion_settings_view_database_settings_change_database_settings),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (!isAuthenticated) ...[
              Card.outlined(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.info_rounded),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l.notion_settings_view_not_found_database_description,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l.notion_settings_view_not_found_database_template_description,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l.notion_settings_view_not_found_database_select_description,
                      ),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/database_select.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontSize: 14)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16)),
    );
  }
}
