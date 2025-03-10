import SwiftUI
import WidgetKit

// MARK: - WidgetTask
// ウィジェットで表示するタスクデータ構造
struct WidgetTask: Codable, Identifiable {
  var id: String
  var title: String
  var isCompleted: Bool

  // タスクがない場合の特別なケース
  static var empty: WidgetTask {
    return WidgetTask(id: "empty", title: "タスクがありません", isCompleted: false)
  }
}

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
  let tasks: [WidgetTask]

  // タスクがない場合の特別なケース
  var isEmpty: Bool {
    return tasks.isEmpty
  }

  // 完了したタスクの数を計算
  var completedTasksCount: Int {
    if isEmpty {
      return 0
    }
    return tasks.filter { $0.isCompleted }.count
  }

  // 全タスクの数を計算
  var totalTasksCount: Int {
    if isEmpty {
      return 0
    }
    return tasks.count
  }

  // 残りのタスク
  var remainingTasks: [WidgetTask] {
    return tasks.filter { !$0.isCompleted }
  }

  // 残りのタスク数を計算
  var remainingTasksCount: Int {
    return remainingTasks.count
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
    SimpleEntry(
      date: Date(),
      tasks: [
        WidgetTask(id: "1", title: "完了したタスク", isCompleted: true),
        WidgetTask(id: "2", title: "進行中のタスク1", isCompleted: false),
        WidgetTask(id: "3", title: "進行中のタスク2", isCompleted: false),
      ])
  }

  // MARK: getSnapshot
  // Widgetギャラリーでの表示やプレビュー用のデータを提供する
  // ユーザーがWidgetを選択する際に表示される内容を定義
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
    let entry = SimpleEntry(
      date: Date(),
      tasks: [
        WidgetTask(id: "1", title: "完了したタスク", isCompleted: true),
        WidgetTask(id: "2", title: "進行中のタスク1", isCompleted: false),
        WidgetTask(id: "3", title: "進行中のタスク2", isCompleted: false),
      ])
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
    var tasks: [WidgetTask] = []

    // データ形式がDataの場合の処理
    if let tasksData = sharedDefaults?.object(forKey: "today_tasks") as? Data {
      if let decodedTasks = try? JSONDecoder().decode([WidgetTask].self, from: tasksData) {
        tasks = decodedTasks
      }
    } else if let tasksString = sharedDefaults?.string(forKey: "today_tasks") {
      // データ形式が文字列の場合の処理
      if let data = tasksString.data(using: .utf8),
        let decodedTasks = try? JSONDecoder().decode([WidgetTask].self, from: data)
      {
        tasks = decodedTasks
      }
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
