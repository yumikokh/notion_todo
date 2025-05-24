import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../model/property.dart';
import '../../../../helpers/haptic_helper.dart';
import '../../../../settings/task_database/task_database_viewmodel.dart';

class TaskPrioritySheet extends ConsumerWidget {
  final SelectOption? selectedPriority;
  final Function(SelectOption?) onSelected;

  const TaskPrioritySheet({
    Key? key,
    required this.selectedPriority,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final taskDatabase = ref.watch(taskDatabaseViewModelProvider);
    final priorityOptions =
        taskDatabase.valueOrNull?.priority?.select.options ?? [];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(l.cancel),
                ),
                TextButton(
                  onPressed: () {
                    onSelected(null);
                    Navigator.pop(context);
                  },
                  child: Text(l.reset),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: priorityOptions.length,
              itemBuilder: (context, index) {
                final option = priorityOptions[index];
                return ListTile(
                  leading: Icon(
                    Icons.flag_rounded,
                    color: option.mColor,
                  ),
                  title: Text(option.name),
                  selected: selectedPriority?.id == option.id,
                  trailing: selectedPriority?.id == option.id
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () {
                    HapticHelper.selection();
                    onSelected(option);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
