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
        if !advanced.isEmpty {
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
                    Text("\(title) (Advanced)")
                    Spacer()
                    Button(showAdvanced ? "Hide" : "Show") {
                        withAnimation(.snappy) { showAdvanced.toggle() }
                    }
                    .font(.footnote.weight(.semibold))
                    .buttonStyle(.plain)
                    .accessibilityLabel("Toggle Advanced")
                    
                    Button(anySelected ? "All Off" : "All On") {
                        if anySelected {
                            // Any selected: turn off all (including advanced)
                            enabled.subtract(allIDs)
                        } else {
                            // None selected: turn on all visible (include advanced only if showing)
                            enabled.formUnion(visibleIDs)
                        }
                    }
                    .font(.footnote.weight(.semibold))
                    .buttonStyle(.plain)
                    .accessibilityLabel(anySelected ? "Turn Off All" : "Turn On All")
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
    
    private var allIDs: Set<T.ID> {
        Set(elements.map(\.id)).union(Set(advanced.map(\.id)))
    }
    
    private var visibleIDs: Set<T.ID> {
        var ids = Set(elements.map(\.id))
        if showAdvanced {
            ids.formUnion(advanced.map(\.id))
        }
        return ids
    }
    
    private var anySelected: Bool {
        !enabled.isDisjoint(with: allIDs)
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

