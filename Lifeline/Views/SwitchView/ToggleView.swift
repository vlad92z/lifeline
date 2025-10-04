//
//  ToggleView.swift
//  Lifeline
//
//  Created by Vlad on 04/10/2025.
//
import SwiftUI

struct ToggleView<T: ToggleElement>: View {
    let title: String
    let elements: [T]
    
    @Binding var enabled: Set<T.ID>
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(elements) { element in
                        ToggleRow(
                            element: element,
                            isOn: binding(for: element.id)
                        )
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(enabled.isEmpty ? "Turn On All" : "Turn Off All") {
                        if enabled.isEmpty {
                            enabled = Set(elements.map { $0.id })
                        } else {
                            enabled.removeAll()
                        }
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
    
    private func binding(for id: T.ID) -> Binding<Bool> {
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
    ToggleView(title: "Select Export Metrics", elements: HealthMetric.allCases, enabled: $enabledMetrics)
}

