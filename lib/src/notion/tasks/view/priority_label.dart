import 'package:flutter/material.dart';

import '../../model/property.dart';

class PriorityLabel extends StatelessWidget {
  const PriorityLabel({
    super.key,
    required this.priority,
    required this.context,
  });

  final SelectOption? priority;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    if (priority == null) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color:
            Theme.of(context).colorScheme.surfaceVariant, // TODO: Notionの色に合わせる
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.flag_rounded,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 2),
          Text(
            priority!.name,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
