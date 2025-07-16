import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../notion/model/task.dart';
import '../toggl_viewmodel.dart';

class TogglTimerButton extends ConsumerWidget {
  final Task task;
  final VoidCallback? onStarted;
  final VoidCallback? onStopped;

  const TogglTimerButton({
    super.key,
    required this.task,
    this.onStarted,
    this.onStopped,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final togglState = ref.watch(togglViewModelProvider);
    
    return togglState.when(
      loading: () => const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (state) {
        // Toggl連携が有効で設定が完了している場合のみ表示
        if (!state.isConfigured || !state.enabled) {
          return const SizedBox.shrink();
        }

        final isCurrentTaskRunning = state.currentTimeEntry?.description == task.title && 
                                   state.currentTimeEntry?.isRunning == true;
        final hasRunningTimer = state.currentTimeEntry?.isRunning == true;

        return IconButton(
          onPressed: state.isLoading ? null : () => _handleTogglPress(context, ref, isCurrentTaskRunning),
          icon: Icon(
            isCurrentTaskRunning 
                ? Icons.stop 
                : hasRunningTimer 
                    ? Icons.timer_off 
                    : Icons.play_arrow,
            color: isCurrentTaskRunning 
                ? Colors.red 
                : hasRunningTimer 
                    ? Colors.orange 
                    : Colors.green,
          ),
          tooltip: isCurrentTaskRunning 
              ? 'タイマーを停止' 
              : hasRunningTimer 
                  ? '他のタイマーが動作中です' 
                  : 'Togglタイマーを開始',
        );
      },
    );
  }

  Future<void> _handleTogglPress(BuildContext context, WidgetRef ref, bool isCurrentTaskRunning) async {
    final togglViewModel = ref.read(togglViewModelProvider.notifier);
    final togglState = ref.read(togglViewModelProvider).valueOrNull;

    if (isCurrentTaskRunning) {
      // 現在のタスクのタイマーを停止
      await togglViewModel.stopCurrentTimeEntry();
      onStopped?.call();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('「${task.title}」のタイマーを停止しました'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else if (togglState?.currentTimeEntry?.isRunning == true) {
      // 他のタイマーが動作中の場合、確認ダイアログを表示
      final shouldStop = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('タイマーの切り替え'),
          content: Text(
            '現在「${togglState!.currentTimeEntry!.description}」のタイマーが動作中です。\n'
            '停止して「${task.title}」のタイマーを開始しますか？'
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('キャンセル'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('切り替える'),
            ),
          ],
        ),
      );

      if (shouldStop == true) {
        await togglViewModel.stopCurrentTimeEntry();
        await togglViewModel.startTimeEntry(
          task.title,
          tags: ['notion_todo'],
        );
        onStarted?.call();
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('「${task.title}」のタイマーを開始しました'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } else {
      // 新しいタイマーを開始
      await togglViewModel.startTimeEntry(
        task.title,
        tags: ['notion_todo'],
      );
      onStarted?.call();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('「${task.title}」のタイマーを開始しました'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}