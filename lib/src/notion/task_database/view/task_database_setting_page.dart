import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../task_database_viewmodel.dart';

class TaskDatabaseSettingPage extends HookConsumerWidget {
  const TaskDatabaseSettingPage({super.key});

  static const routeName = '/settings/task_database';

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(taskDatabaseViewModelProvider);
    final taskDatabaseViewModel =
        ref.watch(taskDatabaseViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Database Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Database'),
            // プルダウンでデータベース選択
            DropdownButton<String>(
              // state.databasesにtaskDatabaseがある場合はそのidを初期値に設定
              value: state.selectedTaskDatabase?.id,
              onChanged: (String? newValue) {
                // データベース選択時の処理
                if (newValue != null) {
                  taskDatabaseViewModel.selectDatabase(newValue);
                }
              },
              items: state.databases
                  .map((dynamic database) => DropdownMenuItem<String>(
                        value: database.id,
                        child: Text(database.name),
                      ))
                  .toList(),
            ),
            if (state.taskDatabase != null)
              Column(
                children: [
                  const Text('Status Property'),
                  // プルダウンでステータスプロパティ選択
                  DropdownButton<String>(
                    value: state.selectedTaskDatabase?.statusId,
                    onChanged: (String? newValue) {
                      // ステータスプロパティ選択時の処理
                      if (newValue != null) {
                        taskDatabaseViewModel.selectProperty(
                            newValue, SettingPropertyType.status);
                      }
                    },
                    items: taskDatabaseViewModel
                        .propertyOptions(SettingPropertyType.status)
                        .map((dynamic property) => DropdownMenuItem<String>(
                              value: property.id,
                              child: Text(property.name),
                            ))
                        .toList(),
                  ),
                  const Text('Date Property'),
                  // プルダウンで日付プロパティ選択
                  DropdownButton<String>(
                    value: state.selectedTaskDatabase?.dateId,
                    onChanged: (String? newValue) {
                      // 日付プロパティ選択時の処理
                      if (newValue != null) {
                        taskDatabaseViewModel.selectProperty(
                            newValue, SettingPropertyType.date);
                      }
                    },
                    items: taskDatabaseViewModel
                        .propertyOptions(SettingPropertyType.date)
                        .map((dynamic property) => DropdownMenuItem<String>(
                              value: property.id,
                              child: Text(property.name),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                // データベース設定保存時の処理
                taskDatabaseViewModel.save();
                // 設定画面に戻る
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
