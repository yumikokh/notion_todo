import 'package:flutter/material.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';

import '../../../../common/widgets/base_input_chip.dart';
import '../../../model/property.dart';

class ProjectChip extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return BaseInputChip.standard(
      context: context,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '#',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(width: 4),
          Text(
            isSelected
                ? projects!
                    .map((p) => p.title ?? l.no_property(l.project_property))
                    .join(', ')
                : l.project_property,
            style: const TextStyle(fontSize: 14),
          ),
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
