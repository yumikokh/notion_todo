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
import 'package:home_widget/home_widget.dart';
import 'package:uni_links/uni_links.dart';

import 'src/app.dart';
import 'src/env/env.dart';
import 'src/notion/repository/notion_task_repository.dart';
import 'src/notion/tasks/task_viewmodel.dart';
import 'src/widget/widget_service.dart';
import 'firebase_options.dart';

// バックグラウンドコールバック関数（iOS 17のインタラクティブウィジェット用）
@pragma('vm:entry-point')
Future<void> interactivityCallback(Uri? uri) async {
  print('[HomeWidget] Interactivity callback called with URI: $uri');
  if (uri == null) return;

  // App Groupからデータを取得
  final sharedDefaults = await HomeWidget.getWidgetData<String>('appGroupId');
  if (sharedDefaults == null) return;

  try {
    // URLからタスクIDと完了状態を取得
    final pathSegments = uri.pathSegments;
    if (pathSegments.length >= 3 && pathSegments[0] == 'toggle') {
      final taskId = pathSegments[1];
      String isCompletedStr = pathSegments[2];

      // homeWidgetパラメータが含まれている場合は除去
      if (isCompletedStr.contains('&')) {
        isCompletedStr = isCompletedStr.split('&')[0];
      }

      final isCompleted = isCompletedStr.toLowerCase() == 'true';
      print('[HomeWidget] Updating task $taskId to $isCompleted');

      // ここでNotionのタスク状態を更新する処理を実装
      // 注意: このコンテキストではProviderは使用できないため、直接APIを呼び出す必要がある

      // バックグラウンド更新フラグを設定
      await HomeWidget.saveWidgetData('needs_background_update', true);
      await HomeWidget.saveWidgetData('last_updated_task_id', taskId);
      await HomeWidget.saveWidgetData('last_updated_task_state', isCompleted);

      // 処理完了を示すフラグを設定
      await HomeWidget.saveWidgetData('interactivity_completed', 'true');
      await HomeWidget.updateWidget(
        iOSName: 'TodayTasksWidget',
      );
    }
  } catch (e) {
    print('[HomeWidget] Error in interactivity callback: $e');
  }
}

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

  // HomeWidgetの初期化
  await HomeWidget.setAppGroupId('group.com.ymkokh.notionTodo');

  // インタラクティブウィジェット用のコールバックを登録
  await HomeWidget.registerInteractivityCallback(interactivityCallback);

  // URLスキームハンドラの初期化（アプリ起動時に実行）
  await initUniLinks();

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
      // HomeWidgetのコールバックを設定
      HomeWidget.widgetClicked.listen((uri) {
        // ウィジェットがクリックされたときの処理
        print('[HomeWidget] Widget clicked: $uri');
        if (uri != null) {
          try {
            // homeWidgetパラメータがある場合は、WidgetServiceを使用して処理
            if (uri.toString().contains('homeWidget')) {
              print('[HomeWidget] Processing widget URL: $uri');
              _processWidgetUrl(Uri.parse(uri.toString()), ref);
            } else {
              print(
                  '[HomeWidget] URL does not contain homeWidget parameter: $uri');
            }
          } catch (e) {
            print('ウィジェットURLのパースに失敗: $e');
          }
        }
      });

      // グローバルなURLスキームハンドラからのURLを処理
      _setupUrlHandling(ref);

      // アプリがアクティブになったときにバックグラウンド処理フラグをチェック
      _checkBackgroundUpdateFlag(ref);

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

  // バックグラウンド処理フラグをチェックする
  Future<void> _checkBackgroundUpdateFlag(WidgetRef ref) async {
    try {
      // App Groupからデータを取得
      final needsUpdate =
          await HomeWidget.getWidgetData<bool>('needs_background_update') ??
              false;

      if (needsUpdate) {
        print('[HomeWidget] Background update flag detected');

        // タスクIDと状態を取得
        final taskId =
            await HomeWidget.getWidgetData<String>('last_updated_task_id');
        final isCompleted =
            await HomeWidget.getWidgetData<bool>('last_updated_task_state');

        if (taskId != null && isCompleted != null) {
          print(
              '[HomeWidget] Updating task $taskId to $isCompleted from background');

          // Notionのタスク状態を更新
          final widgetService = ref.read(widgetServiceProvider);
          await widgetService.updateTaskCompletionInNotion(taskId, isCompleted);

          // フラグをリセット
          await HomeWidget.saveWidgetData('needs_background_update', false);

          // タスクリストを更新
          ref.invalidate(taskViewModelProvider(filterType: FilterType.today));
        }
      }
    } catch (e) {
      print('[HomeWidget] Error checking background update flag: $e');
    }
  }

  // URLハンドリングのセットアップ
  void _setupUrlHandling(WidgetRef ref) {
    // 初期リンクを処理
    getInitialLink().then((initialLink) {
      if (initialLink != null) {
        print('初期リンクを処理: $initialLink');
        _processWidgetUrl(Uri.parse(initialLink), ref);
      }
    }).catchError((e) {
      print('初期リンクの取得に失敗: $e');
    });

    // グローバルなURLスキームハンドラからのURLを処理
    if (_uriLinkSubscription != null) {
      print('グローバルURLハンドラが設定済み');
    } else {
      print('ローカルURLハンドラを設定');
      // バックアップとしてローカルハンドラを設定
      try {
        uriLinkStream.listen((Uri? uri) {
          if (uri != null) {
            print('ローカルハンドラで受信したURL: $uri');
            _processWidgetUrl(uri, ref);
          }
        }, onError: (error) {
          print('ローカルURLハンドラエラー: $error');
        });
      } catch (e) {
        print('ローカルURLハンドラの設定に失敗: $e');
      }
    }
  }

  // ウィジェットからのURLを処理
  void _processWidgetUrl(Uri uri, WidgetRef ref) async {
    print('処理するウィジェットURL: $uri');

    try {
      // ウィジェットサービスを使用してURLを処理
      final widgetService = ref.read(widgetServiceProvider);
      if (widgetService != null) {
        final handled = await widgetService.handleWidgetURL(uri);

        if (handled) {
          print('ウィジェットURLを正常に処理しました: $uri');
        } else {
          print('ウィジェットURLの処理に失敗しました: $uri');
        }
      } else {
        print('ウィジェットサービスが見つかりません');
      }
    } catch (e) {
      print('ウィジェットURL処理中にエラーが発生: $e');
    }
  }
}

// グローバルなURLスキームハンドラ
StreamSubscription? _uriLinkSubscription;

// URLスキームハンドラの初期化（グローバル）
Future<void> initUniLinks() async {
  // 既存のサブスクリプションをキャンセル
  await _uriLinkSubscription?.cancel();

  try {
    // 初期リンクを取得
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      print('初期リンク: $initialLink');
      // 初期リンクは後でアプリが起動した後に処理
    }

    // リンクのリスナーを設定
    _uriLinkSubscription = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        print('受信したURL (グローバル): $uri');
        // URLを受信したことをログに記録するだけ
        // 実際の処理はアプリ内で行う
      }
    }, onError: (error) {
      print('URLスキームリスナーエラー (グローバル): $error');
    });
  } catch (e) {
    print('URLスキームハンドラの初期化に失敗しました (グローバル): $e');
  }
}
