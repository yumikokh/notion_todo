import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../helpers/date.dart';
import '../../../model/task.dart';
import '../date_label.dart';

class DateChip extends StatelessWidget {
  final TaskDate? date;
  final void Function(bool) onSelected;
  final void Function() onDeleted;
  final BuildContext context;

  static final DateHelper d = DateHelper();

  const DateChip(
      {super.key,
      required this.date,
      required this.onSelected,
      required this.onDeleted,
      required this.context});

  bool get selected => date != null;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final avatarColor = TaskDate.getColor(context, date);

    return InputChip(
      label: date == null
          ? Text(l.select_date, style: const TextStyle(fontSize: 11))
          : DateLabel(
              date: date,
              context: context,
              showColor: false,
              showToday: true,
              showIcon: false),
      labelPadding: const EdgeInsets.symmetric(horizontal: 2),
      selected: selected,
      onDeleted: selected ? onDeleted : null,
      onSelected: onSelected,
      deleteIcon:
          Icon(Icons.clear, size: 14, color: Theme.of(context).disabledColor),
      showCheckmark: false,
      avatar: Icon(Icons.event_rounded, size: 14, color: avatarColor),
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }
}
