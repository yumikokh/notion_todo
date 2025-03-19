import SwiftUI
import WidgetKit

// MARK: - WidgetTask
// ウィジェットで表示するタスクデータ構造
struct WidgetTask: Codable, Identifiable {
  var id: String
  var title: String
  var isCompleted: Bool
  var isSubmitted: Bool

  // タスクがない場合の特別なケース
  static var empty: WidgetTask {
    return WidgetTask(id: "empty", title: "タスクがありません", isCompleted: false, isSubmitted: false)
  }
}

// MARK: - Localization
// ウィジェットのローカライズ用
struct LocalizedStrings {
  // 日本語
  static let ja = [
    "widget_today": "今日",
    "widget_tasks_completed": "完了！",
    "widget_tasks_empty": "No tasks",
    "widget_others_count": "他%d件",
    "widget_progress_title": "タスク進捗",
    "widget_progress_description": "今日のタスクの進捗状況を表示します",
    "widget_today_description": "今日のタスク一覧",
    "widget_no_tasks": "タスクがありません",
  ]

  // 英語
  static let en = [
    "widget_today": "Today",
    "widget_tasks_completed": "All Done!",
    "widget_tasks_empty": "No tasks",
    "widget_others_count": "%d more",
    "widget_progress_title": "Task Progress",
    "widget_progress_description": "Shows your daily task progress",
    "widget_today_description": "Today's tasks",
    "widget_no_tasks": "No tasks",
  ]

  static func getLocalizedString(for key: String, locale: String, args: CVarArg...) -> String {
    let strings = locale == "ja" ? ja : en
    if let format = strings[key] {
      if args.isEmpty {
        return format
      } else {
        return String(format: format, arguments: args)
      }
    }
    return key
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
    .description(
      LocalizedStrings.getLocalizedString(
        for: "widget_today_description", locale: Provider().getCurrentLocale())
    )  // Widgetの説明
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
    .configurationDisplayName(
      LocalizedStrings.getLocalizedString(
        for: "widget_progress_title", locale: Provider().getCurrentLocale())
    )
    .description(
      LocalizedStrings.getLocalizedString(
        for: "widget_progress_description", locale: Provider().getCurrentLocale())
    )
    .supportedFamilies([.systemSmall])
  }
}

// MARK: - TimelineEntry
// Widgetに表示するデータモデル
struct SimpleEntry: TimelineEntry {
  let date: Date
  let tasks: [WidgetTask]
  let locale: String

  // 表示するタスク
  var displayTasks: [WidgetTask] {
    return tasks.filter { ($0.isSubmitted && !$0.isCompleted) || (!$0.isSubmitted && $0.isCompleted) }
  }

  // タスクがない場合の特別なケース
  var isEmpty: Bool {
    return tasks.isEmpty
  }

  var isCompleted: Bool {
    return isEmpty ? false : completedTasksCount == totalTasksCount
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
      return 0.0  // タスクがない場合は0%完了とみなす
    }
    return Double(completedTasksCount) / Double(totalTasksCount)
  }
}

// MARK: - TimelineProvider
// TimelineProviderはWidgetの表示内容とその更新タイミングを管理するプロトコル
// Widgetの表示内容と更新タイミングを制御する3つのメソッドを実装する必要がある
struct Provider: TimelineProvider {
  // 現在のロケールを取得
  func getCurrentLocale() -> String {
    let sharedDefaults = UserDefaults(suiteName: "group.com.ymkokh.notionTodo")
    let locale = sharedDefaults?.string(forKey: "widget_locale") ?? "en"
    return locale
  }

  // MARK: placeholder
  // Widgetが最初に表示される際やプレビュー時に使用されるサンプルデータを提供する
  // システムがWidgetを表示する準備をしている間に表示される一時的なエントリー
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(
      date: Date(),
      tasks: [
        WidgetTask(id: "1", title: "完了したタスク", isCompleted: true, isSubmitted: true),
        WidgetTask(id: "2", title: "進行中のタスク1", isCompleted: false, isSubmitted: true),
        WidgetTask(id: "3", title: "進行中のタスク2", isCompleted: false, isSubmitted: true),
      ],
      locale: getCurrentLocale())
  }

  // MARK: getSnapshot
  // Widgetギャラリーでの表示やプレビュー用のデータを提供する
  // ユーザーがWidgetを選択する際に表示される内容を定義
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
    let locale = getCurrentLocale()
    let entry = SimpleEntry(
      date: Date(),
      tasks: [
        WidgetTask(id: "1", title: "完了したタスク", isCompleted: true, isSubmitted: true),
        WidgetTask(id: "2", title: "進行中のタスク1", isCompleted: false, isSubmitted: true),
        WidgetTask(id: "3", title: "進行中のタスク2", isCompleted: false, isSubmitted: true),
      ],
      locale: locale)
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
    let locale = getCurrentLocale()

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
    let entry = SimpleEntry(date: currentDate, tasks: tasks, locale: locale)
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
