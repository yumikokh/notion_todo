import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../helpers/haptic_helper.dart';
import '../../../settings/task_database/task_database_viewmodel.dart';
import '../../model/property.dart';
import '../../model/task.dart';

class TaskStarButton extends HookConsumerWidget {
  const TaskStarButton({
    super.key,
    required this.task,
    required this.onInProgressChanged,
  });

  final Task task;
  final Future<void> Function(Task task) onInProgressChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;

    if (task.status is! TaskStatusStatus) {
      return const SizedBox.shrink();
    }

    final statusProperty =
        ref.read(taskDatabaseViewModelProvider).valueOrNull?.status;
    if (statusProperty is! StatusCompleteStatusProperty) {
      return const SizedBox.shrink();
    }
    final inProgressOption = statusProperty.inProgressOption;

    final stared = useState(
        inProgressOption != null && task.isInProgress(inProgressOption));

    useEffect(() {
      stared.value =
          inProgressOption != null && task.isInProgress(inProgressOption);
      return null;
    }, [inProgressOption, task]);

    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () async {
          final taskDatabase =
              await ref.read(taskDatabaseViewModelProvider.future);
          if (taskDatabase?.status is CheckboxCompleteStatusProperty) {
            return;
          }
          if (taskDatabase?.status
              case StatusCompleteStatusProperty(inProgressOption: null)) {
            if (context.mounted) {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(l.task_star_button_dialog_title,
                      style: const TextStyle(fontSize: 18)),
                  content: Text(l.task_star_button_dialog_content),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(l.task_star_button_dialog_cancel),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, '/settings/task_database');
                      },
                      child: Text(l.task_star_button_dialog_settings),
                    ),
                  ],
                ),
              );
              return;
            }
          }

          if (!stared.value) {
            HapticHelper.selection();
          }
          stared.value = !stared.value;
          await onInProgressChanged(task);
        },
        child: stared.value
            ? Icon(Icons.star_rounded,
                size: 24, color: Theme.of(context).colorScheme.secondary)
            : Icon(Icons.star_border_rounded,
                size: 24, color: Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}
