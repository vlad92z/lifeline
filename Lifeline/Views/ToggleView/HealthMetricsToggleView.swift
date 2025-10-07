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
    let available: Set<HealthMetric.ID>
    @Binding var enabled: Set<HealthMetric.ID>
    
    var body: some View {
        Form {
            ForEach(categories) { category in
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

