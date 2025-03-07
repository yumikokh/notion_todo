import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';

import '../../../settings/settings_viewmodel.dart';
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

  // タイマーを管理するための静的変数
  static Timer? _bannerTimer;

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
            duration: const Duration(milliseconds: 2000),
            behavior: SnackBarBehavior.fixed);

        scaffoldMessengerKey.currentState?.clearSnackBars();
        scaffoldMessengerKey.currentState?.clearMaterialBanners();

        // 前のタイマーがあればキャンセル
        _bannerTimer?.cancel();

        if (current.isFloating) {
          // snackbarが隠れる場合は上部バナーで表示
          scaffoldMessengerKey.currentState
              ?.showMaterialBanner(createTopSnackBar(context, ref, current));

          // 新しいタイマーを設定
          _bannerTimer = Timer(const Duration(milliseconds: 2000), () {
            scaffoldMessengerKey.currentState?.clearMaterialBanners();
          });
        } else {
          scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
          ref.read(snackbarProvider.notifier).clear();
        }
      },
    );

    return child;
  }

  MaterialBanner createTopSnackBar(
      BuildContext context, WidgetRef ref, SnackbarState current) {
    // MaterialBannerの色をSnackBarと同じにする
    final themeMode = ref.watch(settingsViewModelProvider).themeMode;
    final backgroundColor = switch (themeMode) {
      ThemeMode.light => Theme.of(context).colorScheme.onSurface,
      ThemeMode.dark => Theme.of(context).colorScheme.surface,
      ThemeMode.system =>
        MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.surface,
    };
    final textColor = switch (themeMode) {
      ThemeMode.light => Theme.of(context).colorScheme.surface,
      ThemeMode.dark => Theme.of(context).colorScheme.onSurface,
      ThemeMode.system =>
        MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.onSurface,
    };
    final undoTextColor = textColor;

    final undo = current.onUndo;

    return MaterialBanner(
      content: Text(current.message),
      backgroundColor: backgroundColor,
      contentTextStyle: TextStyle(color: textColor),
      actions: undo != null
          ? [
              TextButton(
                  onPressed: undo,
                  child: Text('Undo', style: TextStyle(color: undoTextColor)))
            ]
          // 空だとエラーになる
          : [const Text("")],
    );
  }
}
