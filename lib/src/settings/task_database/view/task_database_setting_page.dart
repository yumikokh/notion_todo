import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../notion/model/property.dart';
import '../../../notion/oauth/notion_oauth_viewmodel.dart';
import '../../../notion/repository/notion_database_repository.dart';
import '../../../notion/tasks/view/task_main_page.dart';
import '../selected_database_viewmodel.dart';
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
    final notionOAuthViewModel =
        ref.read(notionOAuthViewModelProvider.notifier);

    final disabled = selectedDatabase == null ||
        selectedDatabase.status == null ||
        selectedDatabase.date == null ||
        (selectedDatabase.status is StatusTaskStatusProperty &&
            ((selectedDatabase.status as StatusTaskStatusProperty).todoOption ==
                    null ||
                (selectedDatabase.status as StatusTaskStatusProperty)
                        .completeOption ==
                    null));

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
                    _buildSectionTitle(context, 'データベース'),
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
                      _buildSectionTitle(context, 'ステータスプロパティ',
                          tooltip: '種類: Status, Checkbox'),
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
                        _buildSectionTitle(context, 'To-doオプション',
                            tooltip: '未完了時に指定するオプション'),
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
                        _buildSectionTitle(context, 'Completeオプション',
                            tooltip: '完了時に指定するオプション'),
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
                      _buildSectionTitle(context, '日付プロパティ',
                          tooltip: '種類: Date'),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () async {
                          final propertyName = await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              String tempName = '';
                              return AlertDialog(
                                title: const Text('プロパティ名を入力'),
                                content: TextField(
                                  onChanged: (value) {
                                    tempName = value;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'プロパティ名',
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('キャンセル'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(tempName);
                                    },
                                    child: const Text('確定'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (propertyName != null) {
                            final property =
                                await selectedDatabaseViewModel.createProperty(
                                    CreatePropertyType.date, propertyName);

                            // データベースが再取得されるまで待つ
                            await ref.read(accessibleDatabasesProvider.future);
                            selectedDatabaseViewModel.selectProperty(
                                property.id, SettingPropertyType.date);
                          }
                        },
                        child: const Text('日付プロパティを作成'),
                      ),
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
                        onPressed: disabled
                            ? null
                            : () {
                                taskDatabaseViewModel.save(selectedDatabase);
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  TaskMainPage.routeName,
                                  (route) => false,
                                );
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
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('アクセス可能なデータベースが見つかりませんでした。'),
                    const SizedBox(height: 4),
                    const Text('設定をやり直してください。'),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        notionOAuthViewModel.authenticate();
                      },
                      child: const Text('Notionに再接続'),
                    ),
                  ],
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title,
      {String? tooltip}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (tooltip != null) ...[
          const SizedBox(width: 4),
          Tooltip(
            message: tooltip,
            triggerMode: TooltipTriggerMode.tap,
            preferBelow: false,
            showDuration: const Duration(seconds: 3),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Icon(
              Icons.info_outline,
              size: 22,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ],
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
        hint: const Text('選択してください'),
        disabledHint: const Text('プロパティを作成してください'),
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
            .where((group) => group.name == groupName)
            .firstOrNull
            ?.option_ids
            .map((id) => DropdownMenuItem<String>(
                  value: id,
                  child: Text((state.status as StatusTaskStatusProperty)
                      .status
                      .options
                      .firstWhere((option) => option.id == id)
                      .name),
                ))
            .toList() ??
        [];
  }
}
