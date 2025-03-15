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
  var locale: String
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
          Text(LocalizedStrings.getLocalizedString(for: "widget_tasks_completed", locale: locale))
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
            // iOS 17のインタラクティブウィジェット用にBackgroundIntentを使用
              Button(
                intent: BackgroundIntent(
                  url: URL(string: "notiontodo://toggle/\(task.id)/\(!task.isCompleted)")
                )
              ) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                  .font(.system(size: 14))
                  .foregroundColor(task.isCompleted ? .green : .blue)
              }
              .buttonStyle(.plain)

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
            Text(
              LocalizedStrings.getLocalizedString(
                for: "widget_others_count", locale: locale, args: tasks.count - maxCount)
            )
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
        Text(LocalizedStrings.getLocalizedString(for: "widget_today", locale: entry.locale))
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
    VStack(alignment: .leading, spacing: 8) {
      // ヘッダー部分：タイトルと日付
      HStack {
        Text(LocalizedStrings.getLocalizedString(for: "widget_today", locale: entry.locale))
          .font(.headline)
          .foregroundColor(.primary)

        Spacer()

        // Medium と Large サイズの場合は + ボタンを表示
        if widgetFamily != .systemSmall {
          Link(destination: URL(string: "notiontodo://add_task/today?homeWidget")!) {
            Image(systemName: "plus.circle.fill")
              .font(.system(size: 30))
              .foregroundColor(.blue)
              .buttonStyle(.plain)
              .padding(.trailing, 4)
          }
        }
      }
      .padding(.bottom, 4)

      // 共通コンポーネントを使用
      TaskListView(tasks: entry.tasks, maxCount: getMaxTaskCount(), locale: entry.locale)

      Spacer()
    }
    .padding([.leading, .trailing], widgetFamily == .systemSmall ? 2 : 10)
    .containerBackground(.fill.tertiary, for: .widget)  // iOS 17以降のWidget背景スタイル
    .widgetURL(URL(string: "notiontodo://open/today?homeWidget")!)
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
