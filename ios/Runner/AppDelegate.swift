import Flutter
import UIKit
// v2で有効化するため一時的にコメントアウト
// import home_widget

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // HomeWidgetのプラグイン登録コールバックを設定
    // v2で有効化するため一時的にコメントアウト
    /*
    HomeWidgetBackgroundWorker.setPluginRegistrantCallback { registry in
      GeneratedPluginRegistrant.register(with: registry)
    }
    */

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
