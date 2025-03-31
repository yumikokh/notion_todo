import 'package:flutter/material.dart';

import '../../../helpers/date.dart';
import '../../model/task.dart';

class DateLabel extends StatelessWidget {
  final BuildContext context;
  final TaskDate? date;
  final bool showToday;
  final bool showColor;
  final bool showIcon;
  final double? size;
  static final DateHelper d = DateHelper();

  const DateLabel(
      {super.key,
      required this.date,
      required this.showToday,
      required this.context,
      required this.showColor,
      required this.showIcon,
      this.size = 12.0});

  Color? get color {
    if (!showColor) return null;
    final dueDate = date;
    if (dueDate == null) return null;

    return TaskDate.getColor(context, dueDate);
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
