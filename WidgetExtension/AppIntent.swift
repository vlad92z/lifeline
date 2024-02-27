//
//  AppIntent.swift
//  WidgetExtension
//
//  Created by Vlad Z on 25/02/2024.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")
}
