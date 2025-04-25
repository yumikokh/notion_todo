import 'package:flutter/foundation.dart';

mixin DebouncedStateMixin<T> {
  Future<T>? _pendingFuture;

  @protected
  Future<T> debouncedFetch(Future<T> Function() fetchFunction) async {
    if (_pendingFuture != null) {
      return _pendingFuture!;
    }

    try {
      _pendingFuture = fetchFunction();
      final result = await _pendingFuture!;
      return result;
    } finally {
      _pendingFuture = null;
    }
  }
}
