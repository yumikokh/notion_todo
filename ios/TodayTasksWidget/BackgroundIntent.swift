import AppIntents
import Foundation
import home_widget

@available(iOS 17, *)
public struct BackgroundIntent: AppIntent {
  static public var title: LocalizedStringResource = "HomeWidget Background Intent"

  @Parameter(title: "Widget URI")
  var url: URL?

  public init() {}

  public init(url: URL?) {
    self.url = url
  }

  public func perform() async throws -> some IntentResult {
    // アプリが完全に終了している状態でも動作するように、
    // UserDefaultsを使用してタスク情報を保存
    if let url = url, url.scheme == "notiontodo", url.host == "toggle" {
      let pathComponents = url.pathComponents
      if pathComponents.count >= 3 {
        let taskId = pathComponents[1]
        let isCompletedStr = pathComponents[2]
        let isCompleted = isCompletedStr.lowercased() == "true"
        
        // App Groupを使用してUserDefaultsを共有
        let sharedDefaults = UserDefaults(suiteName: "group.com.ymkokh.notionTodo")
        
        // 更新するタスク情報を保存
        let taskUpdateInfo = [
          "id": taskId,
          "isCompleted": isCompleted,
          "timestamp": Date().timeIntervalSince1970
        ] as [String : Any]
        
        sharedDefaults?.set(taskUpdateInfo, forKey: "pending_task_update")
        sharedDefaults?.synchronize()
      }
    }
    
    // 通常のHomeWidgetBackgroundWorker.runも実行
    await HomeWidgetBackgroundWorker.run(
      url: url,
      appGroup: "group.com.ymkokh.notionTodo")
    
    return .result()
  }
}

// アプリをバックグラウンドから起動するための拡張
@available(iOS 17, *)
@available(iOSApplicationExtension, unavailable)
extension BackgroundIntent: ForegroundContinuableIntent {}
