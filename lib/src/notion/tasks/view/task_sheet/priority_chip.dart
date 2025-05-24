import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';
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
        style: const TextStyle(fontSize: 14),
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      avatar: Icon(
        Icons.flag_rounded,
        size: 18,
        color: isSelected ? priority?.mColor : Theme.of(context).hintColor,
      ),
      deleteIcon:
          Icon(Icons.clear, size: 14, color: Theme.of(context).disabledColor),
      onDeleted: isSelected ? onDeleted : null,
      onSelected: onSelected,
      selected: isSelected,
      showCheckmark: false,
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      backgroundColor: Theme.of(context).cardColor,
      selectedColor: Theme.of(context).cardColor,
    );
  }
}
