import 'package:flutter/foundation.dart';

mixin DebouncedStateMixin<T> {
  DateTime? _lastUpdateTime;
  static const _minimumInterval = Duration(seconds: 1);

  @protected
  bool shouldUpdateState() {
    final now = DateTime.now();
    if (_lastUpdateTime != null) {
      final timeSinceLastUpdate = now.difference(_lastUpdateTime!);
      if (timeSinceLastUpdate < _minimumInterval) {
        return false;
      }
    }
    _lastUpdateTime = now;
    return true;
  }

  @protected
  void resetDebounce() {
    _lastUpdateTime = null;
  }
}
