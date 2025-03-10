import 'package:flutter/material.dart';

import '../../../helpers/date.dart';
import '../../model/task.dart';

class DateLabel extends StatelessWidget {
  final BuildContext context;
  final TaskDate? date;
  final bool showToday;
  final bool showColor;
  final bool showIcon;

  static final DateHelper d = DateHelper();

  const DateLabel(
      {super.key,
      required this.date,
      required this.showToday,
      required this.context,
      required this.showColor,
      required this.showIcon});

  Color? get color {
    if (!showColor) return null;
    final dueDate = date;
    if (dueDate == null) return null;
    final now = DateTime.now();
    final dueDateStart = dueDate.start.datetime;
    final dueDateEnd = dueDate.end?.datetime;

    // 終日かつ今日
    if (dueDateEnd == null &&
        d.isToday(dueDateStart) &&
        dueDate.start.isAllDay == true) {
      return Theme.of(context).colorScheme.tertiary; // 今日だったら青
    }

    // 時間があり、すぎている
    if ((dueDateEnd != null && dueDateEnd.isBefore(now)) ||
        (dueDateEnd == null && dueDateStart.isBefore(now))) {
      return Theme.of(context).colorScheme.error; // 過ぎてたら赤
    }

    return Theme.of(context).colorScheme.secondary; // それ以外は灰色
  }

  List<String> get dateStrings {
    final dueDate = date;
    if (dueDate == null) return [];
    final dueDateStart = dueDate.start;
    final dueDateEnd = dueDate.end;
    final isSameDay = dueDateEnd != null &&
        d.isSameDay(dueDateStart.datetime, dueDateEnd.datetime);
    final noTime = dueDateStart.isAllDay;
    // NOTE: showToday=falseでも、今日 -> 今日は表示する
    final showToday = (noTime && isSameDay) || this.showToday;

    return [
      d.formatDateTime(dueDateStart.datetime, dueDateStart.isAllDay,
          showToday: showToday),
      if (dueDateEnd != null)
        d.formatDateTime(dueDateEnd.datetime, dueDateEnd.isAllDay,
            showToday: showToday, showOnlyTime: isSameDay),
    ].whereType<String>().toList();
  }

  double get size => 12.0;

  @override
  Widget build(BuildContext context) {
    if (dateStrings.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        if (showIcon) Icon(Icons.event_rounded, size: size, color: color),
        if (showIcon) const SizedBox(width: 2),
        dateStrings.length == 1
            ? Text(
                dateStrings[0],
                style: TextStyle(fontSize: size, color: color),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(dateStrings[0],
                      style: TextStyle(fontSize: size, color: color)),
                  Icon(Icons.arrow_right_alt_rounded, size: size, color: color),
                  Text(dateStrings[1],
                      style: TextStyle(fontSize: size, color: color)),
                ],
              ),
      ],
    );
  }
}
