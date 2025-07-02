import 'package:flutter/material.dart';

import '../../helpers/haptic_helper.dart';

/// ボトムシートの共通ウィジェット
/// SortOptionsBottomSheetとGroupOptionsBottomSheetで使用される共通の構造を提供
class BaseOptionsBottomSheet<T> extends StatelessWidget {
  final String title;
  final List<T> options;
  final T currentOption;
  final String Function(T option) getOptionLabel;
  final void Function(T option) onOptionSelected;

  const BaseOptionsBottomSheet({
    super.key,
    required this.title,
    required this.options,
    required this.currentOption,
    required this.getOptionLabel,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 32),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ドラッグハンドル
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // タイトル
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            const SizedBox(height: 16),

            // オプションリスト
            ...options.map((option) => _buildOptionItem(context, option)),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, T option) {
    final isSelected = option == currentOption;

    return InkWell(
      onTap: () async {
        await HapticHelper.light();
        onOptionSelected(option);

        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getOptionLabel(option),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}