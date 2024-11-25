import 'package:flutter/material.dart';

import '../../../../helpers/date.dart';
import '../../const/date.dart';

class DateChip extends StatelessWidget {
  final DateTime? date;
  final void Function(bool) onSelected;
  final void Function() onDeleted;
  final BuildContext context;
  const DateChip(
      {super.key,
      required this.date,
      required this.onSelected,
      required this.onDeleted,
      required this.context});

  bool get selected => date != null;

  DateChipData? get config {
    final d = date;
    if (d == null) return null;
    final configs = dateStyleConfigs(context);
    return configs.where((c) => isThisDay(c.date, d)).firstOrNull;
  }

  String get label {
    final d = date;
    if (d == null) return '日付を選択';
    final formatted = formatDateTime(d.toLocal().toString(), showToday: true);
    return formatted ?? '';
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
    return InputChip(
        label: Text(label),
        selected: selected,
        onDeleted: selected ? onDeleted : null,
        onSelected: onSelected,
        deleteIcon: const Icon(Icons.clear),
        showCheckmark: false,
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        avatar: const Icon(Icons.event_rounded, size: 14));
  }
}
