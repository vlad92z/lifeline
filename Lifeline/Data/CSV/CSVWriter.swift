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
        var hasWrittenFirstRow = false

        var current = start

        while current <= end {
            // Fetch values for this day only (reader should be efficient internally)
            let valuesByMetric = try? await reader.dailyValues(for: metrics, date: current)

            // Map to row keyed by headers (date + metric names)
            var row: [String: String?] = ["date": formatter.string(from: current)]
            if let valuesByMetric = valuesByMetric {
                for (metric, value) in valuesByMetric {
                    if let value = value {
                        row[metric.name] = "\(value)"
                    } else {
                        row[metric.name] = nil
                    }
                }
            }

            // Determine if this row is empty (no metric has a value)
            let isEmptyRow: Bool = {
                // Consider only metric columns; ignore the date column
                for metric in metrics {
                    if let v = row[metric.name], let unwrapped = v, !unwrapped.isEmpty {
                        return false
                    }
                }
                return true
            }()

            // Skip leading empty rows until the first non-empty row is written
            if !hasWrittenFirstRow && isEmptyRow {
                // Do not write this row; advance to next day
            } else {
                handle.write(CSVStream.line(headers: headers, row: row))
                if !isEmptyRow { hasWrittenFirstRow = true }
            }

            // Next day
            guard let next = calendar.date(byAdding: .day, value: 1, to: current) else { break }
            current = next
        }

        return url
    }
}

