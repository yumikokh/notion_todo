import 'package:flutter/material.dart';
import '../../../helpers/date.dart';

class TodayCalendarIcon extends StatelessWidget {
  final bool isSelected;
  final double size;

  const TodayCalendarIcon({
    super.key,
    required this.isSelected,
    this.size = 24,
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
              color: isSelected 
                  ? colorScheme.primary.withOpacity(0.1)
                  : colorScheme.surface,
              border: Border.all(
                color: isSelected 
                    ? colorScheme.primary
                    : colorScheme.outline,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          // カレンダーの上部（金具部分）
          Positioned(
            top: 0,
            left: size * 0.2,
            right: size * 0.2,
            child: Container(
              height: size * 0.15,
              decoration: BoxDecoration(
                color: isSelected 
                    ? colorScheme.primary
                    : colorScheme.outline,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
              ),
            ),
          ),
          // 日付の数字
          Positioned(
            bottom: size * 0.15,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontSize: size * 0.45,
                  fontWeight: FontWeight.bold,
                  color: isSelected 
                      ? colorScheme.primary
                      : colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}