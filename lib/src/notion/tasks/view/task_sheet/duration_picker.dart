import 'package:flutter/cupertino.dart';

class DurationPicker extends StatelessWidget {
  const DurationPicker({
    super.key,
    required this.initialDuration,
    required this.onDurationChanged,
    this.maxHours = 16,
    this.maxMinutes = 60,
  });

  final Duration? initialDuration;
  final void Function(Duration) onDurationChanged;
  final int maxHours;
  final int maxMinutes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoPicker(
            itemExtent: 32,
            onSelectedItemChanged: (index) {
              final duration = Duration(
                hours: index,
                minutes: initialDuration?.inMinutes.remainder(60) ?? 0,
              );
              onDurationChanged(duration);
            },
            scrollController: FixedExtentScrollController(
              initialItem: initialDuration?.inHours ?? 0,
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
                minutes: index,
              );
              onDurationChanged(duration);
            },
            scrollController: FixedExtentScrollController(
              initialItem: initialDuration?.inMinutes.remainder(60) ?? 0,
            ),
            children: List.generate(maxMinutes, (index) {
              return Center(
                child: Text(index.toString().padLeft(2, '0')),
              );
            }),
          ),
        ),
      ],
    );
  }
}
