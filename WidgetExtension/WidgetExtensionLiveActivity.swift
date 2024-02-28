//
//  WidgetExtensionLiveActivity.swift
//  WidgetExtension
//
//  Created by Vlad Z on 25/02/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
    }
}

struct WidgetExtensionLiveActivity: Widget {
    @SharedAppStorage("selectedDate") var storedBirthday = Date().timeIntervalSince1970
    @SharedAppStorage("lifeExpectancy") var lifeExpectancy = 83
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetExtensionAttributes.self) { context in
            let birthday = Date(timeIntervalSince1970: storedBirthday)
            // Lock screen/banner UI goes here
            VStack {
                let stats = LifeStats.generate(from: birthday, lifeExpectancy: lifeExpectancy)
                HStack {
                    Image("Lifeline")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    Spacer()
                }.padding(0)
                MarkerProgressView(progress: stats.age / Double(lifeExpectancy))
                HStack {
                    Text("Days spent")
                    Text("\(stats.daysSpent)").bold()
                    Spacer()
                    Text("Days left")
                    Text("\(stats.daysLeft)").bold()
                }
                Spacer()
                HStack {
                    Text("\(stats.yearsLeft) years or " +
                         "\(stats.weeksLeft) weeks left").italic()
                }
            }.padding()
                .activityBackgroundTint(Color.black.opacity(0.7))
            
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {}
                DynamicIslandExpandedRegion(.trailing) {}
                DynamicIslandExpandedRegion(.bottom) {}
            } compactLeading: {
            } compactTrailing: {
            } minimal: {
            }
            .keylineTint(Color.red)
        }
    }
}

extension WidgetExtensionAttributes {
    fileprivate static var preview: WidgetExtensionAttributes {
        WidgetExtensionAttributes()
    }
}

extension WidgetExtensionAttributes.ContentState {
    fileprivate static var content: WidgetExtensionAttributes.ContentState {
        WidgetExtensionAttributes.ContentState()
    }
}

#Preview("Notification", as: .content, using: WidgetExtensionAttributes.preview) {
    WidgetExtensionLiveActivity()
} contentStates: {
    WidgetExtensionAttributes.ContentState.content
}
