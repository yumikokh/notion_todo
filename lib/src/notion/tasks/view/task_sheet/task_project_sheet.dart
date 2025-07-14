import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';

import '../../../model/property.dart';
import '../../../../helpers/haptic_helper.dart';
import '../../../../settings/task_database/task_database_viewmodel.dart';
import '../../task_viewmodel.dart';
import '../../../common/filter_type.dart';

class TaskProjectSheet extends ConsumerWidget {
  const TaskProjectSheet({
    super.key,
    required this.selectedProjects,
    required this.onSelected,
  });

  final List<RelationOption>? selectedProjects;
  final Function(List<RelationOption>?) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider).valueOrNull;
    final projectProperty = taskDatabase?.project;

    if (projectProperty == null) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text(l.not_found_property),
        ),
      );
    }

    // 利用可能なプロジェクトオプションを取得
    // 現在のタスクリストからプロジェクト情報を抽出
    final List<RelationOption> availableProjects = [];
    final seenProjectIds = <String>{};
    
    // タスクリストからプロジェクト情報を収集
    final tasksAsync = ref.watch(taskViewModelProvider(filterType: FilterType.all));
    final tasks = tasksAsync.valueOrNull ?? [];
    
    for (final task in tasks) {
      if (task.project != null) {
        for (final project in task.project!) {
          if (project.title != null && !seenProjectIds.contains(project.id)) {
            availableProjects.add(project);
            seenProjectIds.add(project.id);
          }
        }
      }
    }
    
    // 現在選択されているプロジェクトも追加（まだリストにない場合）
    if (selectedProjects != null) {
      for (final project in selectedProjects!) {
        if (project.title != null && !seenProjectIds.contains(project.id)) {
          availableProjects.add(project);
          seenProjectIds.add(project.id);
        }
      }
    }
    
    // プロジェクト名でソート
    availableProjects.sort((a, b) => (a.title ?? '').compareTo(b.title ?? ''));

    // 現在選択されているプロジェクトID
    final selectedProjectIds = selectedProjects?.map((p) => p.id).toSet() ?? {};

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(l.cancel),
                ),
                TextButton(
                  onPressed: () {
                    onSelected(null);
                    Navigator.pop(context);
                  },
                  child: Text(l.reset),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableProjects.length,
              itemBuilder: (context, index) {
                final project = availableProjects[index];
                final isSelected = selectedProjectIds.contains(project.id);
                return ListTile(
                  leading: Icon(
                    Icons.folder_outlined,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  title: Text(project.title ?? l.no_property(l.project_property)),
                  selected: isSelected,
                  trailing: isSelected
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () {
                    HapticHelper.selection();
                    
                    // 複数選択のトグル処理
                    final newSelectedIds = Set<String>.from(selectedProjectIds);
                    if (isSelected) {
                      newSelectedIds.remove(project.id);
                    } else {
                      newSelectedIds.add(project.id);
                    }
                    
                    // 選択されたプロジェクトを更新
                    if (newSelectedIds.isEmpty) {
                      onSelected(null);
                    } else {
                      final newSelectedProjects = availableProjects
                          .where((p) => newSelectedIds.contains(p.id))
                          .toList();
                      onSelected(newSelectedProjects);
                    }
                    
                    // シートを閉じない（複数選択のため）
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}