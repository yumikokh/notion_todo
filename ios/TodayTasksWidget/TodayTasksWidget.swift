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

///////

// MARK: - 進捗表示用の円形ビュー
// タスクの進捗状況を円形で表示するビュー
struct ProgressCircleView: View {
  var entry: SimpleEntry
  var size: CGFloat  // 円のサイズ

  var body: some View {
    ZStack {
      // 背景の円（グレー）
      Circle()
        .stroke(Color.gray.opacity(0.3), lineWidth: 10)
        .frame(width: size, height: size)

      // 進捗を表す円弧（グラデーション）
      Circle()
        .trim(from: 0, to: min(1.01, CGFloat(entry.progressPercentage)))
        .stroke(
          AngularGradient(
            gradient: Gradient(colors: [
              Color(red: 0.52, green: 0.83, blue: 0.83),  // 最も明るい青緑（開始点）
              Color(red: 0.33, green: 0.65, blue: 0.65),  // 明るめの青緑
              Color(red: 0.18, green: 0.5, blue: 0.5),  // 中間の青緑
              Color(red: 0.08, green: 0.42, blue: 0.42),  // 暗めの青緑（終了点）
            ]),
            center: .center,
            startAngle: .degrees(-10),  // 開始角度を少し手前にして、丸い部分からグラデーションが始まるようにする
            endAngle: .degrees(360 - 10)  // 終了角度も調整
          ),
          style: StrokeStyle(lineWidth: 10, lineCap: .round)
        )
        .frame(width: size, height: size)
        .rotationEffect(.degrees(-90))  // 12時の位置から開始

      // 進捗率100%のときに、始点に食い込む円弧を追加
      if entry.progressPercentage >= 0.99 {
        Circle()
          .trim(from: 0, to: 0.02)  // 約10度分の円弧
          .stroke(
            AngularGradient(
              gradient: Gradient(colors: [
                Color(red: 0.08, green: 0.42, blue: 0.42),
                Color(red: 0.08, green: 0.42, blue: 0.42),
              ]),
              center: .center,
              startAngle: .degrees(0),
              endAngle: .degrees(10)
            ),
            style: StrokeStyle(lineWidth: 10, lineCap: .round)
          )
          .frame(width: size, height: size)
          .rotationEffect(.degrees(-90 - 10))  // 12時の位置から開始
      }

      // 中央のテキストまたはアイコン
      VStack(spacing: 2) {
        if entry.isCompleted {
          Text("🎉")
            .font(.system(size: size * 0.18))
            .foregroundColor(.primary)
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
  var tasks: [WidgetTask]
  var maxCount: Int
  var locale: String
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
          Text(LocalizedStrings.getLocalizedString(for: "widget_tasks_completed", locale: locale))
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
          Text(LocalizedStrings.getLocalizedString(for: "widget_tasks_empty", locale: locale))
            .font(.subheadline)
            .foregroundColor(.secondary)
          .padding(.bottom, 10)
        }
        Spacer()
      }
      Spacer()
    } else {
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
                  .font(.system(size: 16))
                  .foregroundColor(Color(red: 0.49, green: 0.46, blue: 0.43))
              }
              .buttonStyle(.plain)
            }

            // 完了したタスクは取り消し線と薄い色で表示
            Text(task.title)
              .font(.system(size: 14))
              .lineLimit(1)
              .foregroundColor(task.isCompleted ? .secondary : .primary)
              .strikethrough(task.isCompleted)
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
        // 中央に円を配置
        ProgressCircleView(entry: entry, size: 110)
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
        .padding(.bottom, 4)
        
        // タスク一覧（残りの空間いっぱいに広げる）
        TaskListView(entry: entry, tasks: entry.displayTasks, maxCount: getMaxTaskCount(), locale: entry.locale)
          .frame(maxHeight: .infinity)
      }
      .containerBackground(.fill.tertiary, for: .widget)
      .widgetURL(URL(string: "notiontodo://open/today?homeWidget")!)

    // メディアム、ラージサイズ
    default:
      ZStack(alignment: .topLeading) {
        VStack(alignment: .leading, spacing: 8) {
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

          // タスク一覧
          TaskListView(
            entry: entry, tasks: entry.displayTasks, maxCount: getMaxTaskCount(),
            locale: entry.locale)
        }
        .padding([.leading, .trailing], 10)

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

// MARK: - Previews
// 各ウィジェットのプレビュー

// サンプルタスクデータ
let sampleTasks = [
  WidgetTask(
    id: "1", title: "朝のミーティング朝のミーティング朝のミーティング朝のミーティング", isCompleted: true, isSubmitted: true),
  WidgetTask(id: "2", title: "レポート提出", isCompleted: false, isSubmitted: true),
  WidgetTask(id: "3", title: "買い物", isCompleted: false, isSubmitted: true),
  WidgetTask(id: "4", title: "デザインの作成", isCompleted: false, isSubmitted: true),
  WidgetTask(id: "5", title: "コードレビュー", isCompleted: false, isSubmitted: true),
  WidgetTask(id: "6", title: "週報作成", isCompleted: false, isSubmitted: true),
  WidgetTask(id: "7", title: "プレゼン準備", isCompleted: false, isSubmitted: true),
  WidgetTask(id: "8", title: "顧客対応", isCompleted: false, isSubmitted: true),
  WidgetTask(id: "9", title: "ミーティング", isCompleted: false, isSubmitted: true),
  WidgetTask(id: "10", title: "ミーティング", isCompleted: false, isSubmitted: true),
  WidgetTask(id: "11", title: "ミーティング", isCompleted: false, isSubmitted: true),
  WidgetTask(id: "12", title: "ミーティング", isCompleted: false, isSubmitted: true),
  WidgetTask(id: "13", title: "ミーティング", isCompleted: false, isSubmitted: true),
  WidgetTask(id: "14", title: "ミーティング", isCompleted: false, isSubmitted: true),
]

let sampleEntry = SimpleEntry(
  date: Date(),
  tasks: sampleTasks,
  locale: "ja"
)

let noTasksEntry = SimpleEntry(
  date: Date(),
  tasks: [],
  locale: "ja"
)

let allCompletedEntry = SimpleEntry(
  date: Date(),
  tasks: sampleTasks.map {
    WidgetTask(id: $0.id, title: $0.title, isCompleted: true, isSubmitted: true)
  },
  locale: "ja"
)

#Preview("Today Small", as: .systemSmall) {
  TodayTasksWidget()
} timeline: {
  sampleEntry
  noTasksEntry
  allCompletedEntry
}

#Preview("Today Medium", as: .systemMedium) {
  TodayTasksWidget()
} timeline: {
  sampleEntry
  noTasksEntry
  allCompletedEntry
}

#Preview("Today Large", as: .systemLarge) {
  TodayTasksWidget()
} timeline: {
  sampleEntry
  noTasksEntry
  allCompletedEntry
}

#Preview("Progress Small", as: .systemSmall) {
  TaskProgressWidget()
} timeline: {
  sampleEntry
  noTasksEntry
  allCompletedEntry
}
