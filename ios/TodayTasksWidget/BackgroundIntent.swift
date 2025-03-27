import WidgetKit
import Foundation
import AppIntents
import home_widget

@available(iOS 17, *)
public struct BackgroundIntent: AppIntent {
  static public var title: LocalizedStringResource = "HomeWidget Background Intent"

  @Parameter(title: "Widget URI")
  var url: URL?

   public init() {
        NSLog("BackgroundIntent initialized")
    }

    public init(url: URL?) {
        self.url = url
        NSLog("BackgroundIntent initialized with URL: \(String(describing: url))")
    }

  public func perform() async throws -> some IntentResult {
    // アプリが完全に終了している状態でも動作するように、
    // UserDefaultsを使用してタスク情報を保存

    NSLog("BackgroundIntent perform - START")
    NSLog("URL: \(String(describing: url))")
  
    // 通常のHomeWidgetBackgroundWorker.runも実行
    NSLog("Calling HomeWidgetBackgroundWorker.run")

    await HomeWidgetBackgroundWorker.run(
      url: url,
      appGroup: "group.com.ymkokh.notionTodo")
  

    // 処理完了を待つために少し遅延を入れる
    try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5秒待機
      
    return .result()
  }
}

// アプリをバックグラウンドから起動するための拡張
@available(iOS 17, *)
@available(iOSApplicationExtension, unavailable)
extension BackgroundIntent: ForegroundContinuableIntent {}
