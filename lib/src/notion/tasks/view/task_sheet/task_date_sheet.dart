import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/task.dart';
import '../../const/date.dart';
import '../../task_date_viewmodel.dart';

class TaskDateSheet extends HookWidget {
  final TaskDate? selectedDate;
  final Function(TaskDate?) onSelected;

  const TaskDateSheet({
    super.key,
    required this.selectedDate,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = TaskDateViewModel(
      initialDateTime: selectedDate,
    );

    final options = dateStyleConfigs(context);
    final l = Localizations.localeOf(context);
    final localeCode = "${l.languageCode}_${l.countryCode}";

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
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
                      selected: {
                        viewModel.selectedDateTime?.start.submitFormat
                      },
                      onSelectionChanged: (selectedSet) {
                        viewModel.handleSegmentChanged(selectedSet);
                        onSelected(viewModel.selectedDateTime);
                        Navigator.pop(context);
                      },
                      segments: options
                          .map((dt) => ButtonSegment(
                              value: dt.date?.submitFormat,
                              icon: Icon(dt.icon, size: 14),
                              label: Text(dt.text,
                                  style: const TextStyle(fontSize: 12))))
                          .toList(),
                    ),
                    TableCalendar(
                      locale: localeCode,
                      firstDay: viewModel.getFirstDay(),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      focusedDay: viewModel.focusedDay,
                      currentDay: viewModel.selectedStartDateTime,
                      rangeStartDay: viewModel.selectedStartDateTime,
                      rangeEndDay: viewModel.selectedEndDateTime,
                      calendarFormat: CalendarFormat.twoWeeks,
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      onDaySelected: viewModel.handleCalendarSelected,
                      onFormatChanged: (_) {
                        // NOTE:Week選択時のエラーを回避
                        return;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
