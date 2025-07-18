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
    this.scrollController,
  });

  final List<RelationOption>? selectedProjects;
  final Function(List<RelationOption>?) onSelected;
  final ScrollController? scrollController;

  @override
  ConsumerState<TaskProjectSheet> createState() => _TaskProjectSheetState();
}

class _TaskProjectSheetState extends ConsumerState<TaskProjectSheet> {
  late Set<String> temporarySelectedIds;
  late List<RelationOption> availableProjects;
  bool hasChanges = false;
  bool isLoading = false;

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
    final projects = ref.watch(projectSelectionViewModelProvider);
    availableProjects = projects;

    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          // ドラッグハンドル
          Container(
            width: 32,
            height: 4,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.4),
            ),
          ),
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
                      onPressed: isLoading
                          ? null
                          : () async {
                              setState(() {
                                isLoading = true;
                              });
                              await ref
                                  .read(projectSelectionViewModelProvider
                                      .notifier)
                                  .refresh();
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                      icon: const Icon(Icons.refresh),
                      tooltip: l.refresh,
                    ),
                    TextButton(
                      onPressed: _saveSelection,
                      child: Text(l.save,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // プロジェクト一覧
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : projects.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(24),
                        child: Center(
                          child: Text(l.no_projects_found),
                        ),
                      )
                    : ListView.builder(
                        controller: widget.scrollController,
                        itemCount: projects.length,
                        itemBuilder: (context, index) {
                          final project = projects[index];
                          final isSelected =
                              temporarySelectedIds.contains(project.id);
                          return ListTile(
                            leading: Text(
                              '#',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                                fontSize: 18,
                              ),
                            ),
                            title: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Text(project.title ??
                                      l.no_property(l.project_property)),
                                ),
                              ],
                            ),
                            selected: isSelected,
                            trailing:
                                isSelected ? const Icon(Icons.check) : null,
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
                      ),
          ),
        ],
      ),
    );
  }
}
