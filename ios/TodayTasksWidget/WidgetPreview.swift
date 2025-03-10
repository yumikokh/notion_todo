import SwiftUI
import WidgetKit

// MARK: - Previews
// 各ウィジェットのプレビュー

let tasks = [
  "朝のミーティング", "レポート提出", "買い物", "デザインの作成", "デザインの作成", "デザインの作成", "デザインの作成", "デザインの作成",
]

#Preview("Today Small", as: .systemSmall) {
  TodayTasksWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: tasks)
}

#Preview("Today Medium", as: .systemMedium) {
  TodayTasksWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: tasks)
}

#Preview("Today Large", as: .systemLarge) {
  TodayTasksWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: tasks)
}

#Preview("Progress Small", as: .systemSmall) {
  TaskProgressWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: tasks)
}

// タスク数を増やして複雑なケースをテスト
#Preview("Progress Medium", as: .systemMedium) {
  TaskProgressWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: tasks)
}

#Preview("Progress Large", as: .systemLarge) {
  TaskProgressWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: tasks)
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
