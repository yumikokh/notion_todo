import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/haptic_helper.dart';
import '../../common/filter_type.dart';
import '../task_group_provider.dart';

class GroupOptionsBottomSheet extends HookConsumerWidget {
  final FilterType filterType;

  const GroupOptionsBottomSheet({
    super.key,
    required this.filterType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGroupType = ref.watch(currentGroupTypeProvider(filterType));
    final l = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
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
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // タイトル
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Text(
                l.group_by,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const SizedBox(height: 16),

            // オプションリスト
            _buildOptionItem(context, ref, GroupType.none, currentGroupType),
            _buildOptionItem(context, ref, GroupType.date, currentGroupType),
            _buildOptionItem(context, ref, GroupType.status, currentGroupType),
            _buildOptionItem(
                context, ref, GroupType.priority, currentGroupType),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, WidgetRef ref, GroupType option,
      GroupType currentOption) {
    final isSelected = option == currentOption;
    final l = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () async {
        await HapticHelper.light();
        // GroupTypeを更新
        ref.read(taskGroupProvider.notifier).setGroupType(filterType, option);

        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
Future<void> showGroupOptionsBottomSheet(
  BuildContext context,
  FilterType filterType,
) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) => GroupOptionsBottomSheet(filterType: filterType),
  );
}
