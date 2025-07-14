import 'package:flutter/material.dart';

class TodayCalendarIcon extends StatelessWidget {
  final bool isSelected;
  final double size;

  const TodayCalendarIcon({
    super.key,
    required this.isSelected,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final day = now.day.toString();
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // カレンダーの背景
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.8,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // カレンダーの上部（金具部分）
          Positioned(
            top: size * 0,
            left: size * 0,
            right: size * 0,
            child: Container(
              height: size * 0.28,
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.onSecondaryContainer
                    : Colors.transparent,
                border: Border.all(
                  color: colorScheme.onSecondaryContainer,
                  width: 1.8,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
              ),
            ),
          ),
          // 日付の数字
          Positioned(
            bottom: size * 0.1,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                    fontSize: size * 0.5,
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSecondaryContainer),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
