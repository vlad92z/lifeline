//
//  CSVWriter.swift
//  Lifeline
//
//  Created by Vlad on 30/09/2025.
//

import Foundation

struct CSVWriter {
    
    let formatter = DateFormatter()
    
    init() {
        formatter.timeZone = .current
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
    }
    
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

    func write(metrics: [HealthMetric], from start: Date, to end: Date, calendar: Calendar = .current) async -> URL {
        // Build headers with an explicit date column first
        let headers = ["date"] + metrics.map { $0.name }
        let reader = HealthKitReader()

        // Unique temp file URL
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("health_data_\(UUID().uuidString)")
            .appendingPathExtension("csv")

        // Prepare file & handle
        FileManager.default.createFile(atPath: url.path, contents: nil, attributes: nil)
        guard let handle = try? FileHandle(forWritingTo: url) else { return url }
        defer { try? handle.close() }

        // Write header once
        handle.write(CSVStream.header(headers))

        var current = start

        while current <= end {
            // Fetch values for this day only (reader should be efficient internally)
            let valuesByMetric = try? await reader.dailyValues(for: metrics, date: current)

            // Map to row keyed by headers (date + metric names)
            var row: [String: Any] = ["date": formatter.string(from: current)]
            if let valuesByMetric = valuesByMetric {
                for (metric, value) in valuesByMetric {
                    row[metric.name] = value
                }
            }

            // Stream one CSV line
            handle.write(CSVStream.line(headers: headers, row: row))

            // Next day
            guard let next = calendar.date(byAdding: .day, value: 1, to: current) else { break }
            current = next
        }

        return url
    }
}
