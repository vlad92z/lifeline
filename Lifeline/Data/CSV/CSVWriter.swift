//
//  CSVWriter.swift
//  Lifeline
//
//  Created by Vlad on 30/09/2025.
//

import Foundation

extension Double {
    var toString: String {
        return String(self)
    }
}

struct CSVWriter {
    
    static let dateHeader = "Date"
    static let filenamePrefix = "health_data_"
    static let fileExtension = "csv"
    
    let formatter = DateFormatter()
    
    init() {
        formatter.timeZone = .current
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
    }
    
    func addEscapeCharacters(to original: String) -> String {
        let needsQuotes = original.contains { $0 == "," || $0 == "\n" || $0 == "\"" }
        let escaped = original.replacingOccurrences(of: "\"", with: "\"\"")
        return needsQuotes ? "\"\(escaped)\"" : escaped
    }

    func headerRowData(_ headers: [String]) -> Data {
        let line = headers.map(addEscapeCharacters).joined(separator: ",") + "\n"
        return Data(line.utf8)
    }

    func rowData(headers: [String], data: [String: String?]) -> Data {
        let cells = headers.map { key -> String in
            if let valueForKey = data[key], let nonNullValue = valueForKey {
                return addEscapeCharacters(to: nonNullValue)
            } else {
                return ""
            }
        }
        let line = cells.joined(separator: ",") + "\n"
        return Data(line.utf8)
    }
    
    func newFileUrl() -> URL {
        FileManager.default.temporaryDirectory
            .appendingPathComponent("\(CSVWriter.filenamePrefix)\(UUID().uuidString)")
            .appendingPathExtension(CSVWriter.fileExtension)
    }
    
    
    
    func write(metrics: [HealthMetric], from start: Date, to end: Date, calendar: Calendar = .current) async -> URL {
        let headers = [CSVWriter.dateHeader] + metrics.map { $0.name }
        let reader = HealthKitReader()

        let url = newFileUrl()
        FileManager.default.createFile(atPath: url.path, contents: nil, attributes: nil)
        guard let handle = try? FileHandle(forWritingTo: url) else { return url }

        handle.write(headerRowData(headers))
        
        var hasWrittenFirstRow = false // needed to ignore leading empty rows
        var current = start
        while current <= end {
            let dailyMetrics = (try! await reader.dailyValues(for: metrics, date: current)).map { key, value in
                return (key.name, value?.toString)
            }
            let isEmptyRow = dailyMetrics.allSatisfy { $0.1 == nil }
            if hasWrittenFirstRow || !isEmptyRow {
                var row = Dictionary(uniqueKeysWithValues: dailyMetrics)
                row[CSVWriter.dateHeader] = formatter.string(from: current)
                handle.write(rowData(headers: headers, data: row))
                if !isEmptyRow { hasWrittenFirstRow = true }
            }
            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }
        try? handle.close()
        return url
    }
}

