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
    let advanced: [T]
    @State var showAdvanced: Bool = false
    @Binding var enabled: Set<T.ID>
    
    var body: some View {
        Section(title) {
            ForEach(elements) { element in
                ToggleRow(
                    element: element,
                    isOn: binding(for: element.id)
                )
            }
        }
        Section {
            if showAdvanced {
                ForEach(advanced) { element in
                    ToggleRow(
                        element: element,
                        isOn: binding(for: element.id)
                    )
                }
            }
        } header: {
            HStack {
                Text("Advanced")
                Spacer()
                Button(showAdvanced ? "Hide" : "Show") {
                    withAnimation(.snappy) { showAdvanced.toggle() }
                }
                .font(.footnote.weight(.semibold))
                .buttonStyle(.plain)
                .accessibilityLabel("Toggle Advanced")
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
    let category = HealthMetricCategory.all[0]
    Form {
        ToggleView(
            title: category.name, elements: category.metrics, advanced: category.advanced, enabled: $enabledMetrics)
    }
}

