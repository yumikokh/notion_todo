import SwiftUI
import WidgetKit

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

      // 進捗を表す円弧（青）
      Circle()
        .trim(from: 0, to: CGFloat(entry.progressPercentage))
        .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round))
        .frame(width: size, height: size)
        .rotationEffect(.degrees(-90))  // 12時の位置から開始

      // 中央のテキストまたはアイコン
      if entry.remainingTasksCount == 0 {
        // タスクが全て完了している場合はチェックマーク
        Image(systemName: "checkmark")
          .font(.system(size: size * 0.4))
          .foregroundColor(.green)
      } else {
        // 残りタスク数を表示
        Text("\(entry.remainingTasksCount)")
          .font(.system(size: size * 0.4, weight: .bold))
          .foregroundColor(.primary)
      }
    }
  }
}

// MARK: - 共通タスク一覧表示コンポーネント
struct TaskListView: View {
  var tasks: [String]
  var maxCount: Int

  var body: some View {
    if tasks.first == "タスクがありません" {
      Spacer()
      HStack {
        Spacer()
        VStack {
          Image(systemName: "checkmark.circle")
            .font(.system(size: 30))
            .foregroundColor(.gray)
          Text("タスク完了！")
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        Spacer()
      }
      Spacer()
    } else {
      VStack(alignment: .leading, spacing: 8) {
        ForEach(0..<min(maxCount, tasks.count), id: \.self) { index in
          HStack(alignment: .top, spacing: 10) {
            Image(systemName: "circle")
              .font(.system(size: 14))
              .foregroundColor(.blue)
            Text(tasks[index])
              .font(.system(size: 14))
              .lineLimit(1)
              .foregroundColor(.primary)
          }
        }
      }
      .padding(.top, 4)
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
      VStack {
        Text("Today")
          .font(.headline)
          .padding(.top, 8)

        Spacer()

        ProgressCircleView(entry: entry, size: 100)

        Spacer()

        Text("\(entry.date, style: .date)")
          .font(.caption)
          .foregroundColor(.secondary)
          .padding(.bottom, 8)
      }
      .containerBackground(.fill.tertiary, for: .widget)

    case .systemMedium:
      // ミディアムサイズ：左に進捗円、右にタスク一覧
      HStack(alignment: .center) {
        // 左側：進捗円
        VStack {
          Text("Today")
            .font(.headline)
            .padding(.top, 8)

          Spacer()

          ProgressCircleView(entry: entry, size: 80)

          Spacer()

          Text("\(entry.date, style: .date)")
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)

        Divider()

        // 右側：タスク一覧（左寄せ）
        VStack(alignment: .leading) {
          TaskListView(tasks: entry.tasks, maxCount: 5)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .containerBackground(.fill.tertiary, for: .widget)

    case .systemLarge:
      // ラージサイズ：上に進捗円、下にタスク一覧
      VStack {
        // 上部：進捗円と日付
        VStack {
          Text("Today")
            .font(.headline)
            .padding(.top, 8)

          ProgressCircleView(entry: entry, size: 120)
            .padding(.vertical, 10)

          Text("\(entry.date, style: .date)")
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .frame(maxHeight: 180)  // 固定の高さを設定

        Divider()

        // 下部：タスク一覧
        VStack(alignment: .leading) {
          TaskListView(tasks: entry.tasks, maxCount: 10)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .containerBackground(.fill.tertiary, for: .widget)

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
    VStack(alignment: .leading, spacing: 8) {
      // ヘッダー部分：タイトルと日付
      HStack {
        Text("Today")
          .font(.headline)
          .foregroundColor(.primary)
        Spacer()
        Text(entry.date, style: .date)
          .font(.caption)
          .foregroundColor(.secondary)
      }
      .padding(.bottom, 4)

      // 共通コンポーネントを使用
      TaskListView(tasks: entry.tasks, maxCount: getMaxTaskCount())

      Spacer()
    }
    .padding([.leading, .trailing], widgetFamily == .systemSmall ? 2 : 10)
    .containerBackground(.fill.tertiary, for: .widget)  // iOS 17以降のWidget背景スタイル
  }

  // Widgetサイズに応じて表示するタスク数を決定する関数
  func getMaxTaskCount() -> Int {
    switch widgetFamily {
    case .systemSmall:
      return 3  // 小サイズでは最大3つ
    case .systemMedium:
      return 3  // 中サイズでは最大3つ
    case .systemLarge:
      return 10  // 大サイズでは最大10つ
    default:
      return 3  // その他のサイズでは3つをデフォルトとする
    }
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

// MARK: - Previews
// 各ウィジェットのプレビュー

#Preview("Today Small", as: .systemSmall) {
  TodayTasksWidget()
} timeline: {
  SimpleEntry(date: Date(), tasks: ["朝のミーティング", "レポート提出", "買い物"])
}

#Preview("Today Medium", as: .systemMedium) {
  TodayTasksWidget()
} timeline: {
  SimpleEntry(date: Date(), tasks: ["朝のミーティング", "レポート提出", "買い物"])
}

#Preview("Today Large", as: .systemLarge) {
  TodayTasksWidget()
} timeline: {
  SimpleEntry(date: Date(), tasks: ["朝のミーティング", "レポート提出", "買い物"])
}

#Preview("Progress Small", as: .systemSmall) {
  TaskProgressWidget()
} timeline: {
  SimpleEntry(date: Date(), tasks: ["朝のミーティング", "レポート提出", "買い物"])
}

// タスク数を増やして複雑なケースをテスト
#Preview("Progress Medium", as: .systemMedium) {
  TaskProgressWidget()
} timeline: {
  SimpleEntry(date: Date(), tasks: ["タスク1", "タスク2", "タスク3", "タスク4", "タスク5"])
}

#Preview("Progress Large", as: .systemLarge) {
  TaskProgressWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: [
      "タスク1", "タスク2", "タスク3", "タスク4", "タスク5",
      "タスク6", "タスク7", "タスク8",
    ])
}

// タスクなしのプレビューも追加
#Preview("Tasks Empty", as: .systemMedium) {
  TodayTasksWidget()
} timeline: {
  SimpleEntry(date: Date(), tasks: ["タスクがありません"])
}

#Preview("Progress Complete", as: .systemMedium) {
  TaskProgressWidget()
} timeline: {
  SimpleEntry(date: Date(), tasks: ["タスクがありません"])
}
