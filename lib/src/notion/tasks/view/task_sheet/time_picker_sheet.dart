import 'package:flutter/material.dart';

import '../../../model/task.dart';
import '../../time_sheet_viewmodel.dart';

class TimePickerSheet extends StatelessWidget {
  final TaskDate? initialDate;
  final Function(TaskDate?) onSelected;

  static const durations = [
    Duration(minutes: 30),
    Duration(minutes: 60),
    Duration(minutes: 120),
    Duration(minutes: 240),
    Duration(minutes: 480),
  ];

  const TimePickerSheet({
    super.key,
    required this.initialDate,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = TimeSheetViewModel(initialDateTime: initialDate);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ドラッグハンドル
                Center(
                  child: Container(
                    width: 32,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('キャンセル'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('決定',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '開始',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 120,
                            child: TimePickerSpinner(
                              time: viewModel.selectedStartDateTime ??
                                  DateTime.now(),
                              is24HourMode: true,
                              normalTextStyle: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              highlightedTextStyle: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              spacing: 40,
                              itemHeight: 40,
                              isForce2Digits: true,
                              minutesInterval: 1,
                              onTimeChange: (date) {
                                // _handleStartTimeSelected(date);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '終了',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 120,
                            child: TimePickerSpinner(
                              time: viewModel.selectedEndDateTime ??
                                  DateTime.now(),
                              is24HourMode: true,
                              normalTextStyle: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              highlightedTextStyle: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              spacing: 40,
                              itemHeight: 40,
                              isForce2Digits: true,
                              minutesInterval: 1,
                              onTimeChange: (date) {
                                // _handleEndTimeSelected(date);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: durations.map((duration) {
                    final isSelected = viewModel.selectedEndDateTime != null &&
                        viewModel.selectedEndDateTime!.difference(
                                viewModel.selectedStartDateTime ??
                                    DateTime.now()) ==
                            duration;
                    return FilterChip(
                        label: Text('${duration.inMinutes}分'),
                        selected: isSelected,
                        onSelected: (_) => {
                              // _handleDurationSelected(duration);
                            });
                  }).toList(),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      // widget.onClear();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceVariant,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    child: const Text('クリア'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TimePickerSpinner extends StatelessWidget {
  final DateTime time;
  final bool is24HourMode;
  final TextStyle normalTextStyle;
  final TextStyle highlightedTextStyle;
  final double spacing;
  final double itemHeight;
  final bool isForce2Digits;
  final int minutesInterval;
  final Function(DateTime) onTimeChange;

  const TimePickerSpinner({
    super.key,
    required this.time,
    required this.is24HourMode,
    required this.normalTextStyle,
    required this.highlightedTextStyle,
    required this.spacing,
    required this.itemHeight,
    required this.isForce2Digits,
    required this.minutesInterval,
    required this.onTimeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _NumberPicker(
          value: time.hour,
          minValue: 0,
          maxValue: is24HourMode ? 23 : 12,
          normalTextStyle: normalTextStyle,
          highlightedTextStyle: highlightedTextStyle,
          itemHeight: itemHeight,
          isForce2Digits: isForce2Digits,
          onChanged: (value) {
            onTimeChange(DateTime(
              time.year,
              time.month,
              time.day,
              value,
              time.minute,
            ));
          },
        ),
        SizedBox(width: spacing),
        _NumberPicker(
          value: time.minute,
          minValue: 0,
          maxValue: 59,
          normalTextStyle: normalTextStyle,
          highlightedTextStyle: highlightedTextStyle,
          itemHeight: itemHeight,
          isForce2Digits: isForce2Digits,
          interval: minutesInterval,
          onChanged: (value) {
            onTimeChange(DateTime(
              time.year,
              time.month,
              time.day,
              time.hour,
              value,
            ));
          },
        ),
      ],
    );
  }
}

class _NumberPicker extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final TextStyle normalTextStyle;
  final TextStyle highlightedTextStyle;
  final double itemHeight;
  final bool isForce2Digits;
  final int interval;
  final Function(int) onChanged;

  const _NumberPicker({
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.normalTextStyle,
    required this.highlightedTextStyle,
    required this.itemHeight,
    required this.isForce2Digits,
    this.interval = 1,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight * 5,
      width: 60,
      child: ListWheelScrollView.useDelegate(
        itemExtent: itemHeight,
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(
          initialItem: value ~/ interval,
        ),
        onSelectedItemChanged: (index) {
          onChanged(index * interval);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: (maxValue - minValue) ~/ interval + 1,
          builder: (context, index) {
            final number = index * interval;
            final isSelected = number == value;
            return Center(
              child: Text(
                isForce2Digits
                    ? number.toString().padLeft(2, '0')
                    : number.toString(),
                style: isSelected ? highlightedTextStyle : normalTextStyle,
              ),
            );
          },
        ),
      ),
    );
  }
}
