//
//  CaloriesBalanceView.swift
//  Lifeline
//
//  Created by Vlad on 12/10/2025.
//
import SwiftUI
import Charts

struct MonthlyValue: Identifiable {
    let id = UUID()
    let month: Int
    let value: Double
}

struct CaloriesBalanceView: View {
    
    @State var start: Date = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .month, value: -1, to: Date())!)
    @State var end: Date = Calendar.current.startOfDay(for: Date())
    
    @State private var burned: [MonthlyValue] = []
    @State private var consumed: [MonthlyValue] = []
    
    var calendar = Calendar.current
    
    @MainActor func update() async {
        var newBurn: [MonthlyValue] = []
        var newConsumed: [MonthlyValue] = []
        let reader = HealthMetricReader()
        var current = start
        var index = 0
        while current <= end {
            let data = try! await reader.dailyValues(for: [.activeEnergyKcal, .basalEnergyKcal, .dietaryEnergyKcal], date: current)
            if let cons = data[.dietaryEnergyKcal], let value = cons {
                newConsumed.append(MonthlyValue(month: index, value: value))
            }
            if let active = data[.activeEnergyKcal], let ac = active,
               let basal = data[.basalEnergyKcal], let ba = basal {
                newBurn.append(MonthlyValue(month: index, value: ac + ba))
            }
            index += 1
            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }
        consumed = newConsumed
        burned = newBurn
    }
    
    var body: some View {
        VStack {
            Chart(consumed) { item in
                LineMark(
                    x: .value("Day", item.month),
                    y: .value("Value", item.value)
                )
                .symbol(.circle)
                .foregroundStyle(.blue)
            }
            // fixed axes
            .chartYScale(domain: 0...5000)
            .chartXScale(domain: 0...consumed.count)
            .chartXAxis {
                AxisMarks(values: .stride(by: 1)) { _ in
                    AxisGridLine()
                    AxisValueLabel()
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: .stride(by: 1000))
            }
            .frame(height: 300)
            .padding()
            HStack {
                DatePicker("Start", selection: $start, displayedComponents: .date)
                DatePicker("End", selection: $end, displayedComponents: .date)
                Button("Refresh") {
                    Task {
                        await update()
                    }
                }
            }
        }
    }
}

