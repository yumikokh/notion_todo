import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';

import '../../../model/property.dart';
import '../../../../helpers/haptic_helper.dart';
import '../../../../settings/task_database/task_database_viewmodel.dart';
import '../../project_selection_viewmodel.dart';

class TaskProjectSheet extends ConsumerStatefulWidget {
  const TaskProjectSheet({
    super.key,
    required this.selectedProjects,
    required this.onSelected,
  });

  final List<RelationOption>? selectedProjects;
  final Function(List<RelationOption>?) onSelected;

  @override
  ConsumerState<TaskProjectSheet> createState() => _TaskProjectSheetState();
}

class _TaskProjectSheetState extends ConsumerState<TaskProjectSheet> {
  late Set<String> temporarySelectedIds;
  late List<RelationOption> availableProjects;
  bool hasChanges = false;

  @override
  void initState() {
    super.initState();
    temporarySelectedIds =
        widget.selectedProjects?.map((p) => p.id).toSet() ?? {};
    availableProjects = [];
  }

  @override
  void didUpdateWidget(TaskProjectSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedProjects != oldWidget.selectedProjects) {
      setState(() {
        temporarySelectedIds =
            widget.selectedProjects?.map((p) => p.id).toSet() ?? {};
        hasChanges = false;
      });
    }
  }

  void _saveSelection() async {
    HapticHelper.selection();

    // 選択されたプロジェクトを作成
    List<RelationOption>? selectedProjects;
    if (temporarySelectedIds.isEmpty) {
      selectedProjects = null;
    } else {
      selectedProjects = availableProjects
          .where((p) => temporarySelectedIds.contains(p.id))
          .toList();
    }

    // 使用履歴を更新
    if (selectedProjects != null && selectedProjects.isNotEmpty) {
      await ref
          .read(projectSelectionViewModelProvider.notifier)
          .updateRecentProjects(selectedProjects);
    }

    // 親の状態を更新
    widget.onSelected(selectedProjects);

    // シートを閉じる
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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

    // 関連データベースから直接プロジェクトを取得
    final availableProjectsAsync = ref.watch(projectSelectionViewModelProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ヘッダー
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
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        ref
                            .read(projectSelectionViewModelProvider.notifier)
                            .refresh();
                      },
                      icon: const Icon(Icons.refresh),
                      tooltip: l.refresh,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          temporarySelectedIds = {};
                          hasChanges = true;
                        });
                      },
                      child: Text(l.reset),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // プロジェクト一覧
          Flexible(
            child: availableProjectsAsync.when(
              data: (projects) {
                availableProjects = projects;

                if (projects.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Text(l.no_projects_found),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    final isSelected =
                        temporarySelectedIds.contains(project.id);
                    return ListTile(
                      leading: Icon(
                        Icons.folder_outlined,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      title: Text(
                          project.title ?? l.no_property(l.project_property)),
                      selected: isSelected,
                      trailing: isSelected ? const Icon(Icons.check) : null,
                      onTap: () {
                        HapticHelper.light();

                        setState(() {
                          if (isSelected) {
                            temporarySelectedIds.remove(project.id);
                          } else {
                            temporarySelectedIds.add(project.id);
                          }
                          hasChanges = true;
                        });
                      },
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(l.error_loading_projects),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(projectSelectionViewModelProvider.notifier)
                              .refresh();
                        },
                        child: Text(l.retry),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // 保存ボタン
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: hasChanges ? _saveSelection : null,
                child: Text(l.save),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
