import AppIntents
import Foundation
import home_widget
import WidgetKit

@available(iOS 17, *)
public struct BackgroundIntent: AppIntent {
  static public var title: LocalizedStringResource = "HomeWidget Background Intent"

  // ウィジェットの更新を確実に行うためのヘルパー関数
  private func reloadWidgets() {
    WidgetCenter.shared.reloadTimelines(ofKind: "TodayTasksWidget")
    WidgetCenter.shared.reloadTimelines(ofKind: "TaskProgressWidget")
    
    // 確実に更新されるよう、少し遅延させて再度更新
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      WidgetCenter.shared.reloadTimelines(ofKind: "TodayTasksWidget")
      WidgetCenter.shared.reloadTimelines(ofKind: "TaskProgressWidget")
    }
  }

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
        
        // ウィジェットの見た目を即座に更新するために、タスクデータを直接更新
        if let tasksData = sharedDefaults?.object(forKey: "today_tasks") as? Data,
           let decodedTasks = try? JSONDecoder().decode([WidgetTask].self, from: tasksData) {
          
          // タスクを更新
          var updatedTasks = decodedTasks.map { task -> WidgetTask in
            if task.id == taskId {
              return WidgetTask(
                id: taskId,
                title: task.title,
                isCompleted: isCompleted,
                isSubmitted: false,
                isOverdue: false
              )
            }
            return task
          }
          
          // 完了したタスクは1秒後に削除（widget_service.dartの_completeTaskと同様）
          if isCompleted {
            // まず更新だけ行う
            if let encodedTasks = try? JSONEncoder().encode(updatedTasks) {
              sharedDefaults?.set(encodedTasks, forKey: "today_tasks")
              sharedDefaults?.synchronize()
              
              // 両方のウィジェットを更新
              reloadWidgets()
            }
            
            // 1秒後に削除処理を実行
            let taskId = taskId // キャプチャ用にローカル変数に保存
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1.0) {
              if let tasksData = sharedDefaults?.object(forKey: "today_tasks") as? Data,
                 let currentTasks = try? JSONDecoder().decode([WidgetTask].self, from: tasksData) {
                
                // 完了したタスクを削除
                let filteredTasks = currentTasks.filter { task in
                  return task.id != taskId || !task.isCompleted
                }
                
                // 更新したタスクデータを保存
                if let encodedTasks = try? JSONEncoder().encode(filteredTasks) {
                  sharedDefaults?.set(encodedTasks, forKey: "today_tasks")
                  sharedDefaults?.synchronize()
                  
                  // メインスレッドでウィジェットを更新
                  DispatchQueue.main.async {
                    reloadWidgets()
                  }
                }
              }
            }
          } else {
            // 更新したタスクデータを保存
            if let encodedTasks = try? JSONEncoder().encode(updatedTasks) {
              sharedDefaults?.set(encodedTasks, forKey: "today_tasks")
              sharedDefaults?.synchronize()
              
              // 両方のウィジェットを更新
              reloadWidgets()
            }
          }
        }
        
        sharedDefaults?.synchronize()
        
        // 両方のウィジェットを更新
        reloadWidgets()
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
