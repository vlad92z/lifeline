//
//  ToggleRow.swift
//  Lifeline
//
//  Created by Vlad on 04/10/2025.
//
import SwiftUI

struct ToggleRow<T: ToggleElement>: View {
    let element: T
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: element.systemImage)
                .foregroundStyle(element.imageColor)
                .frame(width: 24)
            Toggle(element.name, isOn: $isOn)
        }
    }
}

#Preview("ToggleRow Example", traits: .fixedLayout(width: 360, height: 60)) {
    @Previewable @State var isOn = true
    ToggleRow(element: HealthMetric.activeEnergyKcal, isOn: $isOn)
        .padding()
        .background(Color(.systemBackground))
}
