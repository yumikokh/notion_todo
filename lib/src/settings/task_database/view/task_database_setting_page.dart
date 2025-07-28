import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';
import '../../../helpers/haptic_helper.dart';
import '../../../notion/model/property.dart';
import '../../../notion/oauth/notion_oauth_viewmodel.dart';
import '../../../notion/api/notion_database_api.dart';
import '../../../notion/tasks/view/task_main_page.dart';
import '../selected_database_viewmodel.dart';
import '../task_database_viewmodel.dart';
import 'property_create_button.dart';

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
    final selectedStatus = selectedDatabase?.status;

    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.task_database_settings_title,
            style: const TextStyle(fontSize: 18)),
      ),
      body: accessibleDatabases.when(
        data: (accessibleDatabases) => accessibleDatabases.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // データベース選択セクション
                      _buildSectionTitle(context, l.database),
                      const SizedBox(height: 8),
                      _buildDropdown(
                        value: selectedDatabase?.id,
                        items: accessibleDatabases
                            .map((db) => DropdownMenuItem(
                                value: db.id, child: Text(db.name)))
                            .toList(),
                        onChanged: (value) =>
                            selectedDatabaseViewModel.selectDatabase(value),
                        context: context,
                      ),
                      const SizedBox(height: 32),

                      if (selectedDatabase != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ステータスプロパティセクション
                            _buildSectionTitle(context, l.status_property,
                                tooltip: l.status_property_description),
                            PropertyCreateButton(
                              type: CreatePropertyType.checkbox,
                              selectedDatabaseViewModel:
                                  selectedDatabaseViewModel,
                              onDatabaseRefreshed: () async {
                                await ref
                                    .read(accessibleDatabasesProvider.future);
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                        ref
                            .watch(
                                propertiesProvider(SettingPropertyType.status))
                            .when(
                              data: (properties) => _buildDropdown(
                                value: selectedDatabase.status?.id,
                                items: properties
                                    .map((prop) => DropdownMenuItem(
                                        value: prop.id, child: Text(prop.name)))
                                    .toList(),
                                onChanged: (value) =>
                                    selectedDatabaseViewModel.selectProperty(
                                        value, SettingPropertyType.status),
                                context: context,
                              ),
                              loading: () => const CircularProgressIndicator(),
                              error: (error, stack) =>
                                  Center(child: Text(l.loading_failed)),
                            ),
                        const SizedBox(height: 24),

                        // StatusTaskStatusPropertyの場合のみ表示
                        if (selectedStatus is StatusCompleteStatusProperty) ...[
                          _buildSectionTitle(
                              context, l.status_property_todo_option,
                              tooltip: l.todo_option_description),
                          const SizedBox(height: 8),
                          _buildDropdown(
                            value: selectedStatus.todoOption?.id,
                            items: _buildStatusOptions(selectedDatabaseViewModel
                                .getStatusOptionsByGroup(StatusGroupType.todo)),
                            onChanged: (value) =>
                                selectedDatabaseViewModel.selectStatusOption(
                                    value, StatusGroupType.todo),
                            context: context,
                          ),
                          const SizedBox(height: 24),
                          _buildSectionTitle(
                              context, l.status_property_in_progress_option,
                              tooltip: l.in_progress_option_description,
                              isRequired: false),
                          const SizedBox(height: 8),
                          _buildDropdown(
                            value: selectedStatus.inProgressOption?.id,
                            items: _buildStatusOptions(selectedDatabaseViewModel
                                .getStatusOptionsByGroup(
                                    StatusGroupType.inProgress)),
                            onChanged: (value) =>
                                selectedDatabaseViewModel.selectStatusOption(
                                    value, StatusGroupType.inProgress),
                            context: context,
                          ),
                          const SizedBox(height: 24),
                          _buildSectionTitle(
                              context, l.status_property_complete_option,
                              tooltip: l.complete_option_description),
                          const SizedBox(height: 8),
                          _buildDropdown(
                            value: selectedStatus.completeOption?.id,
                            items: _buildStatusOptions(selectedDatabaseViewModel
                                .getStatusOptionsByGroup(
                                    StatusGroupType.complete)),
                            onChanged: (value) =>
                                selectedDatabaseViewModel.selectStatusOption(
                                    value, StatusGroupType.complete),
                            context: context,
                          ),
                          const SizedBox(height: 24),
                        ],

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 日付プロパティセクション
                            _buildSectionTitle(context, l.date_property,
                                tooltip: l.date_property_description),
                            PropertyCreateButton(
                              type: CreatePropertyType.date,
                              selectedDatabaseViewModel:
                                  selectedDatabaseViewModel,
                              onDatabaseRefreshed: () async {
                                await ref
                                    .read(accessibleDatabasesProvider.future);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ref
                            .watch(propertiesProvider(SettingPropertyType.date))
                            .when(
                              data: (properties) => _buildDropdown(
                                value: selectedDatabase.date?.id,
                                items: properties
                                    .map((prop) => DropdownMenuItem(
                                        value: prop.id, child: Text(prop.name)))
                                    .toList(),
                                onChanged: (value) =>
                                    selectedDatabaseViewModel.selectProperty(
                                        value, SettingPropertyType.date),
                                context: context,
                              ),
                              loading: () => const CircularProgressIndicator(),
                              error: (error, stack) =>
                                  Center(child: Text(l.loading_failed)),
                            ),
                        const SizedBox(height: 32),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 優先度プロパティセクション
                            _buildSectionTitle(context, l.priority_property,
                                tooltip: l.priority_property_description,
                                isRequired: false),
                            PropertyCreateButton(
                              type: CreatePropertyType.select,
                              selectedDatabaseViewModel:
                                  selectedDatabaseViewModel,
                              onDatabaseRefreshed: () async {
                                await ref
                                    .read(accessibleDatabasesProvider.future);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ref
                            .watch(propertiesProvider(
                                SettingPropertyType.priority))
                            .when(
                              data: (properties) => _buildDropdown(
                                value: selectedDatabase.priority?.id,
                                items: properties
                                    .map((prop) => DropdownMenuItem(
                                        value: prop.id, child: Text(prop.name)))
                                    .toList(),
                                onChanged: (value) =>
                                    selectedDatabaseViewModel.selectProperty(
                                        value, SettingPropertyType.priority),
                                context: context,
                              ),
                              loading: () => const CircularProgressIndicator(),
                              error: (error, stack) =>
                                  Center(child: Text(l.loading_failed)),
                            ),
                        const SizedBox(height: 32),

                        // プロジェクトプロパティセクション
                        _buildSectionTitle(context, l.project_property,
                            tooltip: l.project_property_description,
                            isRequired: false),
                        const SizedBox(height: 8),
                        ref
                            .watch(
                                propertiesProvider(SettingPropertyType.project))
                            .when(
                              data: (properties) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDropdown(
                                    value: selectedDatabase.project?.id,
                                    items: properties
                                        .map((prop) => DropdownMenuItem(
                                            value: prop.id,
                                            child: Text(prop.name)))
                                        .toList(),
                                    onChanged: (value) =>
                                        selectedDatabaseViewModel
                                            .selectProperty(value,
                                                SettingPropertyType.project),
                                    context: context,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    l.project_property_empty_message,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                  ),
                                ],
                              ),
                              loading: () => const CircularProgressIndicator(),
                              error: (error, stack) =>
                                  Center(child: Text('Project Error: $error')),
                            ),
                        const SizedBox(height: 32),
                      ],

                      // 保存ボタン
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: selectedDatabaseViewModel.submitDisabled
                              ? null
                              : () async {
                                  await taskDatabaseViewModel
                                      .save(selectedDatabase!);
                                  if (context.mounted) {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      TaskMainPage.routeName,
                                      (route) => false,
                                    );
                                  }
                                  HapticHelper.selection();
                                },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(l.save),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l.not_found_database),
                    const SizedBox(height: 4),
                    Text(l.not_found_database_description),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        notionOAuthViewModel.authenticate();
                        HapticHelper.selection();
                      },
                      child: Text(l.notion_reconnect),
                    ),
                  ],
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l.loading_failed),
              const SizedBox(height: 8),
              SelectableText(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                contextMenuBuilder: (context, editableTextState) =>
                    const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title,
      {String? tooltip, bool? isRequired = true}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (isRequired == true) ...[
          const SizedBox(width: 4),
          const Text('*', style: TextStyle(color: Colors.red)),
        ],
        if (tooltip != null) ...[
          const SizedBox(width: 4),
          Tooltip(
            message: tooltip,
            triggerMode: TooltipTriggerMode.tap,
            preferBelow: false,
            showDuration: const Duration(seconds: 2),
            verticalOffset: 14, // tooltipとchildの距離を近づける
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
    required BuildContext context,
  }) {
    final l = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButton<String>(
        hint: Text(l.select),
        disabledHint: items.isEmpty ? Text(l.create_property) : Text(l.select),
        value: value,
        items: items,
        onTap: () {
          HapticHelper.light();
        },
        onChanged: items.isEmpty
            ? null
            : (value) {
                onChanged(value);
                HapticHelper.selection();
              },
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.surfaceContainerHighest
            : null,
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildStatusOptions(
      List<StatusOption> options) {
    return options
        .map((option) => DropdownMenuItem<String>(
              value: option.id,
              child: Text(option.name),
            ))
        .toList();
  }
}
