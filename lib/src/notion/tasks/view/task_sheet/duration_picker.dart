import 'package:flutter/cupertino.dart';

class DurationPicker extends StatelessWidget {
  const DurationPicker({
    super.key,
    required this.initialDuration,
    required this.onDurationChanged,
    this.maxHours = 24,
    this.maxMinutes = 60,
    this.minuteInterval = 1,
  });

  final Duration? initialDuration;
  final void Function(Duration) onDurationChanged;
  final int maxHours;
  final int maxMinutes;
  final int minuteInterval;

  @override
  Widget build(BuildContext context) {
    final hours = initialDuration?.inHours ?? 0;
    final minutes = initialDuration?.inMinutes.remainder(60) ?? 0;

    return Row(
      children: [
        Expanded(
          child: CupertinoPicker(
            itemExtent: 32,
            onSelectedItemChanged: (index) {
              final duration = Duration(
                hours: index,
                minutes: minutes,
              );
              onDurationChanged(duration);
            },
            scrollController: FixedExtentScrollController(
              initialItem: hours,
            ),
            children: List.generate(maxHours + 1, (index) {
              return Center(child: Text('$index'));
            }),
          ),
        ),
        const Center(child: Text(':')),
        Expanded(
          child: CupertinoPicker(
            itemExtent: 32,
            onSelectedItemChanged: (index) {
              final duration = Duration(
                hours: initialDuration?.inHours ?? 0,
                minutes: index * minuteInterval,
              );
              onDurationChanged(duration);
            },
            scrollController: FixedExtentScrollController(
              initialItem: minutes ~/ minuteInterval,
            ),
            children:
                List.generate((maxMinutes / minuteInterval).ceil(), (index) {
              return Center(
                child:
                    Text((index * minuteInterval).toString().padLeft(2, '0')),
              );
            }),
          ),
        ),
      ],
    );
  }
}
