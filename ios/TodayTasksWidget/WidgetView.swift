import SwiftUI
import WidgetKit

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
  var tasks: [WidgetTask]
  var maxCount: Int

  // 環境変数からURLを開くアクションを取得
  @Environment(\.openURL) private var openURL

  var body: some View {
    if tasks.isEmpty {
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
          let task = tasks[index]

          HStack(alignment: .top, spacing: 10) {
            // 完了/未完了によってアイコンを変更
            // タップ可能なチェックボックス
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
              .font(.system(size: 14))
              .foregroundColor(task.isCompleted ? .green : .blue)
              .contentShape(Rectangle())  // タップ領域を拡大
              .onTapGesture {
                // タスク状態変更処理
                toggleTaskCompletion(task)
              }

            // 完了したタスクは取り消し線と薄い色で表示
            Text(task.title)
              .font(.system(size: 14))
              .lineLimit(1)
              .foregroundColor(task.isCompleted ? .secondary : .primary)
              .strikethrough(task.isCompleted)
          }
        }

        // 表示しきれないタスクがある場合は「他◯件」と表示
        if tasks.count > maxCount {
          HStack {
            Text("他\(tasks.count - maxCount)件")
              .font(.system(size: 13))
              .foregroundColor(.secondary)
              .padding(.leading, 24)  // circleアイコンの幅+間隔分だけインデント
          }
          .padding(.top, 2)
        }
      }
      .padding(.top, 4)
    }
  }

  // タスクの完了状態を切り替える関数
  private func toggleTaskCompletion(_ task: WidgetTask) {
    // 状態を反転
    let newCompletionState = !task.isCompleted

    // 1. App Groupを使用してデータを直接更新
    updateTaskInSharedDefaults(task.id, isCompleted: newCompletionState)

    // 2. ウィジェットを更新
    WidgetCenter.shared.reloadTimelines(ofKind: "TodayTasksWidget")
    WidgetCenter.shared.reloadTimelines(ofKind: "TaskProgressWidget")

    // 3. URLスキームを使用してアプリに通知（最後に実行）
    // より単純なURLスキームを使用
    let urlString = "notionTodo://toggle/\(task.id)/\(newCompletionState)"

    if let url = URL(string: urlString) {
      // ディスパッチキューを使用して少し遅延させる（ウィジェットの更新が先に行われるようにするため）
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        // WidgetKit環境でのURL処理
        openURL(url)
      }
    }
  }

  // App Groupを使用してタスクデータを更新する関数
  private func updateTaskInSharedDefaults(_ taskId: String, isCompleted: Bool) {
    let sharedDefaults = UserDefaults(suiteName: "group.com.ymkokh.notionTodo")

    // 最新のタスクデータを取得
    if let tasksData = sharedDefaults?.object(forKey: "today_tasks") as? Data,
      let tasks = try? JSONDecoder().decode([WidgetTask].self, from: tasksData)
    {

      // タスクの状態を更新
      var updatedTasks = tasks
      if let index = updatedTasks.firstIndex(where: { $0.id == taskId }) {
        updatedTasks[index].isCompleted = isCompleted

        // 更新したデータを保存
        if let encodedData = try? JSONEncoder().encode(updatedTasks) {
          sharedDefaults?.set(encodedData, forKey: "today_tasks")
        }
      }
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
          Text("Today!")
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
          TaskListView(tasks: entry.remainingTasks, maxCount: 5)
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
          ProgressCircleView(entry: entry, size: 80)
            .padding(.vertical, 5)
            .padding(.top, 12)

          Text("\(entry.date, style: .date)")
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.bottom, 12)
        }
        .frame(maxHeight: 120)  // 固定の高さを設定

        Divider()

        // 下部：タスク一覧
        VStack(alignment: .leading) {
          TaskListView(tasks: entry.remainingTasks, maxCount: 10)
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
      TaskListView(tasks: entry.remainingTasks, maxCount: getMaxTaskCount())

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
