import 'package:flutter/material.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';

import '../../model/property.dart';

class ProjectLabel extends StatelessWidget {
  const ProjectLabel({
    super.key,
    required this.project,
  });

  final List<RelationOption>? project;

  @override
  Widget build(BuildContext context) {
    // プロジェクトが存在しない場合は何も表示しない
    if (project == null || project!.isEmpty) {
      return const SizedBox.shrink();
    }

    final l = AppLocalizations.of(context)!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '#',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withAlpha(180),
              ),
        ),
        const SizedBox(width: 3),
        Text(
          project!
              .map((p) => p.title ?? l.no_property(l.project_property))
              .join(','),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withAlpha(180),
              ),
        ),
      ],
    );
  }
}
