import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notion_todo/src/helpers/date.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskDateSheet extends HookWidget {
  final DateTime? selectedDate;
  final void Function(DateTime?) onSelected;

  TaskDateSheet({
    super.key,
    required this.selectedDate,
    required this.onSelected,
  });

  final fixedDates = [
    (
      text: '今日',
      date: DateTime.now(),
      icon: Icons.calendar_today,
      activeStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.red),
        iconColor: WidgetStateProperty.all(Colors.white),
        textStyle: // FIXME: 適用されない
            WidgetStateProperty.all(const TextStyle(color: Colors.white)),
      ),
    ),
    (
      text: '明日',
      date: DateTime.now().add(const Duration(days: 1)),
      icon: Icons.upcoming,
      activeStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.orange),
        iconColor: WidgetStateProperty.all(Colors.white),
        textStyle:
            WidgetStateProperty.all(const TextStyle(color: Colors.white)),
      ),
    ),
    (
      text: '未定',
      date: null,
      icon: Icons.event_busy,
      activeStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.grey),
        iconColor: WidgetStateProperty.all(Colors.white),
        textStyle:
            WidgetStateProperty.all(const TextStyle(color: Colors.white)),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                  label: Text(d.text),
                  // 選択した日付と同じのときアクティブ色にする
                  style: isThisDay(selectedDate, d.date) ? d.activeStyle : null,
                );
              }),
            ],
          ),
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: selectedDate ?? DateTime.now(),
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
