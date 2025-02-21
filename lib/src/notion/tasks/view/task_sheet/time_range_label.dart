import 'package:flutter/material.dart';
import '../../../../helpers/date.dart';
import '../../../model/task.dart';

class TimeRangeLabel extends StatelessWidget {
  final TaskDate? date;
  final VoidCallback onTap;
  final VoidCallback onClearTime;
  static final DateHelper d = DateHelper();

  const TimeRangeLabel({
    super.key,
    required this.date,
    required this.onTap,
    required this.onClearTime,
  });

  List<String> get timeRangeText {
    final date = this.date;
    const selectTimeText = '時間を選択';
    if (date == null || date.start.isAllDay == true) {
      return [selectTimeText];
    }

    final startText = d.formatDateTime(date.start);
    if (startText == null) {
      return [selectTimeText];
    }

    final end = date.end;
    if (end == null) {
      return [startText];
    }

    final endText = d.formatDateTime(end);
    if (endText == null) {
      return [selectTimeText];
    }
    return [startText, endText];
  }

  bool get showClearTimeButton {
    if (date?.start.isAllDay == true) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            if (showClearTimeButton) const Spacer(),
            timeRangeText.length == 1
                ? Text(timeRangeText[0])
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(timeRangeText[0]),
                      const Icon(Icons.arrow_right_alt_rounded, size: 16),
                      Text(timeRangeText[1]),
                    ],
                  ),
            if (showClearTimeButton) ...[
              const SizedBox(width: 12),
              SizedBox(
                width: 18,
                height: 18,
                child: IconButton.filledTonal(
                  onPressed: onClearTime,
                  icon: const Icon(Icons.close_rounded),
                  iconSize: 12,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
