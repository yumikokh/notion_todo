import SwiftUI
import WidgetKit

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
