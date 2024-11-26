import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../notion/model/property.dart';
import '../task_database_setting_viewmodel.dart';
import '../task_database_viewmodel.dart';

class TaskDatabaseSettingPage extends HookConsumerWidget {
  const TaskDatabaseSettingPage({super.key});

  static const routeName = '/settings/task_database';

  @override
  Widget build(BuildContext context, ref) {
    final taskDatabaseViewModel =
        ref.watch(taskDatabaseViewModelProvider.notifier);
    final accessibleDatabases = ref.watch(accessibleDatabasesProvider);
    final selectedDatabase =
        ref.watch(selectedDatabaseViewModelProvider).valueOrNull;
    final selectedDatabaseViewModel =
        ref.watch(selectedDatabaseViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Database Settings'),
      ),
      body: accessibleDatabases.when(
        data: (accessibleDatabases) => accessibleDatabases.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // データベース選択セクション
                    _buildSectionTitle('データベース'),
                    const SizedBox(height: 8),
                    _buildDropdown(
                      value: selectedDatabase?.id,
                      items: accessibleDatabases
                          .map((db) => DropdownMenuItem(
                              value: db.id, child: Text(db.name)))
                          .toList(),
                      onChanged: (value) =>
                          selectedDatabaseViewModel.selectDatabase(value),
                    ),
                    const SizedBox(height: 32),

                    if (selectedDatabase != null) ...[
                      // ステータスプロパティセクション
                      _buildSectionTitle('ステータスプロパティ'),
                      const SizedBox(height: 8),
                      _buildDropdown(
                        value: selectedDatabase.status?.id,
                        items: selectedDatabaseViewModel
                            .propertyOptions(SettingPropertyType.status)
                            .map((prop) => DropdownMenuItem(
                                value: prop.id, child: Text(prop.name)))
                            .toList(),
                        onChanged: (value) => selectedDatabaseViewModel
                            .selectProperty(value, SettingPropertyType.status),
                      ),
                      const SizedBox(height: 24),

                      // StatusTaskStatusPropertyの場合のみ表示
                      if (selectedDatabase.status?.type ==
                          PropertyType.status) ...[
                        _buildSectionTitle('To-doオプション'),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: (selectedDatabase.status
                                  as StatusTaskStatusProperty)
                              .todoOption
                              ?.id,
                          items: _buildStatusOptions(selectedDatabase, 'To-do'),
                          onChanged: (value) => selectedDatabaseViewModel
                              .selectStatusOption(value, 'To-do'),
                        ),
                        const SizedBox(height: 24),
                        _buildSectionTitle('Completeオプション'),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: (selectedDatabase.status
                                  as StatusTaskStatusProperty)
                              .completeOption
                              ?.id,
                          items:
                              _buildStatusOptions(selectedDatabase, 'Complete'),
                          onChanged: (value) => selectedDatabaseViewModel
                              .selectStatusOption(value, 'Complete'),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // 日付プロパティセクション
                      _buildSectionTitle('日付プロパティ'),
                      const SizedBox(height: 8),
                      _buildDropdown(
                        value: selectedDatabase.date?.id,
                        items: selectedDatabaseViewModel
                            .propertyOptions(SettingPropertyType.date)
                            .map((prop) => DropdownMenuItem(
                                value: prop.id, child: Text(prop.name)))
                            .toList(),
                        onChanged: (value) => selectedDatabaseViewModel
                            .selectProperty(value, SettingPropertyType.date),
                      ),
                      const SizedBox(height: 48),
                    ],

                    // 保存ボタン
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          if (selectedDatabase == null) {
                            return;
                          }
                          taskDatabaseViewModel.save(selectedDatabase);
                          // taskDatabaseSettingViewModel.clear();
                          Navigator.of(context).pop();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text('保存'),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButton<String>(
        value: value,
        items: items,
        onChanged: onChanged,
        isExpanded: true,
        underline: const SizedBox.shrink(),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildStatusOptions(
      SelectedDatabaseState state, String groupName) {
    return (state.status as StatusTaskStatusProperty)
        .status
        .groups
        .firstWhere((group) => group.name == groupName)
        .option_ids
        .map((id) => DropdownMenuItem<String>(
              value: id,
              child: Text((state.status as StatusTaskStatusProperty)
                  .status
                  .options
                  .firstWhere((option) => option.id == id)
                  .name),
            ))
        .toList();
  }
}
