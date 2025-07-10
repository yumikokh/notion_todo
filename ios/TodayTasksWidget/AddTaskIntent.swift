import AppIntents
import Foundation

// MARK: - Task Adding App Intent for Siri and Shortcuts
@available(iOS 16.0, *)
struct AddTaskIntent: AppIntent {
    static var title: LocalizedStringResource = "タスクを追加"
    static var description: IntentDescription? = IntentDescription("新しいタスクをNotionデータベースに追加します")
    
    // タスクのタイトルパラメーター
    @Parameter(title: "タスク名", description: "追加するタスクの内容")
    var taskTitle: String
    
    // 期日パラメーター（オプショナル）
    @Parameter(title: "期日", description: "タスクの期日")
    var dueDate: Date?
    
    static var parameterSummary: some ParameterSummary {
        Summary("「\(\.$taskTitle)」をタスクに追加") {
            \.$dueDate
        }
    }
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        // URL Schemeを使ってFlutterアプリにタスク追加を依頼
        let encodedTitle = taskTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        var urlString = "notiontodo://add_task_with_title?title=\(encodedTitle)"
        
        // 期日が指定されている場合は追加
        if let dueDate = dueDate {
            let dateFormatter = ISO8601DateFormatter()
            let dueDateString = dateFormatter.string(from: dueDate)
            let encodedDueDate = dueDateString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            urlString += "&dueDate=\(encodedDueDate)"
        }
        
        if let url = URL(string: urlString) {
            await UIApplication.shared.open(url)
            return .result(dialog: IntentDialog("「\(taskTitle)」をタスクに追加しました"))
        } else {
            throw IntentError.appNotAvailable
        }
    }
}

// MARK: - Quick Add Task Intent (for today)
@available(iOS 16.0, *)
struct QuickAddTaskIntent: AppIntent {
    static var title: LocalizedStringResource = "今日のタスクを追加"
    static var description: IntentDescription? = IntentDescription("今日の期日で新しいタスクを追加します")
    
    @Parameter(title: "タスク名")
    var taskTitle: String
    
    static var parameterSummary: some ParameterSummary {
        Summary("今日のタスクに「\(\.$taskTitle)」を追加")
    }
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let encodedTitle = taskTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "notiontodo://add_task_with_title?title=\(encodedTitle)&today=true"
        
        if let url = URL(string: urlString) {
            await UIApplication.shared.open(url)
            return .result(dialog: IntentDialog("「\(taskTitle)」を今日のタスクに追加しました"))
        } else {
            throw IntentError.appNotAvailable
        }
    }
}

// MARK: - Show Today's Tasks Intent
@available(iOS 16.0, *)
struct ShowTodayTasksIntent: AppIntent {
    static var title: LocalizedStringResource = "今日のタスクを表示"
    static var description: IntentDescription? = IntentDescription("今日のタスク一覧を表示します")
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let urlString = "notiontodo://open/today"
        
        if let url = URL(string: urlString) {
            await UIApplication.shared.open(url)
            return .result(dialog: IntentDialog("今日のタスクを表示します"))
        } else {
            throw IntentError.appNotAvailable
        }
    }
}

// MARK: - Intent Errors
enum IntentError: Error, LocalizedError {
    case appNotAvailable
    case invalidInput
    
    var errorDescription: String? {
        switch self {
        case .appNotAvailable:
            return "アプリが利用できません"
        case .invalidInput:
            return "入力が無効です"
        }
    }
}