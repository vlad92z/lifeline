//
//  ToggleView.swift
//  Lifeline
//
//  Created by Vlad on 04/10/2025.
//
import SwiftUI

struct HealthMetricsToggleView: View {
    let title: String
    let categories: [HealthMetricCategory]
    let available: Set<HealthMetric.ID >
    @Binding var enabled: Set<HealthMetric.ID>
    
    private var filteredCategories: [HealthMetricCategory] {
        categories.filter { category in
            let metricIDs = Set(category.metrics.map { $0.id })
            let advancedIDs = Set(category.advanced.map { $0.id })
            return !available.isDisjoint(with: metricIDs) || !available.isDisjoint(with: advancedIDs)
        }
    }
    
    var body: some View {
        Form {
            ForEach(filteredCategories) { category in
                ToggleView(
                    title: category.name,
                    elements: category.metrics,
                    advanced: category.advanced,
                    available: available,
                    enabled: $enabled
                )
            }
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Disable All") {
                    enabled.removeAll()
                }
            }
        }
    }
    
    private func binding(for id: HealthMetric.ID) -> Binding<Bool> {
        Binding(
            get: {
                enabled.contains(id)
            },
            set: { isOn in
                if isOn { enabled.insert(id) } else { enabled.remove(id) }
            }
        )
    }
}

#Preview("ToggleView Example") {
    @Previewable @State var enabledMetrics = Set<HealthMetric.ID>()
    HealthMetricsToggleView(
        title: "Select Export Metrics",
        categories: HealthMetricCategory.all,
        available: Set(HealthMetric.allCases.map { $0.id}),
        enabled: $enabledMetrics)
}
