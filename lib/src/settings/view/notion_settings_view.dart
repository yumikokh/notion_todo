import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notion Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '認証状態',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (isAuthenticated) ...[
                      ListTile(
                        leading: Icon(
                          Icons.check_circle_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: const Text('Notionに接続されています'),
                        dense: true,
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: () async {
                          await notionOAuth.deauthenticate();
                          taskDatabaseViewModel.clear();
                        },
                        icon: const Icon(Icons.link_off),
                        label: const Text('Notionの接続を解除'),
                      ),
                    ],
                    if (!isAuthenticated) ...[
                      ListTile(
                        leading: Icon(
                          Icons.warning_rounded,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        title: const Text('Notionに接続されていません'),
                        dense: true,
                      ),
                      const SizedBox(height: 8),
                      FilledButton.icon(
                        onPressed: () async {
                          await notionOAuth.authenticate();
                        },
                        icon: const Icon(Icons.link),
                        label: const Text('Notionに接続'),
                      )
                    ],
                  ],
                ),
              ),
            ),
            if (isAuthenticated) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'データベース設定',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Tooltip(
                            message: '該当プロパティの名前や種類などが変わった場合は、再設定が必要です',
                            triggerMode: TooltipTriggerMode.tap,
                            preferBelow: false,
                            showDuration: const Duration(seconds: 3),
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
                        _buildInfoTile('データベース名', taskDatabase.name),
                        _buildInfoTile('ステータスプロパティ', taskDatabase.status.name),
                        if (taskDatabase.status.type ==
                            PropertyType.status) ...[
                          _buildInfoTile(
                            'To-doオプション',
                            (taskDatabase.status as StatusTaskStatusProperty)
                                    .todoOption
                                    ?.name ??
                                'None',
                          ),
                          _buildInfoTile(
                            'Completeオプション',
                            (taskDatabase.status as StatusTaskStatusProperty)
                                    .completeOption
                                    ?.name ??
                                'None',
                          ),
                        ],
                        _buildInfoTile('日付プロパティ', taskDatabase.date.name),
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
                          label: const Text('データベース設定を変更'),
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
