//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Vlad Z on 25/02/2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), widgetFamily: context.family)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), widgetFamily: context.family)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let entries = [SimpleEntry(date: Date(), widgetFamily: context.family)]
        return Timeline(entries: entries, policy: .atEnd)
    }
    
    private func customizeEntryForSize(_ entry: inout SimpleEntry, for widgetFamily: WidgetFamily) {
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let widgetFamily: WidgetFamily
}

struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry
    @SharedAppStorage("selectedDate") var storedBirthday = Date().timeIntervalSince1970
    @SharedAppStorage("lifeExpectancy") var storedLifeExpectancy = 83
    var body: some View {
        switch entry.widgetFamily {
        case .systemSmall:
                LifelineWidgetSmall(birthday: Date(timeIntervalSince1970: storedBirthday),
                lifeExpectancy: storedLifeExpectancy)
        default:
            LifelineWidgetMedium(birthday: Date(timeIntervalSince1970: storedBirthday),
            lifeExpectancy: storedLifeExpectancy)
        }
        
    }
}

struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration { 
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetExtensionEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

struct LifeGridWidgetEntryView: View {
    var entry: Provider.Entry
    @SharedAppStorage("selectedDate") var storedBirthday = Date().timeIntervalSince1970
    @SharedAppStorage("lifeExpectancy") var storedLifeExpectancy = 83

    var body: some View {
        LifeGridMedium(
            birthday: Date(timeIntervalSince1970: storedBirthday),
            lifeExpectancy: storedLifeExpectancy,
            columns: 48
        )
    }
}

struct LifeGridWidget: Widget {
    let kind: String = "LifeGridWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            LifeGridWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemSmall) {
    WidgetExtension()
} timeline: {
    let small = WidgetFamily(rawValue: 0)!
    SimpleEntry(date: .now, widgetFamily: small)
}

#Preview(as: .systemMedium) {
    WidgetExtension()
} timeline: {
    let small = WidgetFamily(rawValue: 1)!
    SimpleEntry(date: .now, widgetFamily: small)
}
