import 'package:flutter/material.dart';

import '../../model/property.dart';

class PriorityLabel extends StatelessWidget {
  const PriorityLabel({
    super.key,
    required this.priority,
    required this.context,
    required this.showColor,
  });

  final SelectOption? priority;
  final BuildContext context;
  final bool showColor;

  @override
  Widget build(BuildContext context) {
    final priority = this.priority;
    if (priority == null) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.flag_rounded,
          size: 12,
          color: showColor ? priority.color : null,
        ),
        const SizedBox(width: 2),
        Text(
          priority.name,
          style: TextStyle(
            fontSize: 12,
            color: showColor ? priority.color : null,
          ),
        ),
      ],
    );
  }
}
