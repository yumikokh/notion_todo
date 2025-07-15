import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/ui/custom_popup_menu.dart';
import '../../../generated/app_localizations.dart';
import '../../../helpers/haptic_helper.dart';
import '../../model/task.dart';
import '../task_viewmodel.dart';

class TaskActionsMenu extends HookConsumerWidget {
  final Task task;
  final TaskViewModel taskViewModel;

  const TaskActionsMenu({
    super.key,
    required this.task,
    required this.taskViewModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    
    final menuItems = [
      CustomPopupMenuItem(
        id: 'copy_notion_link',
        title: Text(l.copy_notion_link),
        leading: const Icon(Icons.link),
        onTap: () async {
          await _copyNotionLink(context, l);
        },
      ),
      CustomPopupMenuItem(
        id: 'copy_title',
        title: Text(l.copy_title),
        leading: const Icon(Icons.content_copy),
        onTap: () async {
          await _copyTitle(context, l);
        },
      ),
      CustomPopupMenuItem(
        id: 'open_in_notion',
        title: Text(l.open_in_notion),
        leading: const Icon(Icons.open_in_new),
        onTap: () async {
          await _openInNotion(context, l);
        },
      ),
      CustomPopupMenuItem(
        id: 'duplicate',
        title: Text(l.duplicate),
        leading: const Icon(Icons.copy_all),
        onTap: () async {
          await _duplicateTask(context, l);
        },
      ),
    ];

    final popupMenu = useCustomPopupMenu(
      items: menuItems,
      offset: const Offset(0, -8),
    );

    return Container(
      key: popupMenu.buttonKey,
      child: GestureDetector(
        onLongPress: () {
          HapticHelper.medium();
          popupMenu.show();
        },
        child: const SizedBox.shrink(),
      ),
    );
  }

  Future<void> _copyNotionLink(BuildContext context, AppLocalizations l) async {
    final taskUrl = task.url;
    if (taskUrl == null) {
      _showSnackBar(context, l.error_no_notion_link);
      return;
    }

    try {
      await Clipboard.setData(ClipboardData(text: taskUrl));
      _showSnackBar(context, l.notion_link_copied);
    } catch (e) {
      _showSnackBar(context, l.error_copy_failed);
    }
  }

  Future<void> _copyTitle(BuildContext context, AppLocalizations l) async {
    try {
      await Clipboard.setData(ClipboardData(text: task.title));
      _showSnackBar(context, l.title_copied);
    } catch (e) {
      _showSnackBar(context, l.error_copy_failed);
    }
  }

  Future<void> _openInNotion(BuildContext context, AppLocalizations l) async {
    final taskUrl = task.url;
    if (taskUrl == null) {
      _showSnackBar(context, l.error_no_notion_link);
      return;
    }

    try {
      final url = Uri.parse(taskUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        _showSnackBar(context, l.error_cannot_open_notion);
      }
    } catch (e) {
      _showSnackBar(context, l.error_cannot_open_notion);
    }
  }

  Future<void> _duplicateTask(BuildContext context, AppLocalizations l) async {
    try {
      final duplicatedTask = Task(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        title: '${task.title} (${l.copy})',
        status: const TaskStatus.checkbox(checkbox: false),
        dueDate: task.dueDate,
        url: null, // 複製されたタスクは新しいタスクなのでurlはnull
        priority: task.priority,
      );

      await taskViewModel.addTask(duplicatedTask);
      _showSnackBar(context, l.task_duplicated);
    } catch (e) {
      _showSnackBar(context, l.error_duplicate_failed);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}