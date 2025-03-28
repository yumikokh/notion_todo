import AppIntents
import Foundation
import SwiftUI
import WidgetKit
import home_widget

// MARK: - WidgetTask
// ウィジェットで表示するタスクデータ構造
struct WidgetTask: Codable, Identifiable {
  var id: String
  var title: String
  var isCompleted: Bool
  var isSubmitted: Bool
  var isOverdue: Bool

  // タスクがない場合の特別なケース
  static var empty: WidgetTask {
    return WidgetTask(
      id: "empty", title: "タスクがありません", isCompleted: false, isSubmitted: false, isOverdue: false)
  }
}

// MARK: - Localization
// ウィジェットのローカライズ用
struct LocalizedStrings {
  // 日本語
  static let ja = [
    "widget_today": "今日",
    "widget_tasks_completed": "完了",
    "widget_tasks_empty": "No tasks",
    "widget_progress_title": "タスク進捗",
    "widget_progress_description": "今日のタスクの進捗状況を表示します",
    "widget_today_description": "今日のタスク一覧",
    "widget_no_tasks": "タスクがありません",
    "widget_no_database": "Notionデータベースが未設定です",
  ]

  // 英語
  static let en = [
    "widget_today": "Today",
    "widget_tasks_completed": "All Done",
    "widget_tasks_empty": "No tasks",
    "widget_progress_title": "Task Progress",
    "widget_progress_description": "Shows your daily task progress",
    "widget_today_description": "Today's tasks",
    "widget_no_tasks": "No tasks",
    "widget_no_database": "Notion database is not set",
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

// MARK: - LockScreenProgressWidget
// ロック画面用の進捗表示ウィジェット
struct LockScreenProgressWidget: Widget {
  let kind: String = "LockScreenProgressWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      LockScreenProgressView(entry: entry).containerBackground(.fill.tertiary, for: .widget)
    }
    .configurationDisplayName(
      LocalizedStrings.getLocalizedString(
        for: "widget_progress_title", locale: Provider().getCurrentLocale())
    )
    .description(
      LocalizedStrings.getLocalizedString(
        for: "widget_progress_description", locale: Provider().getCurrentLocale())
    )
    .supportedFamilies([.accessoryCircular])
  }
}

// MARK: - LockScreenAddTaskWidget
// ロック画面用のタスク追加ウィジェット
struct LockScreenAddTaskWidget: Widget {
  let kind: String = "LockScreenAddTaskWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      LockScreenAddTaskView().containerBackground(.fill.tertiary, for: .widget)
    }
    .configurationDisplayName("Add Task")
    .description("Quickly add a new task")
    .supportedFamilies([.accessoryCircular])
  }
}

// MARK: - LockScreenTaskListWidget
// ロック画面用のタスク一覧ウィジェット
struct LockScreenTaskListWidget: Widget {
  let kind: String = "LockScreenTaskListWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      LockScreenTaskListView(entry: entry).containerBackground(.fill.tertiary, for: .widget)
    }
    .configurationDisplayName("Today's Tasks")
    .description(
      LocalizedStrings.getLocalizedString(
        for: "widget_today_description", locale: Provider().getCurrentLocale())
    )
    .supportedFamilies([.accessoryRectangular])
  }
}

// MARK: - TimelineEntry
// Widgetに表示するデータモデル
struct SimpleEntry: TimelineEntry {
  let date: Date
  let tasks: [WidgetTask]
  let locale: String
  let hasTaskDatabase: Bool

  // 表示するタスク
  var displayTasks: [WidgetTask] {
    return tasks.filter {
      ($0.isSubmitted && !$0.isCompleted) || (!$0.isSubmitted && $0.isCompleted)
    }
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
    return tasks.filter { $0.isCompleted && !$0.isOverdue }.count
  }

  // 全タスクの数を計算
  var totalTasksCount: Int {
    if isEmpty {
      return 0
    }
    return tasks.filter { !($0.isCompleted && $0.isOverdue) }.count
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
        WidgetTask(
          id: "1", title: "朝のストレッチ", isCompleted: true, isSubmitted: true, isOverdue: false),
        WidgetTask(
          id: "2", title: "新しいレシピを試す", isCompleted: false, isSubmitted: true, isOverdue: false),
        WidgetTask(
          id: "3", title: "公園でランニング", isCompleted: false, isSubmitted: true, isOverdue: false),
      ],
      locale: getCurrentLocale(),
      hasTaskDatabase: true)
  }

  // MARK: getSnapshot
  // Widgetギャラリーでの表示やプレビュー用のデータを提供する
  // ユーザーがWidgetを選択する際に表示される内容を定義
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
    let entry = loadCurrentEntry(activePlaceholder: true)
    completion(entry)
  }

  // MARK: getTimeline
  // 実際のWidgetデータと更新スケジュールを提供する最も重要なメソッド
  // いつ、どのようなデータでWidgetを更新するかを定義
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
    // 現在のエントリーを読み込む
    var entries: [SimpleEntry] = []
    let entry = loadCurrentEntry()
    let sharedDefaults = UserDefaults(suiteName: "group.com.ymkokh.notionTodo")

    // Widgetからのステータス変更だった場合
    if let lastCompletedTaskId = sharedDefaults?.string(forKey: "last_completed_task_id") {
      let optimisticEntry = SimpleEntry(
        date: entry.date,
        tasks: entry.tasks.map {
          $0.id == lastCompletedTaskId
            ? WidgetTask(
              id: $0.id,
              title: $0.title,
              isCompleted: $0.isCompleted,
              isSubmitted: false,
              isOverdue: $0.isOverdue
            )
            : $0
        },
        locale: entry.locale,
        hasTaskDatabase: entry.hasTaskDatabase)
      entries.append(optimisticEntry)
      let nextEntry = SimpleEntry(
        date: entry.date.addingTimeInterval(1),  // 1s後にリストから削除
        tasks: entry.tasks,
        locale: entry.locale,
        hasTaskDatabase: entry.hasTaskDatabase)
      entries.append(nextEntry)
    } else {
      entries.append(entry)
    }

    // 次の更新時間（15分後）を設定
    // この設定により、Widgetは15分ごとに更新される
    let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())!

    // タイムラインを作成して完了ハンドラを呼び出す
    // .after(nextUpdateDate)は指定した時間後に更新することを示す
    let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
    completion(timeline)
  }

  // 現在のエントリーを読み込むヘルパーメソッド
  func loadCurrentEntry(activePlaceholder: Bool = false) -> SimpleEntry {
    let sharedDefaults = UserDefaults(suiteName: "group.com.ymkokh.notionTodo")
    var tasks: [WidgetTask] = []
    let locale = getCurrentLocale()
    let hasTaskDatabase =
      sharedDefaults?.object(forKey: "task_database") != nil
      && sharedDefaults?.string(forKey: "access_token") != nil

    // データベースが未設定の場合
    if !hasTaskDatabase {
      tasks = []
    }

    // ペンディング中のタスク更新があれば処理
    if sharedDefaults?.object(forKey: "pending_task_update") != nil {
      // 処理済みなのでクリア
      sharedDefaults?.removeObject(forKey: "pending_task_update")
      sharedDefaults?.synchronize()
    }

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

    // 実際のデータがない場合は、現実的なダミーデータを使用
    if tasks.isEmpty && activePlaceholder {
      tasks = [
        WidgetTask(
          id: "1", title: "朝のストレッチ", isCompleted: true, isSubmitted: true, isOverdue: false),
        WidgetTask(
          id: "2", title: "新しいレシピを試す", isCompleted: false, isSubmitted: true, isOverdue: false),
        WidgetTask(
          id: "3", title: "公園でランニング", isCompleted: false, isSubmitted: true, isOverdue: false),
      ]
    }

    return SimpleEntry(
      date: Date(), tasks: tasks, locale: locale,
      hasTaskDatabase: activePlaceholder || hasTaskDatabase)
  }
}

////////
/// @available(iOS 17, *)
public struct BackgroundIntent: AppIntent {

  static public var title: LocalizedStringResource = "HomeWidget Background Intent"

  @Parameter(title: "Widget URI")
  var url: URL?

  public init() {}

  public init(url: URL?) {
    self.url = url
  }

  public func perform() async throws -> some IntentResult {
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

///////

// MARK: - 進捗表示用の円形ビュー
// タスクの進捗状況を円形で表示するビュー
struct ProgressCircleView: View {
  var entry: SimpleEntry
  var size: CGFloat  // 円のサイズ

  var body: some View {
    ZStack {
      if entry.isEmpty || entry.isCompleted {
        let color = entry.isEmpty ? Color.gray.opacity(0.15) : Color.black
        Circle()
          .stroke(color, lineWidth: 10)
          .frame(width: size, height: size)
      } else {
        // タスクの数だけ円弧を描画
        let edge = 0.003
        ForEach(0..<entry.totalTasksCount, id: \.self) { index in
          Circle()
            .trim(
              from: CGFloat(index) / CGFloat(entry.totalTasksCount) + edge,  // 開始位置に間隔を追加
              to: CGFloat(index + 1) / CGFloat(entry.totalTasksCount) - edge  // 終了位置に間隔を追加
            )
            .stroke(
              index < entry.completedTasksCount ? Color.black : Color.gray.opacity(0.15),
              style: StrokeStyle(lineWidth: 13, lineCap: .butt)  // 両端を丸く
            )
            .frame(width: size, height: size)
            .rotationEffect(.degrees(-90))  // 12時の位置から開始
        }
      }

      // 中央のテキストまたはアイコン
      VStack(spacing: 2) {
        if entry.isCompleted {
          Text(
            LocalizedStrings.getLocalizedString(for: "widget_tasks_completed", locale: entry.locale)
          )
          .font(.subheadline)
          .foregroundColor(.secondary)
          .padding(.top, 4)
          .padding(.bottom, 4)
        } else if entry.isEmpty {
          // タスクがない場合は空の表示
          Text(LocalizedStrings.getLocalizedString(for: "widget_tasks_empty", locale: entry.locale))
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.top, 4)
            .padding(.bottom, 4)
        } else {
          // 残りタスク数を表示
          Text("\(entry.remainingTasksCount)")
            .font(.system(size: size * 0.3, weight: .bold))
            .foregroundColor(.primary)
            .padding(.bottom, -2)
        }

        // タイトルを表示
        Text(LocalizedStrings.getLocalizedString(for: "widget_today", locale: entry.locale))
          .font(.caption2)
          .foregroundColor(.secondary)
          .lineLimit(1)
          .truncationMode(.tail)
          .frame(width: size * 0.7)  // 円の内側に収まるようにサイズ制限
      }
    }
  }
}

// MARK: - 共通タスク一覧表示コンポーネント
struct TaskListView: View {
  var entry: SimpleEntry
  var maxCount: Int
  @Environment(\.openURL) private var openURL
  @Environment(\.widgetFamily) var widgetFamily

  var body: some View {
    if entry.isCompleted {
      Spacer()
      HStack {
        Spacer()
        VStack {
          Image(systemName: "checkmark.circle")
            .font(.system(size: 30))
            .foregroundColor(.secondary)
          Text(
            LocalizedStrings.getLocalizedString(for: "widget_tasks_completed", locale: entry.locale)
          )
          .font(.system(size: 12))
          .foregroundColor(.secondary)
          .padding(.top, 2)
          .padding(.bottom, 8)
        }
        Spacer()
      }
      Spacer()
    } else if entry.isEmpty {
      Spacer()
      HStack {
        Spacer()
        VStack {
          Text(LocalizedStrings.getLocalizedString(for: "widget_tasks_empty", locale: entry.locale))
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.bottom, 10)
        }
        Spacer()
      }
      Spacer()
    } else {
      let tasks = entry.displayTasks
      VStack(alignment: .leading, spacing: 8) {
        ForEach(0..<min(maxCount, tasks.count), id: \.self) { index in
          let task = tasks[index]

          HStack(alignment: .top, spacing: 10) {
            // 完了/未完了によってアイコンを変更
            // iOS 17のインタラクティブウィジェット用にBackgroundIntentを使用
            if widgetFamily != .systemSmall {
              Button(
                intent: BackgroundIntent(
                  url: URL(string: "notiontodo://toggle/\(task.id)/\(!task.isCompleted)")
                )
              ) {
                Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                  .cornerRadius(0)
                  .font(.system(size: 16))
                  .foregroundColor(Color(red: 0.49, green: 0.46, blue: 0.43))
                  .symbolEffect(.bounce, options: .speed(1.5), value: task.isSubmitted)
              }
              .buttonStyle(.plain)
            }

            Text(task.title)
              .font(.system(size: 14))
              .lineLimit(1)
              .foregroundColor(task.isOverdue ? .red : task.isCompleted ? .secondary : .primary)
              .strikethrough(task.isCompleted)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
      }
      .padding(.top, 2)
    }
  }
}

// MARK: - TaskProgressWidgetEntryView
// 進捗ウィジェットのビュー
struct TaskProgressWidgetEntryView: View {
  var entry: SimpleEntry
  @Environment(\.widgetFamily) var widgetFamily

  var body: some View {
    switch widgetFamily {
    case .systemSmall:
      // スモールサイズ：進捗円のみ
      ZStack {
        if entry.hasTaskDatabase {
          // 中央に円を配置
          ProgressCircleView(entry: entry, size: 110)
        } else {
          // データベース未設定時のメッセージ
          VStack(spacing: 4) {
            Text(
              LocalizedStrings.getLocalizedString(for: "widget_no_database", locale: entry.locale)
            )
            .font(.system(size: 12))
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 8)
          }
        }
      }
      .containerBackground(.fill.tertiary, for: .widget)
      .widgetURL(URL(string: "notiontodo://open/today?homeWidget")!)
    default:
      Text("Unsupported widget size")
        .containerBackground(.fill.tertiary, for: .widget)
    }
  }
}

// MARK: - TodayTasksWidgetEntryView
// タスク一覧ウィジェットのビュー
struct TodayTasksWidgetEntryView: View {
  var entry: SimpleEntry
  @Environment(\.widgetFamily) var widgetFamily

  var body: some View {
    if entry.hasTaskDatabase {
      switch widgetFamily {
      // スモールサイズ
      case .systemSmall:
        VStack(alignment: .leading, spacing: 0) {
          // ヘッダー部分：タイトル
          HStack(alignment: .bottom) {
            Text(LocalizedStrings.getLocalizedString(for: "widget_today", locale: entry.locale))
              .font(.headline)
              .foregroundColor(.primary)

            // タスクの完了状況を分数形式で表示
            Text("\(entry.completedTasksCount)\u{2009}/\u{2009}\(entry.totalTasksCount)")
              .font(.system(size: 12))
              .foregroundColor(.secondary)
              .padding(.bottom, 2)

            Spacer()
          }
          .padding(.bottom, 8)

          // タスク一覧（常に一定の高さを確保）
          TaskListView(entry: entry, maxCount: getMaxTaskCount())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .containerBackground(.fill.tertiary, for: .widget)
        .widgetURL(URL(string: "notiontodo://open/today?homeWidget")!)

      // メディアム、ラージサイズ
      default:
        ZStack(alignment: .topLeading) {
          VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .bottom) {
              // ヘッダー部分：タイトル
              Text(LocalizedStrings.getLocalizedString(for: "widget_today", locale: entry.locale))
                .font(.headline)
                .foregroundColor(.primary)

              // タスクの完了状況を分数形式で表示
              Text("\(entry.completedTasksCount)\u{2009}/\u{2009}\(entry.totalTasksCount)")
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .padding(.bottom, 2)
            }
            .padding(.bottom, widgetFamily == .systemMedium ? 8 : 10)

            // タスク一覧
            TaskListView(
              entry: entry, maxCount: getMaxTaskCount())
          }
          .padding([.leading, .trailing], 4)

          // Medium と Large サイズの場合は + ボタンを右上に絶対配置
          VStack {
            HStack {
              Spacer()
              Link(destination: URL(string: "notiontodo://add_task/today?homeWidget")!) {
                Image(systemName: "plus.circle.fill")
                  .font(.system(size: 30))
                  .foregroundColor(.primary)
              }
              .padding(.trailing, -2)
              .padding(.top, -8)
            }
            Spacer()
          }
        }
        .containerBackground(.fill.tertiary, for: .widget)  // iOS 17以降のWidget背景スタイル
        .widgetURL(URL(string: "notiontodo://open/today?homeWidget")!)
      }
    } else {
      // データベース未設定時のメッセージ
      VStack(spacing: 4) {
        Text(LocalizedStrings.getLocalizedString(for: "widget_no_database", locale: entry.locale))
          .font(.system(size: 12))
          .foregroundColor(.secondary)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 8)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .containerBackground(.fill.tertiary, for: .widget)
      .widgetURL(URL(string: "notiontodo://open/today?homeWidget")!)
    }
  }

  // Widgetサイズに応じて表示するタスク数を決定する関数
  func getMaxTaskCount() -> Int {
    switch widgetFamily {
    case .systemSmall:
      return 4  // 小サイズでは最大4つ
    case .systemMedium:
      return 4  // 中サイズでは最大4つ
    case .systemLarge:
      return 12  // 大サイズでは最大12つ
    default:
      return 4  // その他のサイズでは4つをデフォルトとする
    }
  }
}

////////

// ロック画面用の進捗表示ビュー
struct LockScreenProgressView: View {
  var entry: SimpleEntry

  var body: some View {
    if entry.hasTaskDatabase {
      if entry.isCompleted {
        // 全タスク完了時
        Image(systemName: "checkmark")
          .font(.system(size: 20))
      } else if entry.isEmpty {
        // タスクなし
        Text("0")
          .font(.system(size: 20, weight: .medium))
      } else {
        // 進捗表示
        Gauge(value: entry.progressPercentage) {
          Text("\(entry.remainingTasksCount)")
            .font(.system(size: 20, weight: .medium))
        }
        .gaugeStyle(.accessoryCircular)
      }
    } else {
      // データベース未設定時
      Image(systemName: "exclamationmark.triangle")
        .font(.system(size: 20))
    }
  }
}

// ロック画面用のタスク追加ビュー
struct LockScreenAddTaskView: View {
  var body: some View {
    Link(destination: URL(string: "notiontodo://add_task/today?homeWidget")!) {
      Image(systemName: "plus")
        .font(.system(size: 20))
        .widgetAccentable()
    }
  }
}

// ロック画面用のタスク一覧ビュー
struct LockScreenTaskListView: View {
  var entry: SimpleEntry

  var body: some View {
    if entry.hasTaskDatabase {
      if entry.isCompleted {
        // 全タスク完了時
        HStack {
          Image(systemName: "checkmark.circle")
          Text(
            LocalizedStrings.getLocalizedString(
              for: "widget_tasks_completed",
              locale: entry.locale
            )
          )
        }
      } else if entry.isEmpty {
        // タスクなし
        Text(
          LocalizedStrings.getLocalizedString(
            for: "widget_tasks_empty",
            locale: entry.locale
          )
        )
      } else {
        // タスク一覧（最新2件）
        VStack(alignment: .leading) {
          let tasks = entry.displayTasks.prefix(2)
          ForEach(Array(tasks.enumerated()), id: \.element.id) { index, task in
            if index > 0 {
              Divider()
            }
            Text(task.title)
              .font(.system(size: 12))
              .lineLimit(1)
              .strikethrough(task.isCompleted)
          }
        }
      }
    } else {
      // データベース未設定時
      Text(
        LocalizedStrings.getLocalizedString(
          for: "widget_no_database",
          locale: entry.locale
        )
      )
    }
  }
}

////////

// MARK: - Previews
// 各ウィジェットのプレビュー

// サンプルタスクデータ
let sampleTasks = [
  WidgetTask(
    id: "1", title: "朝のミーティング朝のミーティング朝のミーティング朝のミーティング", isCompleted: false, isSubmitted: true,
    isOverdue: false),
  WidgetTask(id: "2", title: "レポート提出", isCompleted: false, isSubmitted: true, isOverdue: true),
  WidgetTask(id: "3", title: "買い物", isCompleted: true, isSubmitted: false, isOverdue: false),
  WidgetTask(id: "4", title: "デザインの作成", isCompleted: false, isSubmitted: true, isOverdue: false),
  WidgetTask(id: "5", title: "コードレビュー", isCompleted: false, isSubmitted: true, isOverdue: false),
  WidgetTask(id: "6", title: "週報作成", isCompleted: false, isSubmitted: true, isOverdue: false),
  WidgetTask(id: "7", title: "プレゼン準備", isCompleted: false, isSubmitted: true, isOverdue: false),
  WidgetTask(id: "8", title: "顧客対応", isCompleted: false, isSubmitted: true, isOverdue: false),
  WidgetTask(id: "9", title: "ミーティング", isCompleted: false, isSubmitted: true, isOverdue: false),
  WidgetTask(id: "10", title: "ミーティング", isCompleted: false, isSubmitted: true, isOverdue: false),
  WidgetTask(id: "11", title: "ミーティング", isCompleted: false, isSubmitted: true, isOverdue: false),
  WidgetTask(id: "12", title: "ミーティング", isCompleted: false, isSubmitted: true, isOverdue: false),
  WidgetTask(id: "13", title: "ミーティング", isCompleted: false, isSubmitted: true, isOverdue: false),
  WidgetTask(id: "14", title: "ミーティング", isCompleted: false, isSubmitted: true, isOverdue: false),
]

let sampleOneTask = [
  WidgetTask(id: "1", title: "ヨガ", isCompleted: false, isSubmitted: true, isOverdue: false)

]

let sampleEntry = SimpleEntry(
  date: Date(),
  tasks: sampleTasks,
  locale: "ja",
  hasTaskDatabase: true
)

let sampleOneEntry = SimpleEntry(
  date: Date(),
  tasks: sampleOneTask,
  locale: "ja",
  hasTaskDatabase: true
)

let noTasksEntry = SimpleEntry(
  date: Date(),
  tasks: [],
  locale: "ja",
  hasTaskDatabase: true
)

let allCompletedEntry = SimpleEntry(
  date: Date(),
  tasks: sampleTasks.map {
    WidgetTask(id: $0.id, title: $0.title, isCompleted: true, isSubmitted: true, isOverdue: false)
  },
  locale: "ja",
  hasTaskDatabase: true
)

let noDatabaseEntry = SimpleEntry(
  date: Date(),
  tasks: [],
  locale: "ja",
  hasTaskDatabase: false
)

#Preview("Today Small", as: .systemSmall) {
  TodayTasksWidget()
} timeline: {
  sampleEntry
  sampleOneEntry
  noTasksEntry
  allCompletedEntry
  noDatabaseEntry
}

#Preview("Today Medium", as: .systemMedium) {
  TodayTasksWidget()
} timeline: {
  sampleEntry
  sampleOneEntry
  noTasksEntry
  allCompletedEntry
  noDatabaseEntry
}

#Preview("Today Large", as: .systemLarge) {
  TodayTasksWidget()
} timeline: {
  sampleEntry
  sampleOneEntry
  noTasksEntry
  allCompletedEntry
  noDatabaseEntry
}

#Preview("Progress Small", as: .systemSmall) {
  TaskProgressWidget()
} timeline: {
  sampleEntry
  sampleOneEntry
  noTasksEntry
  allCompletedEntry
  noDatabaseEntry
}

#Preview("Lock Screen Progress", as: .accessoryCircular) {
  LockScreenProgressWidget()
} timeline: {
  sampleEntry
  sampleOneEntry
  noTasksEntry
  allCompletedEntry
  noDatabaseEntry
}

#Preview("Lock Screen Add Task", as: .accessoryCircular) {
  LockScreenAddTaskWidget()
} timeline: {
  sampleEntry
}

#Preview("Lock Screen Task List", as: .accessoryRectangular) {
  LockScreenTaskListWidget()
} timeline: {
  sampleEntry
  sampleOneEntry
  noTasksEntry
  allCompletedEntry
  noDatabaseEntry
}
