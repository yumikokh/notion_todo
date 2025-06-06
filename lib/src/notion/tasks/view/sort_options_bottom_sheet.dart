import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/haptic_helper.dart';
import '../../common/filter_type.dart';
import '../task_sort_provider.dart';

class SortOptionsBottomSheet extends HookConsumerWidget {
  final FilterType filterType;

  const SortOptionsBottomSheet({
    super.key,
    required this.filterType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSortType = ref.watch(currentSortTypeProvider(filterType));
    final l = AppLocalizations.of(context)!;

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
              ),
            ),

            // タイトル
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Text(
                l.sort_by,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            const SizedBox(height: 16),

            // オプションリスト
            _buildOptionItem(context, ref, SortType.system, currentSortType),
            _buildOptionItem(context, ref, SortType.date, currentSortType),
            _buildOptionItem(context, ref, SortType.title, currentSortType),
            _buildOptionItem(context, ref, SortType.priority, currentSortType),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, WidgetRef ref, SortType option,
      SortType currentOption) {
    final isSelected = option == currentOption;
    final l = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () async {
        await HapticHelper.light();
        // SortTypeを更新
        ref.read(taskSortProvider.notifier).setSortType(filterType, option);

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
                  Text(option.getLocalizedName(l),
                      style: Theme.of(context).textTheme.titleSmall)
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

// ボトムシートを表示する関数
Future<void> showSortOptionsBottomSheet(
  BuildContext context,
  FilterType filterType,
) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) => SortOptionsBottomSheet(filterType: filterType),
  );
}
