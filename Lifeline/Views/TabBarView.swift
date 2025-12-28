//
//  TabBarView.swift
//  Lifeline
//
//  Created by Vlad on 28/09/2025.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            Tab("Export", systemImage: "chart.bar") {
                HealthExportRootView()
            }
//            Tab("Insights", systemImage: "chart.bar") {
//                CaloriesBalanceView()
//            }
            Tab("Lifeline", systemImage: "heart.fill") {
                LifeExpectancyView()
            }
        }
    }
}

struct TabBarViewPreviews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
