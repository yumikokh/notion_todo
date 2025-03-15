import SwiftUI
import WidgetKit

// MARK: - Previews
// 各ウィジェットのプレビュー

// サンプルタスクデータ
let sampleTasks = [
  WidgetTask(id: "1", title: "朝のミーティング", isCompleted: true),
  WidgetTask(id: "2", title: "レポート提出", isCompleted: false),
  WidgetTask(id: "3", title: "買い物", isCompleted: false),
  WidgetTask(id: "4", title: "デザインの作成", isCompleted: false),
  WidgetTask(id: "5", title: "コードレビュー", isCompleted: false),
  WidgetTask(id: "6", title: "週報作成", isCompleted: false),
  WidgetTask(id: "7", title: "プレゼン準備", isCompleted: false),
  WidgetTask(id: "8", title: "顧客対応", isCompleted: false),
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

#Preview("Today Small", as: .systemSmall) {
  TodayTasksWidget()
} timeline: {
  sampleEntry
}

#Preview("Today Medium", as: .systemMedium) {
  TodayTasksWidget()
} timeline: {
  sampleEntry
}

#Preview("Today Large", as: .systemLarge) {
  TodayTasksWidget()
} timeline: {
  sampleEntry
}

// タスクなしのプレビューも追加
#Preview("Tasks Empty Small", as: .systemSmall) {
  TodayTasksWidget()
} timeline: {
  noTasksEntry
}

#Preview("Tasks Empty Medium", as: .systemMedium) {
  TodayTasksWidget()
} timeline: {
  noTasksEntry
}

#Preview("Tasks Empty Large", as: .systemLarge) {
  TodayTasksWidget()
} timeline: {
  noTasksEntry
}

#Preview("Progress Small", as: .systemSmall) {
  TaskProgressWidget()
} timeline: {
  sampleEntry
}

#Preview("Progress Small Tasks Empty", as: .systemSmall) {
  TaskProgressWidget()
} timeline: {
  noTasksEntry
}

#Preview("Progress Small All Completed", as: .systemSmall) {
  TaskProgressWidget()
} timeline: {
  // 全て完了している場合
  SimpleEntry(date: Date(), tasks: sampleTasks.map { WidgetTask(id: $0.id, title: $0.title, isCompleted: true) }, locale: "ja")
}
