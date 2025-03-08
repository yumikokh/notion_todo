import SwiftUI
import WidgetKit

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

// MARK: - TimelineEntry
// Widgetに表示するデータモデル
// TimelineEntryプロトコルに準拠し、dateプロパティが必須
struct SimpleEntry: TimelineEntry {
    let date: Date  // 必須プロパティ：Widgetの更新時間を表す
    let tasks: [String]  // カスタムプロパティ：表示するタスクのリスト
}

// MARK: - WidgetEntryView
// Widgetの実際のUI表示を担当するView
struct TodayTasksWidgetEntryView: View {
    var entry: Provider.Entry  // TimelineProviderから提供されるデータ
    @Environment(\.widgetFamily) var widgetFamily  // Widgetのサイズ（small, medium, large）を取得

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

            // タスクがない場合の表示
            if entry.tasks.first == "タスクがありません" {
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
                .padding(.top, 10)
            } else {
                // タスクリストの表示
                // Widgetサイズに応じて表示数を制限
                ForEach(Array(entry.tasks.prefix(getMaxTaskCount()).enumerated()), id: \.offset) {
                    index, task in
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "circle")
                            .font(.system(size: 14))
                            .foregroundColor(.blue)
                        Text(task)
                            .font(.system(size: 14))
                            .lineLimit(1)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 1)
                }
            }

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
            return 3  // 中サイズでは最大4つ
        case .systemLarge:
            return 10  // 大サイズでは最大10つ
        default:
            return 3  // その他のサイズでは3つをデフォルトとする
        }
    }
}

// MARK: - Widget定義
// Widgetの基本設定を行う構造体
struct TodayTasksWidget: Widget {
    let kind: String = "TodayTasksWidget"  // Widgetの一意の識別子

    var body: some WidgetConfiguration {
        // 静的なWidget設定（インタラクティブでないWidget）
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TodayTasksWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Today")  // Widgetギャラリーでの表示名
        .description("Today's tasks")  // Widgetの説明
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])  // サポートするWidgetサイズ
    }
}

// MARK: - プレビュー
// Xcodeのプレビュー機能用の設定
struct TodayTasksWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 小サイズウィジェットのプレビュー
            TodayTasksWidgetEntryView(
                entry: SimpleEntry(date: Date(), tasks: ["買い物に行く", "メールを返信", "会議の準備"])
            )
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("Small Widget")

            // 中サイズウィジェットのプレビュー
            TodayTasksWidgetEntryView(
                entry: SimpleEntry(
                    date: Date(), tasks: ["買い物に行く", "メールを返信", "会議の準備", "資料作成", "電話をかける"])
            )
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .previewDisplayName("Medium Widget")

            // 大サイズウィジェットのプレビュー
            TodayTasksWidgetEntryView(
                entry: SimpleEntry(
                    date: Date(),
                    tasks: [
                        "買い物に行く", "メールを返信", "会議の準備", "資料作成", "電話をかける", "プレゼン準備", "ジムに行く", "夕食の準備",
                        "本を読む", "日記を書く",
                    ])
            )
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .previewDisplayName("Large Widget")

            // タスクが空の場合のプレビュー
            TodayTasksWidgetEntryView(entry: SimpleEntry(date: Date(), tasks: ["タスクがありません"]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDisplayName("No Tasks")
        }
    }
}
