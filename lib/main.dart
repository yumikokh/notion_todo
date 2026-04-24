import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'src/common/background/background_fetch_service.dart';
import 'src/common/error.dart';
import 'src/app.dart';
import 'src/env/env.dart';
import 'src/widget/widget_service.dart';
import 'firebase_options.dart';

// バックグラウンドコールバック関数（iOS 17のインタラクティブウィジェット用）
@pragma('vm:entry-point')
Future<void> interactivityCallback(Uri? uri) async {
  await WidgetService.interactivityCallback(uri);
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  GoogleFonts.config.allowRuntimeFetching = false;

  const trackingEnabled = kReleaseMode;
  // const trackingEnabled = true; // dev: デバッグモードでもAnalyticsを有効にする

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAnalytics.instance
      .setAnalyticsCollectionEnabled(trackingEnabled);

  // ウィジェットの初期化
  await WidgetService.initialize(interactivityCallback);

  // BackgroundFetchの初期化
  await BackgroundFetchService.initialize();

  final app = ProviderScope(
    observers: trackingEnabled ? [SentryProviderObserver()] : [],
    child: const MyApp(),
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
        // リプレイのサンプリング率を設定（Sentry 9.0でexperimentalから昇格）
        options.replay.sessionSampleRate = kReleaseMode ? 0.01 : 0.0;
        options.replay.onErrorSampleRate = kReleaseMode ? 1.0 : 0.0;

        // 一時的なネットワークエラーをフィルタリング
        options.beforeSend = (event, hint) {
          final exceptions = event.exceptions;
          if (exceptions != null && exceptions.isNotEmpty) {
            final exceptionValue = exceptions.first.value ?? '';
            // バックグラウンドでの接続エラーを無視
            if (BackgroundConnectionException.isBackgroundConnectionError(
                exceptionValue)) {
              return null;
            }
            // SSL/TLSハンドシェイクエラーを無視
            if (exceptionValue.toLowerCase().contains('handshakeexception') ||
                exceptionValue
                    .toLowerCase()
                    .contains('connection terminated during handshake')) {
              return null;
            }
          }
          return event;
        };
      },
      appRunner: () => runApp(app),
    );
  } else {
    runApp(app);
  }

  FlutterNativeSplash.remove();
}

final class SentryProviderObserver extends ProviderObserver {
  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    // 特定のエラーを除外
    if (_shouldIgnoreError(error, context)) return;

    Sentry.captureException(
      error,
      stackTrace: stackTrace,
      withScope: (scope) {
        scope.setTag('provider',
            context.provider.name ?? context.provider.runtimeType.toString());
      },
    );
  }

  bool _shouldIgnoreError(Object error, ProviderObserverContext context) {
    // Provider破棄時のStateErrorを無視
    if (error is StateError) {
      return true;
    }

    // BackgroundFetchのPlatformExceptionを無視
    if (error is PlatformException && error.code == '1') {
      return true;
    }

    // バックグラウンドでのHTTP接続エラーを無視（iOSが接続を閉じた場合）
    if (BackgroundConnectionException.isBackgroundConnectionError(error)) {
      return true;
    }

    // SSL/TLSハンドシェイクエラーを無視（ネットワーク不安定時に発生）
    if (_isHandshakeError(error)) {
      return true;
    }

    return false;
  }

  /// SSL/TLSハンドシェイクエラーかどうかを判定
  bool _isHandshakeError(Object error) {
    final errorString = error.toString().toLowerCase();
    return errorString.contains('handshakeexception') ||
        errorString.contains('connection terminated during handshake');
  }
}
