//
//  TodayTasksWidgetLiveActivity.swift
//  TodayTasksWidget
//
//  Created by Yumiko Kokubu on 2025/02/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TodayTasksWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TodayTasksWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TodayTasksWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TodayTasksWidgetAttributes {
    fileprivate static var preview: TodayTasksWidgetAttributes {
        TodayTasksWidgetAttributes(name: "World")
    }
}

extension TodayTasksWidgetAttributes.ContentState {
    fileprivate static var smiley: TodayTasksWidgetAttributes.ContentState {
        TodayTasksWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TodayTasksWidgetAttributes.ContentState {
         TodayTasksWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TodayTasksWidgetAttributes.preview) {
   TodayTasksWidgetLiveActivity()
} contentStates: {
    TodayTasksWidgetAttributes.ContentState.smiley
    TodayTasksWidgetAttributes.ContentState.starEyes
}
