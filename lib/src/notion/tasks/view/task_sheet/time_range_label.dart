import 'package:flutter/material.dart';
import '../../../../helpers/date.dart';
import '../../../model/task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  String getStartTimeText(AppLocalizations l10n) {
    final date = this.date;
    if (date == null || date.start.isAllDay == true) {
      return l10n.select_time;
    }
    return d.formatDate(date.start.datetime.toLocal(), format: 'H:mm');
  }

  String? getDurationText(AppLocalizations l10n) {
    final date = this.date;
    if (date == null || date.start.isAllDay == true) {
      return null;
    }
    final end = date.end?.datetime;
    if (end == null) {
      return null;
    }
    final duration = end.difference(date.start.datetime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final timeStr = hours > 0
        ? minutes > 0
            ? l10n.duration_format_hours_minutes(hours, minutes)
            : l10n.duration_format_hours(hours)
        : l10n.duration_format_minutes(minutes);

    return '($timeStr)';
  }

  bool get showClearTimeButton {
    if (date?.start.isAllDay == true) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final startTimeText = getStartTimeText(l10n);
    final durationText = getDurationText(l10n);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
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
            Text(
              startTimeText,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            if (durationText != null) ...[
              const SizedBox(width: 4),
              Text(durationText, style: const TextStyle(fontSize: 12)),
            ],
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
