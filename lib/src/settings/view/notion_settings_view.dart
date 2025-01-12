import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../notion/model/index.dart';
import '../../notion/oauth/notion_oauth_viewmodel.dart';
import '../task_database/task_database_viewmodel.dart';
import '../task_database/view/task_database_setting_page.dart';

class NotionSettingsView extends ConsumerWidget {
  static const routeName = '/settings/notion';

  const NotionSettingsView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final notionOAuth = ref.read(notionOAuthViewModelProvider.notifier);
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final taskDatabaseViewModel =
        ref.watch(taskDatabaseViewModelProvider.notifier);
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).valueOrNull;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        title: Text(l.notion_settings_view_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card.outlined(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
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
                        if (taskDatabase.status.type ==
                            PropertyType.status) ...[
                          _buildInfoTile(
                            l.status_property_todo_option,
                            (taskDatabase.status as StatusTaskStatusProperty)
                                    .todoOption
                                    ?.name ??
                                'None',
                          ),
                          _buildInfoTile(
                            l.status_property_complete_option,
                            (taskDatabase.status as StatusTaskStatusProperty)
                                    .completeOption
                                    ?.name ??
                                'None',
                          ),
                        ],
                        _buildInfoTile(l.date_property, taskDatabase.date.name),
                        const SizedBox(height: 16),
                      ],
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(TaskDatabaseSettingPage.routeName);
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
            const SizedBox(height: 16),
            Card.outlined(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                        Text(
                          l.notion_settings_view_not_found_database_description,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l.notion_settings_view_not_found_database_template_description,
                    ),
                    const SizedBox(height: 8),
                    FilledButton.icon(
                      onPressed: () async {
                        const url =
                            'https://www.notion.so/templates/simple-gtd-planner';
                        await launchUrl(Uri.parse(url));
                      },
                      icon: const Icon(Icons.open_in_new),
                      label: Text(
                          l.notion_settings_view_not_found_database_template),
                    ),
                  ],
                ),
              ),
            ),
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
