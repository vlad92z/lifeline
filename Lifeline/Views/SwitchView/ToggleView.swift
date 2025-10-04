//
//  ToggleView.swift
//  Lifeline
//
//  Created by Vlad on 04/10/2025.
//
import SwiftUI

struct ToggleView<T: ToggleElement>: View {
    let elements: [T]
    
    @Binding var enabled: Set<T.ID>
    
    var body: some View {
            List {
                // Action row
                Section {
                    Button(enabled.isEmpty ? "Turn On All" : "Turn Off All") {
                        if enabled.isEmpty {
                            enabled = Set(elements.map { $0.id })
                        } else {
                            enabled.removeAll()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }

                // Toggles
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
//            .navigationTitle(title)
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
    ToggleView(elements: HealthMetric.allCases, enabled: $enabledMetrics)
}
