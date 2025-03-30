import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../model/property.dart';

class PriorityChip extends StatelessWidget {
  final SelectOption? priority;
  final BuildContext context;
  final Function(bool) onSelected;
  final Function() onDeleted;

  const PriorityChip({
    Key? key,
    required this.priority,
    required this.context,
    required this.onSelected,
    required this.onDeleted,
  }) : super(key: key);

  bool get isSelected => priority != null;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return InputChip(
      label: Text(
        priority?.name ?? l.priority_property,
        style: TextStyle(
          color: isSelected ? null : Theme.of(context).hintColor,
        ),
      ),
      avatar: Icon(
        Icons.flag_rounded,
        size: 18,
        color: isSelected ? null : Theme.of(context).hintColor,
      ),
      deleteIcon: isSelected ? const Icon(Icons.close_rounded, size: 18) : null,
      onDeleted: isSelected ? onDeleted : null,
      onSelected: onSelected,
      selected: isSelected,
    );
  }
}
