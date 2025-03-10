import SwiftUI
import WidgetKit

// MARK: - TodayTasksWidget
// タスク一覧ウィジェットの定義
struct TodayTasksWidget: Widget {
  let kind: String = "TodayTasksWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      TodayTasksWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Today")  // Widgetギャラリーでの表示名
    .description("Today's tasks")  // Widgetの説明
    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])  // サポートするWidgetサイズ
  }
}

// MARK: - TaskProgressWidget
// 進捗ウィジェットの定義
struct TaskProgressWidget: Widget {
  let kind: String = "TaskProgressWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      TaskProgressWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("タスク進捗")
    .description("今日のタスクの進捗状況を表示します")
    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
  }
}

// MARK: - TimelineEntry
// Widgetに表示するデータモデル
struct SimpleEntry: TimelineEntry {
  let date: Date
  let tasks: [String]

  // 完了したタスクの数を計算（タスクがない場合は0を返す）
  var completedTasksCount: Int {
    if tasks.count == 1 && tasks[0] == "タスクがありません" {
      return 0
    }
    return 0  // 実際のアプリでは完了したタスクの数を返す
  }

  // 全タスクの数を計算（タスクがない場合は0を返す）
  var totalTasksCount: Int {
    if tasks.count == 1 && tasks[0] == "タスクがありません" {
      return 0
    }
    return tasks.count
  }

  // 残りのタスク数を計算
  var remainingTasksCount: Int {
    return totalTasksCount - completedTasksCount
  }

  // 進捗率を計算（0.0〜1.0）
  var progressPercentage: Double {
    if totalTasksCount == 0 {
      return 1.0  // タスクがない場合は100%完了とみなす
    }
    return Double(completedTasksCount) / Double(totalTasksCount)
  }
}

// MARK: - TimelineProvider
// TimelineProviderはWidgetの表示内容とその更新タイミングを管理するプロトコル
// Widgetの表示内容と更新タイミングを制御する3つのメソッドを実装する必要がある
struct Provider: TimelineProvider {
  // MARK: placeholder
  // Widgetが最初に表示される際やプレビュー時に使用されるサンプルデータを提供する
  // システムがWidgetを表示する準備をしている間に表示される一時的なエントリー
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), tasks: ["サンプルタスク1", "サンプルタスク2", "サンプルタスク3"])
  }

  // MARK: getSnapshot
  // Widgetギャラリーでの表示やプレビュー用のデータを提供する
  // ユーザーがWidgetを選択する際に表示される内容を定義
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
    let entry = SimpleEntry(date: Date(), tasks: ["サンプルタスク1", "サンプルタスク2", "サンプルタスク3"])
    completion(entry)
  }

  // MARK: getTimeline
  // 実際のWidgetデータと更新スケジュールを提供する最も重要なメソッド
  // いつ、どのようなデータでWidgetを更新するかを定義
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
    var entries: [SimpleEntry] = []

    // ユーザーデフォルトからタスクを取得
    // App GroupのUserDefaultsを使用してアプリとWidget間でデータを共有
    let sharedDefaults = UserDefaults(suiteName: "group.com.ymkokh.notionTodo")
    var tasks: [String] = []

    // データ形式がDataの場合の処理
    if let tasksData = sharedDefaults?.object(forKey: "today_tasks") as? Data {
      if let decodedTasks = try? JSONDecoder().decode([String].self, from: tasksData) {
        tasks = decodedTasks
      }
    } else if let tasksString = sharedDefaults?.string(forKey: "today_tasks") {
      // データ形式が文字列の場合の処理
      if let data = tasksString.data(using: .utf8),
        let decodedTasks = try? JSONDecoder().decode([String].self, from: data)
      {
        tasks = decodedTasks
      }
    }

    // タスクが空の場合のデフォルトメッセージ
    if tasks.isEmpty {
      tasks = ["タスクがありません"]
    }

    // 現在の日付でエントリーを作成
    let currentDate = Date()
    let entry = SimpleEntry(date: currentDate, tasks: tasks)
    entries.append(entry)

    // 次の更新時間（1時間後）を設定
    // この設定により、Widgetは1時間ごとに更新される
    let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!

    // タイムラインを作成して完了ハンドラを呼び出す
    // .after(nextUpdateDate)は指定した時間後に更新することを示す
    let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
    completion(timeline)
  }
}
