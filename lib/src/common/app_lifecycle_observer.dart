import 'package:flutter/material.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  final VoidCallback onAppResumed;

  AppLifecycleObserver(this.onAppResumed);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onAppResumed();
    }
  }
}
