import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:background_fetch/background_fetch.dart';

import 'src/app.dart';
import 'src/env/env.dart';
import 'src/notion/repository/notion_task_repository.dart';
import 'src/notion/tasks/task_viewmodel.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initATT();

  await SentryFlutter.init(
    (options) {
      options.dsn = Env.sentryDsn;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      ProviderScope(
        observers: [SentryProviderObserver()],
        child: const BackgroundFetchInitializer(
          child: MyApp(),
        ),
      ),
    ),
  );

  FlutterNativeSplash.remove();
}

class SentryProviderObserver extends ProviderObserver {
  void handleError(
    ProviderBase provider,
    Object error,
    StackTrace? stackTrace,
    ProviderContainer container,
  ) {
    Sentry.captureException(
      error,
      stackTrace: stackTrace,
      withScope: (scope) {
        scope.setTag(
            'provider', provider.name ?? provider.runtimeType.toString());
      },
    );
  }
}

Future<void> initATT() async {
  if (await AppTrackingTransparency.trackingAuthorizationStatus ==
      TrackingStatus.notDetermined) {
    await Future.delayed(const Duration(milliseconds: 200));
    await AppTrackingTransparency.requestTrackingAuthorization();
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
