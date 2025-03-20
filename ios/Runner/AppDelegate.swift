import Flutter
import UIKit
import home_widget
import workmanager

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // HomeWidgetのプラグイン登録コールバックを設定
    if #available(iOS 17, *) {
      HomeWidgetBackgroundWorker.setPluginRegistrantCallback { registry in
        GeneratedPluginRegistrant.register(with: registry)
      }
    } else {
      // iOS 17未満でもバックグラウンド処理を有効にする
      HomeWidgetBackgroundWorker.setPluginRegistrantCallback { registry in
        GeneratedPluginRegistrant.register(with: registry)
      }
    }
    
    // Workmanagerのプラグイン登録コールバックを設定
    WorkmanagerPlugin.setPluginRegistrantCallback { registry in
      GeneratedPluginRegistrant.register(with: registry)
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // バックグラウンドでURLを処理するためのメソッド
  override func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
    // HomeWidgetのバックグラウンド処理を呼び出す
    HomeWidgetBackgroundWorker.handleBackgroundURLSession(identifier: identifier, completionHandler: completionHandler)
  }
}
