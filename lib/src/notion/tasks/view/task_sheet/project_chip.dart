import 'package:flutter/material.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    
    if (projects == null || projects!.isEmpty) {
      return ActionChip(
        label: Text(
          l.no_property(l.project_property),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        avatar: Icon(
          Icons.folder_outlined,
          size: 18,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        side: BorderSide.none,
        onPressed: () => onSelected(true),
      );
    }

    return GestureDetector(
      onTap: () => onSelected(true),
      child: Chip(
        label: Text(
          projects!.map((p) => p.title ?? l.no_property(l.project_property)).join(', '),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        avatar: Icon(
          Icons.folder_outlined,
          size: 18,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        side: BorderSide.none,
        deleteIcon: Icon(
          Icons.close,
          size: 18,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onDeleted: onDeleted,
      ),
    );
  }
}