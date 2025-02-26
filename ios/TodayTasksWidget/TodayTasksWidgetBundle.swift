//
//  TodayTasksWidgetBundle.swift
//  TodayTasksWidget
//
//  Created by Yumiko Kokubu on 2025/02/26.
//

import WidgetKit
import SwiftUI

@main
struct TodayTasksWidgetBundle: WidgetBundle {
    var body: some Widget {
        TodayTasksWidget()
        TodayTasksWidgetControl()
        TodayTasksWidgetLiveActivity()
    }
}
