import SwiftUI
import WidgetKit

// MARK: - Previews
// 各ウィジェットのプレビュー

// サンプルタスクデータ
let sampleTasks = [
  WidgetTask(id: "1", title: "朝のミーティング", isCompleted: false),
  WidgetTask(id: "2", title: "レポート提出", isCompleted: true),
  WidgetTask(id: "3", title: "買い物", isCompleted: false),
  WidgetTask(id: "4", title: "デザインの作成", isCompleted: false),
  WidgetTask(id: "5", title: "コードレビュー", isCompleted: false),
  WidgetTask(id: "6", title: "週報作成", isCompleted: false),
  WidgetTask(id: "7", title: "プレゼン準備", isCompleted: false),
  WidgetTask(id: "8", title: "顧客対応", isCompleted: false),
]

#Preview("Today Small", as: .systemSmall) {
  TodayTasksWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: sampleTasks)
}

#Preview("Today Medium", as: .systemMedium) {
  TodayTasksWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: sampleTasks)
}

#Preview("Today Large", as: .systemLarge) {
  TodayTasksWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: sampleTasks)
}

#Preview("Progress Small", as: .systemSmall) {
  TaskProgressWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: sampleTasks)
}

// タスク数を増やして複雑なケースをテスト
#Preview("Progress Medium", as: .systemMedium) {
  TaskProgressWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: sampleTasks)
}

#Preview("Progress Large", as: .systemLarge) {
  TaskProgressWidget()
} timeline: {
  SimpleEntry(
    date: Date(),
    tasks: sampleTasks)
}

// タスクなしのプレビューも追加
#Preview("Tasks Empty", as: .systemMedium) {
  TodayTasksWidget()
} timeline: {
  SimpleEntry(date: Date(), tasks: [])
}

#Preview("Progress Complete", as: .systemMedium) {
  TaskProgressWidget()
} timeline: {
  SimpleEntry(date: Date(), tasks: [])
}
