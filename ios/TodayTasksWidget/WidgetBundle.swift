import SwiftUI
import WidgetKit
import AppIntents

// MARK: - WidgetBundle
// 複数のウィジェットをまとめるバンドル
@main
struct TodayTasksWidgetBundle: WidgetBundle {
  var body: some Widget {
    TodayTasksWidget()
    TaskProgressWidget()
    LockScreenProgressWidget()
    LockScreenAddTaskWidget()
    LockScreenTaskListWidget()
  }
}

// MARK: - Shortcuts Provider
// iOS Shortcuts アプリで利用可能なIntentsを提供
@available(iOS 16.0, *)
struct ShortcutsProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: QuickAddTaskIntent(),
            phrases: [
                "今日のタスクを\(.applicationName)に追加",
                "\(.applicationName)でタスク追加",
                "\(.applicationName)にタスクを追加"
            ],
            shortTitle: "タスク追加",
            systemImageName: "plus.circle"
        )
        
        AppShortcut(
            intent: AddTaskIntent(),
            phrases: [
                "\(.applicationName)でタスクを追加",
                "\(.applicationName)にタスクを作成"
            ],
            shortTitle: "詳細タスク追加",
            systemImageName: "plus"
        )
        
        AppShortcut(
            intent: ShowTodayTasksIntent(),
            phrases: [
                "\(.applicationName)で今日のタスクを見る",
                "\(.applicationName)のタスクを確認",
                "今日のタスクを\(.applicationName)で表示"
            ],
            shortTitle: "今日のタスク",
            systemImageName: "list.bullet"
        )
    }
}
