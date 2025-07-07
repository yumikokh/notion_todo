import 'package:flutter/material.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/widgets/base_options_bottom_sheet.dart';
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

    return BaseOptionsBottomSheet<SortType>(
      title: l.sort_by,
      options: const [
        SortType.system,
        SortType.date,
        SortType.title,
        SortType.priority,
      ],
      currentOption: currentSortType,
      getOptionLabel: (option) => option.getLocalizedName(l),
      onOptionSelected: (option) {
        ref.read(taskSortProvider.notifier).setSortType(filterType, option);
      },
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
