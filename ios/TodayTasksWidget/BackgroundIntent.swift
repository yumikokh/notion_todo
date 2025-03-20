import AppIntents
import Foundation
import home_widget
import WidgetKit

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
        
        // ウィジェットの見た目を即座に更新するために、タスクデータを直接更新
        if let tasksData = sharedDefaults?.object(forKey: "today_tasks") as? Data,
           let decodedTasks = try? JSONSerialization.jsonObject(with: tasksData) as? [[String: Any]] {
          
          // タスクを更新
          var updatedTasks = [[String: Any]]()
          for var task in decodedTasks {
            if let id = task["id"] as? String, id == taskId {
              task["isCompleted"] = isCompleted
              task["isSubmitted"] = false
              task["isOverdue"] = false
            }
            updatedTasks.append(task)
          }
          
          // 完了したタスクは1秒後に削除（widget_service.dartの_completeTaskと同様）
          if isCompleted {
            // まず更新だけ行う
            if let encodedTasks = try? JSONSerialization.data(withJSONObject: updatedTasks) {
              sharedDefaults?.set(encodedTasks, forKey: "today_tasks")
            }
            
            // 1秒後に削除処理を実行
            let taskId = taskId // キャプチャ用にローカル変数に保存
            let delayTime = DispatchTime.now() + 1.0
            DispatchQueue.main.asyncAfter(deadline: delayTime, execute: DispatchWorkItem(block: {
              if let tasksData = sharedDefaults?.object(forKey: "today_tasks") as? Data,
                 let currentTasks = try? JSONSerialization.jsonObject(with: tasksData) as? [[String: Any]] {
                
                // 完了したタスクを削除
                let filteredTasks = currentTasks.filter { task in
                  if let id = task["id"] as? String,
                     let completed = task["isCompleted"] as? Bool {
                    return id != taskId || !completed
                  }
                  return true
                }
                
                // 更新したタスクデータを保存
                if let encodedTasks = try? JSONSerialization.data(withJSONObject: filteredTasks) {
                  sharedDefaults?.set(encodedTasks, forKey: "today_tasks")
                  sharedDefaults?.synchronize()
                  
                  // 両方のウィジェットを更新
                  WidgetCenter.shared.reloadTimelines(ofKind: "TodayTasksWidget")
                  WidgetCenter.shared.reloadTimelines(ofKind: "TaskProgressWidget")
                }
              }
            }))
          } else {
            // 更新したタスクデータを保存
            if let encodedTasks = try? JSONSerialization.data(withJSONObject: updatedTasks) {
              sharedDefaults?.set(encodedTasks, forKey: "today_tasks")
            }
          }
        }
        
        sharedDefaults?.synchronize()
        
        // 両方のウィジェットを更新
        WidgetCenter.shared.reloadTimelines(ofKind: "TodayTasksWidget")
        WidgetCenter.shared.reloadTimelines(ofKind: "TaskProgressWidget")
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
