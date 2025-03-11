import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'src/app.dart';
import 'src/env/env.dart';
import 'src/notion/repository/notion_task_repository.dart';
import 'src/notion/tasks/task_viewmodel.dart';
import 'src/widget/widget_service.dart';
import 'firebase_options.dart';

final widgetService = WidgetService();
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  GoogleFonts.config.allowRuntimeFetching = false;

  const trackingEnabled = kReleaseMode;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAnalytics.instance
      .setAnalyticsCollectionEnabled(trackingEnabled);

  await widgetService.initialize(interactivityCallback);

  final app = ProviderScope(
    observers: trackingEnabled ? [SentryProviderObserver()] : [],
    child: const BackgroundFetchInitializer(
      child: MyApp(),
    ),
  );

  if (trackingEnabled) {
    await SentryFlutter.init(
      (options) {
        options.dsn = Env.sentryDsn;
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
        // The sampling rate for profiling is relative to tracesSampleRate
        // Setting to 1.0 will profile 100% of sampled transactions:
        options.profilesSampleRate = 1.0;
        // リプレイのサンプリング率を設定
        options.experimental.replay.sessionSampleRate =
            kReleaseMode ? 0.01 : 0.0;
        options.experimental.replay.onErrorSampleRate =
            kReleaseMode ? 1.0 : 0.0;
      },
      appRunner: () => runApp(app),
    );
  } else {
    runApp(app);
  }

  FlutterNativeSplash.remove();
}

class SentryProviderObserver extends ProviderObserver {
  void handleError(
    ProviderBase provider,
    Object error,
    StackTrace? stackTrace,
    ProviderContainer container,
  ) {
    // 特定のエラーを除外
    if (_shouldIgnoreError(error, provider)) return;

    Sentry.captureException(
      error,
      stackTrace: stackTrace,
      withScope: (scope) {
        scope.setTag(
            'provider', provider.name ?? provider.runtimeType.toString());
      },
    );
  }

  bool _shouldIgnoreError(Object error, ProviderBase provider) {
    // Provider破棄時のStateErrorを無視
    if (error is StateError) {
      return true;
    }

    // BackgroundFetchのPlatformExceptionを無視
    if (error is PlatformException && error.code == '1') {
      return true;
    }

    return false;
  }
}

class BackgroundFetchInitializer extends HookConsumerWidget {
  final Widget child;
  const BackgroundFetchInitializer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      BackgroundFetch.configure(
        BackgroundFetchConfig(minimumFetchInterval: 15),
        (String taskId) async {
          print("[BackgroundFetch] Event received $taskId");
          // fetchとバッジ更新
          await ref
              .read(taskViewModelProvider(filterType: FilterType.today).future);
          BackgroundFetch.finish(taskId);
        },
        (String taskId) {
          print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
          BackgroundFetch.finish(taskId);
        },
      );
      return null;
    }, []);

    return child;
  }
}

// バックグラウンドコールバック関数（iOS 17のインタラクティブウィジェット用）
@pragma('vm:entry-point')
Future<void> interactivityCallback(Uri? uri) async {
  print('[HomeWidget] Interactivity callback called with URI: $uri');
  if (uri == null) return;

  final action = uri.host;
  try {
    // URLからタスクIDと完了状態を取得
    final pathSegments = uri.pathSegments;
    if (action == 'toggle') {
      final taskId = pathSegments[0];
      String isCompletedStr = pathSegments[1];
      final isCompleted = isCompletedStr.toLowerCase() == 'true';
      print('[HomeWidget] Updating task $taskId to $isCompleted');
      await widgetService.completeTask(taskId, isCompleted);

      // TODO: APIリクエスト
    }
  } catch (e) {
    print('[HomeWidget] Error in interactivity callback: $e');
  }
}
