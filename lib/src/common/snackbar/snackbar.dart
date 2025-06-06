import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'model/snackbar_state.dart';

part 'snackbar.g.dart';

@riverpod
class Snackbar extends _$Snackbar {
  @override
  SnackbarState? build() => null;

  void show(String message,
      {SnackbarType type = SnackbarType.info,
      bool isFloating = false,
      VoidCallback? onUndo}) {
    state = SnackbarState(
      message: message,
      type: type,
      onUndo: onUndo,
      isFloating: isFloating,
    );
  }

  void clear() {
    state = null;
  }
}
