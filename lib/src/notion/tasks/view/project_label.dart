import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';

import '../../model/property.dart';
import '../project_selection_viewmodel.dart';
import 'task_icon.dart';

class ProjectLabel extends ConsumerWidget {
  const ProjectLabel({
    super.key,
    required this.projects,
  });

  final List<RelationOption>? projects;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _projects = projects;
    // プロジェクトが存在しない場合は何も表示しない
    if (_projects == null || _projects.isEmpty) {
      return const SizedBox.shrink();
    }

    final l = AppLocalizations.of(context)!;

    // ProjectSelectionViewModelからプロジェクト情報を取得
    final projectsAsync = ref.watch(projectSelectionViewModelProvider);
    final availableProjects = projectsAsync.value ?? [];

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      children: _projects.map((p) {
        // ProjectSelectionViewModelからプロジェクト情報を取得
        final project = availableProjects.firstWhere(
          (proj) => proj.id == p.id,
          orElse: () => RelationOption(id: p.id, title: null, icon: p.icon),
        );

        final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
              color:
                  Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(180),
            );

        // アイコンがある場合はアイコンを表示、ない場合は#を表示
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (project.icon != null)
              TaskIcon(icon: project.icon!, size: 14)
            else
              SizedBox(
                width: 14,
                child: Center(
                  child: Text('#', style: textStyle),
                ),
              ),
            const SizedBox(width: 3),
            Text(
              project.title ?? l.no_property(l.project_property),
              style: textStyle,
            ),
          ],
        );
      }).toList(),
    );
  }
}
