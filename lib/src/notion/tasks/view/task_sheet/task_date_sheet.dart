import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/task.dart';
import '../../const/date.dart';
import '../../date_sheet_viewmodel.dart';
import 'time_range_label.dart';
import 'time_picker_sheet.dart';

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
    final viewModel = DateSheetViewModel(initialDateTime: selectedDate);
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
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 60),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: const Text('キャンセル'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text('決定',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            onSelected(viewModel.selectedDateTime);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
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
                    const SizedBox(height: 8),
                    TableCalendar(
                      locale: localeCode,
                      firstDay: viewModel.calenderFirstDay,
                      lastDay: viewModel.calenderLastDay,
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
                    const SizedBox(height: 10),
                    TimeRangeLabel(
                      date: viewModel.selectedDateTime,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => TimePickerSheet(
                            initialDate: viewModel.selectedDateTime,
                            onSelected: (date) {
                              if (date == null) return;
                              viewModel.handleSelectedDateTime(date);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                      onClearTime: () {
                        viewModel.clearTime();
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
