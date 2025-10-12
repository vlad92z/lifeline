//
//  HealthCSVWriter.swift
//  Lifeline
//
//  Created by Vlad on 30/09/2025.
//

import Foundation

struct HealthCSVWriter {
    
    static let dateHeader = "Date"
    static let lifelinePrefix = "lifeline_"
    
    let csvWriterFactory: CSVWritingFactory
    
    var formatter = DateFormatter()
    var calendar = Calendar.current
    
    init(csvWriterFactory: CSVWritingFactory) {
        self.csvWriterFactory = csvWriterFactory
        formatter.timeZone = .current
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
    }
    
    func newFileName() -> String {
        "\(HealthCSVWriter.lifelinePrefix)\(UUID().uuidString)"
    }
    
    func write(metrics: [HealthMetric], from start: Date, to end: Date) async throws -> URL {
        let headers = [HealthCSVWriter.dateHeader] + metrics.map { $0.name }
        let csvWriter = try csvWriterFactory.make(filename: newFileName(), headers: headers)
        
        let reader = HealthMetricReader()
        var hasWrittenFirstRow = false // needed to ignore leading empty rows
        
        var current = start
        while current <= end {
            let dailyMetricMap = try await reader.dailyValues(for: metrics, date: current)
            let keyValuePairs = dailyMetricMap.map { key, value in
                return (key.name, value?.toString)
            }
            let isEmptyRow = keyValuePairs.allSatisfy { $0.1 == nil }
            if hasWrittenFirstRow || !isEmptyRow {
                var row = Dictionary(uniqueKeysWithValues: keyValuePairs)
                row[HealthCSVWriter.dateHeader] = formatter.string(from: current)
                await csvWriter.write(row: row)
                if !isEmptyRow { hasWrittenFirstRow = true }
            }
            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }
        try csvWriter.close()
        return csvWriter.url
    }
}

