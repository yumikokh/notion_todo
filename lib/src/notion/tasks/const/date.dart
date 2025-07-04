import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../settings/theme/theme.dart';
import '../../model/task.dart';

// レコードクラスの定義を追加
class DateChipData {
  final String text;
  final NotionDateTime? date;
  final IconData icon;
  final Color color;
  final Color onColor;

  const DateChipData({
    required this.text,
    required this.date,
    required this.icon,
    required this.color,
    required this.onColor,
  });
}

List<DateChipData> dateStyleConfigs(BuildContext context) {
  final l = AppLocalizations.of(context)!;
  return [
    DateChipData(
      text: l.today,
      date: NotionDateTime(
        datetime: DateTime.now(),
        isAllDay: true,
      ),
      icon: Icons.calendar_today_rounded,
      color: MaterialTheme(Theme.of(context).textTheme).extendedColors[1].value,
      onColor: Theme.of(context).colorScheme.onTertiaryContainer,
    ),
    DateChipData(
      text: l.tomorrow,
      date: NotionDateTime(
        datetime: DateTime.now().add(const Duration(days: 1)),
        isAllDay: true,
      ),
      icon: Icons.upcoming_rounded,
      color: MaterialTheme(Theme.of(context).textTheme).extendedColors[0].value,
      onColor: Theme.of(context).colorScheme.onTertiaryContainer,
    ),
    DateChipData(
      text: l.undetermined,
      date: null,
      icon: Icons.event_busy_rounded,
      color: Theme.of(context).colorScheme.secondary,
      onColor: Theme.of(context).colorScheme.onSecondary,
    ),
  ];
}
