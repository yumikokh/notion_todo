import 'package:flutter/material.dart';
import 'package:notion_todo/src/helpers/date.dart';
import 'package:notion_todo/src/settings/theme/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskDateSheet extends StatelessWidget {
  final DateTime? selectedDate;
  final void Function(DateTime?) onSelected;

  const TaskDateSheet({
    super.key,
    required this.selectedDate,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final fixedDates = [
      (
        text: '今日',
        date: DateTime.now(),
        icon: Icons.calendar_today,
        activeTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onTertiaryContainer,
        ),
        activeButtonStyle: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.tertiaryContainer),
          iconColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.onTertiaryContainer),
        ),
      ),
      (
        text: '明日',
        date: DateTime.now().add(const Duration(days: 1)),
        icon: Icons.upcoming,
        activeTextStyle: const TextStyle(
          color: Colors.white,
        ),
        activeButtonStyle: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
              MaterialTheme(Theme.of(context).textTheme)
                  .extendedColors[0]
                  .value),
          iconColor: WidgetStateProperty.all(Colors.white),
        ),
      ),
      (
        text: '未定',
        date: null,
        icon: Icons.event_busy,
        activeTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        activeButtonStyle: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.outlineVariant),
          iconColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
    ];

    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...fixedDates.map((d) {
                return ElevatedButton.icon(
                  onPressed: () {
                    onSelected(d.date);
                    Navigator.pop(context);
                  },
                  icon: Icon(d.icon),
                  label: Text(d.text,
                      style: isThisDay(selectedDate, d.date)
                          ? d.activeTextStyle
                          : null),
                  // 選択した日付と同じのときアクティブ色にする
                  style: isThisDay(selectedDate, d.date)
                      ? d.activeButtonStyle
                      : null,
                );
              }),
            ],
          ),
          TableCalendar(
            firstDay: selectedDate == null
                ? now
                : selectedDate!.isBefore(now)
                    ? selectedDate!
                    : now,
            lastDay: now.add(const Duration(days: 365)),
            focusedDay: selectedDate ?? now,
            currentDay: selectedDate,
            calendarFormat: CalendarFormat.twoWeeks,
            onDaySelected: (date, focusedDate) {
              onSelected(date);
              Navigator.pop(context);
            },
          ),
        ]));
  }
}
