import 'package:flutter/material.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';

import '../../../../common/widgets/base_input_chip.dart';
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

    return BaseInputChip.standard(
      context: context,
      label: date == null
          ? Text(l.select_date,
              style: const TextStyle(
                fontSize: 14,
              ))
          : DateLabel(
              date: date,
              context: context,
              showColor: false,
              showToday: true,
              showIcon: false,
              size: 14),
      selected: selected,
      onDeleted: selected ? onDeleted : null,
      onSelected: onSelected,
      avatar: Icon(Icons.event_rounded, size: 18, color: avatarColor),
    );
  }
}
