import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';

import '../../../../common/widgets/base_input_chip.dart';
import '../../../model/property.dart';
import '../../project_selection_viewmodel.dart';
import '../task_icon.dart';

class ProjectChip extends ConsumerWidget {
  const ProjectChip({
    super.key,
    required this.projects,
    required this.context,
    required this.onSelected,
    required this.onDeleted,
  });

  final List<RelationOption>? projects;
  final BuildContext context;
  final Function(bool) onSelected;
  final Function() onDeleted;

  bool get isSelected => projects != null && projects!.isNotEmpty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;

    // ProjectSelectionViewModelからプロジェクト情報を取得
    final projectsAsync = ref.watch(projectSelectionViewModelProvider);
    final availableProjects = projectsAsync.valueOrNull ?? [];

    // 選択されたプロジェクトの情報を取得
    final selectedProjectInfos = isSelected
        ? projects!.map((p) {
            return availableProjects.firstWhere(
              (proj) => proj.id == p.id,
              orElse: () => RelationOption(id: p.id, title: null),
            );
          }).toList()
        : <RelationOption>[];

    return BaseInputChip.standard(
      context: context,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected && selectedProjectInfos.isNotEmpty)
            ...selectedProjectInfos.asMap().entries.expand((entry) {
              final index = entry.key;
              final project = entry.value;
              return [
                if (index > 0) const Text(', ', style: TextStyle(fontSize: 14)),
                if (project.icon != null)
                  TaskIcon(icon: project.icon!, size: 14)
                else
                  const SizedBox(
                    width: 14,
                    height: 20,
                    child: Center(
                      child: Text('#', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                const SizedBox(width: 4),
                Text(
                  project.title ?? l.no_property(l.project_property),
                  style: const TextStyle(fontSize: 14),
                ),
              ];
            })
          else ...[
            const SizedBox(
              width: 14,
              height: 20,
              child: Center(
                child: Text('#', style: TextStyle(fontSize: 14)),
              ),
            ),
            const SizedBox(width: 4),
            Text(l.project_property, style: const TextStyle(fontSize: 14)),
          ],
        ],
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      avatar: null,
      onDeleted: isSelected ? onDeleted : null,
      onSelected: onSelected,
      selected: isSelected,
    );
  }
}
