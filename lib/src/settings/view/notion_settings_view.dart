import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notion/model/index.dart';
import '../../notion/oauth/notion_oauth_viewmodel.dart';
import '../../notion/task_database/task_database_viewmodel.dart';
import '../../notion/task_database/view/task_database_setting_page.dart';

class NotionSettingsView extends ConsumerWidget {
  static const routeName = '/settings/notion';

  const NotionSettingsView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final notionOAuth = ref.read(notionOAuthViewModelProvider.notifier);
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final taskDatabaseViewModel =
        ref.watch(taskDatabaseViewModelProvider.notifier);
    final taskDatabase =
        ref.watch(taskDatabaseViewModelProvider).valueOrNull?.taskDatabase;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notion Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [
            isAuthenticated
                ? const Text('Authenticated ✅')
                : const Text('Not Authenticated'),
            ElevatedButton(
              onPressed: () async {
                await notionOAuth.authenticate();
                await taskDatabaseViewModel.fetchDatabases();
              },
              child: isAuthenticated
                  ? const Text('Re-authenticate')
                  : const Text('Authenticate'),
            ),
            if (isAuthenticated)
              ElevatedButton(
                onPressed: () async {
                  await notionOAuth.deauthenticate();
                  taskDatabaseViewModel.clear();
                },
                child: const Text('Deauthenticate'),
              ),
            if (taskDatabase != null)
              Column(
                children: [
                  const Text('Task Database'),
                  Text(taskDatabase.name),
                  const Text('Status Property'),
                  Text(taskDatabase.status.name),
                  const Text('Date Property'),
                  Text(taskDatabase.date.name),
                ],
              ),
            if (taskDatabase?.status.type == PropertyType.status &&
                (taskDatabase?.status as StatusTaskStatusProperty)
                        .todoOption
                        ?.name !=
                    null)
              Column(
                children: [
                  const Text('To-do Option'),
                  Text((taskDatabase?.status as StatusTaskStatusProperty)
                          .todoOption
                          ?.name ??
                      'None'),
                  const Text('Complete Option'),
                  Text((taskDatabase?.status as StatusTaskStatusProperty)
                          .completeOption
                          ?.name ??
                      'None'),
                ],
              ),
            if (isAuthenticated)
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pushNamed(TaskDatabaseSettingPage.routeName);
                  await taskDatabaseViewModel.fetchDatabases();
                },
                child: const Text('Task Database Settings'),
              ),
          ],
        ),
      ),
    );
  }
}
