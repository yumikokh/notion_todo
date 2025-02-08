import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../helpers/date.dart';
import '../../../model/task.dart';
import '../../const/date.dart';

class DateChip extends StatelessWidget {
  final DateTime? date;
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

  DateChipData? get config {
    final dt = date;
    if (dt == null) return null;
    final configs = dateStyleConfigs(context);
    return configs.where((c) => d.isThisDay(c.date?.datetime, dt)).firstOrNull;
  }

  String? get label {
    final dt = date;
    if (dt == null) return null;
    final formatted = d.formatDateTime(
        NotionDateTime(datetime: dt, isAllDay: true),
        showToday: true);
    return formatted;
  }

  Color? get color {
    final config = this.config;
    if (config == null) return null;
    return config.color;
  }

  Color? get onColor {
    final config = this.config;
    if (config == null) return null;
    return config.onColor;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return InputChip(
        label: Text(label ?? l.select_date),
        selected: selected,
        onDeleted: selected ? onDeleted : null,
        onSelected: onSelected,
        deleteIcon: const Icon(Icons.clear),
        showCheckmark: false,
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        avatar: const Icon(Icons.event_rounded, size: 14));
  }
}
