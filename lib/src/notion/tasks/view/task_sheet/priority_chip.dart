import 'package:flutter/material.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';

import '../../../../common/widgets/base_input_chip.dart';
import '../../../model/property.dart';

class PriorityChip extends StatelessWidget {
  final SelectOption? priority;
  final BuildContext context;
  final Function(bool) onSelected;
  final Function() onDeleted;

  const PriorityChip({
    super.key,
    required this.priority,
    required this.context,
    required this.onSelected,
    required this.onDeleted,
  });

  bool get isSelected => priority != null;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return BaseInputChip.standard(
      context: context,
      label: Text(
        priority?.name ?? l.priority_property,
        style: const TextStyle(fontSize: 14),
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      avatar: Icon(
        Icons.flag_rounded,
        size: 18,
        color: isSelected ? priority?.mColor : Theme.of(context).hintColor,
      ),
      onDeleted: isSelected ? onDeleted : null,
      onSelected: onSelected,
      selected: isSelected,
    );
  }
}
