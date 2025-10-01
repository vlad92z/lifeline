//
//  CSVWriter.swift
//  Lifeline
//
//  Created by Vlad on 30/09/2025.
//

import Foundation

struct CSVWriter {
    
    func write(metrics: [HealthMetric], date: Date) async -> URL {
        let headers = metrics.map { $0.name }
        let reader = HealthKitReader()
        let values = try! await reader.dailyValues(for: metrics, date: date)
        let mapped = Dictionary(uniqueKeysWithValues: values.map { (metric, values) in
            (metric.name, values)
        })
        let csvData = CSV.make(headers: headers, rows: [mapped])
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("health_data.csv")
        do {
            try csvData.write(to: url, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
        return url
    }
}
