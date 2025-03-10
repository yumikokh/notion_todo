import SwiftUI
import WidgetKit

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
