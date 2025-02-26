import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), tasks: ["サンプルタスク1", "サンプルタスク2", "サンプルタスク3"])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), tasks: ["サンプルタスク1", "サンプルタスク2", "サンプルタスク3"])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // ユーザーデフォルトからタスクを取得
        let sharedDefaults = UserDefaults(suiteName: "group.com.ymkokh.notionTodo")
        var tasks: [String] = []
        
        if let tasksData = sharedDefaults?.object(forKey: "today_tasks") as? Data {
            if let decodedTasks = try? JSONDecoder().decode([String].self, from: tasksData) {
                tasks = decodedTasks
            }
        }
        
        if tasks.isEmpty {
            tasks = ["タスクがありません"]
        }
        
        // 現在の日付
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, tasks: tasks)
        entries.append(entry)
        
        // 次の更新時間（1時間後）
        let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        
        let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let tasks: [String]
}

struct TodayTasksWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("今日のタスク")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text(entry.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 4)
            
            ForEach(Array(entry.tasks.prefix(getMaxTaskCount()).enumerated()), id: \.offset) { index, task in
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "circle")
                        .font(.system(size: 12))
                        .foregroundColor(.blue)
                    Text(task)
                        .font(.system(size: 14))
                        .lineLimit(1)
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    func getMaxTaskCount() -> Int {
        switch widgetFamily {
        case .systemSmall:
            return 3
        case .systemMedium:
            return 5
        case .systemLarge:
            return 10
        default:
            return 3
        }
    }
}

struct TodayTasksWidget: Widget {
    let kind: String = "TodayTasksWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TodayTasksWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("今日のタスク")
        .description("今日のタスクを表示します")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct TodayTasksWidget_Previews: PreviewProvider {
    static var previews: some View {
        TodayTasksWidgetEntryView(entry: SimpleEntry(date: Date(), tasks: ["タスク1", "タスク2", "タスク3"]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
} 
