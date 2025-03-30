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
    final priority = this.priority;
    if (priority == null) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.keyboard_double_arrow_up_rounded,
          size: 14,
          color: priority.color,
        ),
        Text(
          priority.name,
          style: TextStyle(
            fontSize: 12,
            color: priority.color,
          ),
        ),
      ],
    );
  }
}
