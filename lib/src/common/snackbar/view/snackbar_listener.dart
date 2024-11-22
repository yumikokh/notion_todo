import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/snackbar_state.dart';
import '../snackbar.dart';

class SnackbarListener extends HookConsumerWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final Widget child;

  const SnackbarListener({
    super.key,
    required this.scaffoldMessengerKey,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SnackbarState?>(
      snackbarProvider,
      (previous, current) {
        if (current == null) return;
        final undo = current.onUndo;
        final snackBar = SnackBar(
          content: Text(current.message),
          action: current.onUndo != null
              ? SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    if (undo != null) undo();
                  },
                )
              : null,
          duration: const Duration(milliseconds: 800),
        );

        // FIXME: 同時表示するとき不自然
        scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
        ref.read(snackbarProvider.notifier).clear();
      },
    );

    return child;
  }
}
