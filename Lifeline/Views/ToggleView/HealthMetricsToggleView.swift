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
    
    @Binding var enabled: Set<HealthMetric.ID>
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                ForEach(categories) { category in
                    ToggleView(
                        title: category.name,
                        elements: category.metrics,
                        advanced: category.advanced,
                        enabled: $enabled
                    )
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Turn Off All") {
                        enabled.removeAll()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
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
        enabled: $enabledMetrics)
}

