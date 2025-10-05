//
//  ExportParentView.swift
//  Lifeline
//
//  Created by Vlad on 05/10/2025.
//
import SwiftUI

struct HealthExportRootView: View {
    @AppStorage("isHealthDataRequested", store: UserDefaults(suiteName: "group.com.vladz.lifeline"))
    var isRequested = false
    
    var body: some View {
        if isRequested {
            HealthExportView()
        } else {
            HealthKitAuthorisationView(healthReader: HealthKitReader(), isHealthDataAccessRequested: $isRequested)
        }
    }
}
