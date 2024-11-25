import 'package:flutter/material.dart';
import 'package:notion_todo/src/helpers/date.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../const/date.dart';

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
    final options = dateStyleConfigs(context);

    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...options.map((d) {
                return ElevatedButton.icon(
                    onPressed: () {
                      onSelected(d.date);
                      Navigator.pop(context);
                    },
                    icon: Icon(d.icon,
                        color: isThisDay(selectedDate, d.date)
                            ? d.onColor
                            : d.color),
                    label: Text(d.text,
                        style: isThisDay(selectedDate, d.date)
                            ? TextStyle(color: d.onColor)
                            : TextStyle(color: d.color)),
                    // 選択した日付と同じのときアクティブ色にする
                    style: isThisDay(selectedDate, d.date)
                        ? ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(d.color),
                          )
                        : null);
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
