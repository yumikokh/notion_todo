import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../helpers/date.dart';
import '../../const/date.dart';

class TaskDateSheet extends HookWidget {
  final DateTime? selectedDate;
  final Function(DateTime?) onSelected;

  static final DateHelper d = DateHelper();

  const TaskDateSheet({
    super.key,
    required this.selectedDate,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final options = dateStyleConfigs(context);
    final selected = useState<String?>(
      selectedDate != null ? d.formatDate(selectedDate!) : null,
    );

    final l = Localizations.localeOf(context);
    final localeCode = "${l.languageCode}_${l.countryCode}";

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 60),
            child: Column(
              children: [
                SegmentedButton(
                  expandedInsets: const EdgeInsets.symmetric(horizontal: 0),
                  emptySelectionAllowed: true,
                  selected: {selected.value},
                  onSelectionChanged: (selectedSet) {
                    Navigator.pop(context);
                    selected.value = selectedSet.first;
                    onSelected(selectedSet.first != null
                        ? DateTime.parse(selectedSet.first!)
                        : null);
                  },
                  segments: options
                      .map((dt) => ButtonSegment(
                          value:
                              dt.date != null ? d.formatDate(dt.date!) : null,
                          icon: Icon(dt.icon, size: 14),
                          label: Text(dt.text,
                              style: const TextStyle(fontSize: 12))))
                      .toList(),
                ),
                TableCalendar(
                  locale: localeCode,
                  firstDay: selectedDate == null
                      ? now
                      : selectedDate!.isBefore(now)
                          ? selectedDate!
                          : now,
                  lastDay: now.add(const Duration(days: 365)),
                  focusedDay: selectedDate ?? now,
                  currentDay: selectedDate,
                  calendarFormat: CalendarFormat.twoWeeks,
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  onDaySelected: (date, focusedDate) {
                    onSelected(date);
                    Navigator.pop(context);
                  },
                  onFormatChanged: (format) {
                    return; // Week選択時のエラーを回避
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
