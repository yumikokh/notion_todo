import 'package:flutter/material.dart';

import '../../../settings/theme/theme.dart';

// レコードクラスの定義を追加
class DateChipData {
  final String text;
  final DateTime? date;
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
  return [
    DateChipData(
      text: '今日',
      date: DateTime.now(),
      icon: Icons.calendar_today,
      color: MaterialTheme(Theme.of(context).textTheme).extendedColors[1].value,
      onColor: Theme.of(context).colorScheme.onTertiaryContainer,
    ),
    DateChipData(
      text: '明日',
      date: DateTime.now().add(const Duration(days: 1)),
      icon: Icons.upcoming,
      color: MaterialTheme(Theme.of(context).textTheme).extendedColors[0].value,
      onColor: Theme.of(context).colorScheme.onTertiaryContainer,
    ),
    DateChipData(
      text: '未定',
      date: null,
      icon: Icons.event_busy,
      color: Theme.of(context).colorScheme.secondary,
      onColor: Theme.of(context).colorScheme.onSecondary,
    ),
  ];
}
