import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/widgets/base_options_bottom_sheet.dart';
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

    return BaseOptionsBottomSheet<GroupType>(
      title: l.group_by,
      options: const [
        GroupType.none,
        GroupType.date,
        GroupType.status,
        GroupType.priority,
      ],
      currentOption: currentGroupType,
      getOptionLabel: (option) => option.getLocalizedName(l),
      onOptionSelected: (option) {
        ref.read(taskGroupProvider.notifier).setGroupType(filterType, option);
      },
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
