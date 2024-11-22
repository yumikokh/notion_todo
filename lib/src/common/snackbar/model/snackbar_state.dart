import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'snackbar_state.freezed.dart';

@freezed
class SnackbarState with _$SnackbarState {
  const factory SnackbarState({
    required String message,
    @Default(SnackbarType.info) SnackbarType type,
    VoidCallback? onUndo,
  }) = _SnackbarState;
}

enum SnackbarType {
  success,
  error,
  info,
}
