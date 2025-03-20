import Flutter
import UIKit
import home_widget

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // HomeWidgetのプラグイン登録コールバックを設定
    HomeWidgetBackgroundWorker.setPluginRegistrantCallback { registry in
      GeneratedPluginRegistrant.register(with: registry)
    }
    
    // アプリ起動時にペンディング中のタスク更新を処理
    processPendingTaskUpdates()

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // ペンディング中のタスク更新を処理するメソッド
  private func processPendingTaskUpdates() {
    let sharedDefaults = UserDefaults(suiteName: "group.com.ymkokh.notionTodo")
    if let taskUpdateInfo = sharedDefaults?.object(forKey: "pending_task_update") as? [String: Any] {
      // ペンディング中のタスク更新情報をクリア
      sharedDefaults?.removeObject(forKey: "pending_task_update")
      sharedDefaults?.synchronize()
      
      // タスク更新情報をJSONに変換
      if let taskId = taskUpdateInfo["id"] as? String,
         let isCompleted = taskUpdateInfo["isCompleted"] as? Bool {
        // URLスキームを構築
        let urlString = "notiontodo://toggle/\(taskId)/\(isCompleted)"
        if let url = URL(string: urlString) {
          // HomeWidgetBackgroundWorkerを使用してURLを処理
          if #available(iOS 17, *) {
            Task {
              await HomeWidgetBackgroundWorker.run(
                url: url,
                appGroup: "group.com.ymkokh.notionTodo")
            }
          }
        }
      }
    }
  }
}
