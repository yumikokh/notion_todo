import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/task.dart';
import '../../../../helpers/haptic_helper.dart';
import '../../const/date.dart';
import '../../date_sheet_viewmodel.dart';
import 'time_range_label.dart';
import 'time_picker_sheet.dart';

class TaskDateSheet extends HookWidget {
  final TaskDate? selectedDate;
  final Function(TaskDate?) onSelected;
  final bool confirmable;
  const TaskDateSheet({
    super.key,
    required this.selectedDate,
    required this.onSelected,
    this.confirmable = false,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = DateSheetViewModel(initialDateTime: selectedDate);
    final options = dateStyleConfigs(context);
    final l = Localizations.localeOf(context);
    final localeCode = "${l.languageCode}_${l.countryCode}";
    final l10n = AppLocalizations.of(context)!;

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
                          child: Text(l10n.cancel),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text(confirmable ? l10n.confirm : l10n.save,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            onSelected(viewModel.selectedDateTime);
                            Navigator.pop(context);
                            HapticHelper.selection();
                          },
                        ),
                      ],
                    ),
                    SegmentedButton(
                      expandedInsets: const EdgeInsets.symmetric(horizontal: 0),
                      emptySelectionAllowed: true,
                      selected: {viewModel.selectedSegment},
                      onSelectionChanged: (selectedSet) {
                        viewModel.handleSegmentChanged(selectedSet);
                        onSelected(viewModel.submitDateForSegment);
                        Navigator.pop(context);
                        HapticHelper.selection();
                      },
                      segments: options
                          .map((dt) => ButtonSegment(
                              value: dt.date?.submitFormat ?? 'no-date',
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
                      currentDay: DateTime.now(),
                      rangeStartDay: viewModel.selectedStartDateTime,
                      rangeEndDay: viewModel.selectedEndDateTime,
                      onDaySelected: (selectedDay, focusedDay) async {
                        viewModel.handleCalendarSelected(
                            selectedDay, focusedDay);
                      },
                      onFormatChanged: (_) {
                        // NOTE:Week選択時のエラーを回避
                        return;
                      },
                      calendarFormat: CalendarFormat.twoWeeks,
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                        todayTextStyle: TextStyle(
                            color:
                                Theme.of(context).colorScheme.secondaryFixed),
                        rangeStartDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary),
                        rangeEndDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary),
                        rangeStartTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                        rangeEndTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                        rangeHighlightColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                    const SizedBox(height: 10),
                    viewModel.selectedDateTime != null
                        ? TimeRangeLabel(
                            date: viewModel.selectedDateTime,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => TimePickerSheet(
                                  l10n: l10n,
                                  initialDate: viewModel.selectedDateTime,
                                  onSelected: (date) {
                                    if (date == null) return;
                                    viewModel.handleSelectedDateTime(date);
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                            onClearTime: () async {
                              viewModel.clearTime();
                            },
                          )
                        :
                        // 高さが変わらないようにする
                        const SizedBox(height: 44),
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
