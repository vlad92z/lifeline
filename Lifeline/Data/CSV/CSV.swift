//
//  CSV.swift
//  Lifeline
//
//  Created by Vlad on 28/09/2025.
//
import SwiftUI
import MessageUI

// 1) Minimal CSV builder with proper escaping
struct CSV {
    static func make(headers: [String], rows: [[String: Any]]) -> Data {
        func escape(_ s: String) -> String {
            // RFC4180-ish: wrap in quotes if it contains quote/comma/newline; double quotes inside
            let needsQuotes = s.contains(where: { $0 == "," || $0 == "\n" || $0 == "\"" })
            let body = s.replacingOccurrences(of: "\"", with: "\"\"")
            return needsQuotes ? "\"\(body)\"" : body
        }

        var lines: [String] = []
        lines.append(headers.map(escape).joined(separator: ","))

        for row in rows {
            let cells = headers.map { key -> String in
                if let v = row[key] {
                    return escape(String(describing: v))
                } else {
                    return "" // missing value
                }
            }
            lines.append(cells.joined(separator: ","))
        }

        let csvString = lines.joined(separator: "\n")
        return Data(csvString.utf8)
    }
}

struct CSVStream {
    private static func escape(_ s: String) -> String {
        let needsQuotes = s.contains { $0 == "," || $0 == "\n" || $0 == "\"" }
        let body = s.replacingOccurrences(of: "\"", with: "\"\"")
        return needsQuotes ? "\"\(body)\"" : body
    }

    static func header(_ headers: [String]) -> Data {
        let line = headers.map(escape).joined(separator: ",") + "\n"
        return Data(line.utf8)
    }

    static func line(headers: [String], row: [String: Any]) -> Data {
        let cells = headers.map { key -> String in
            if let v = row[key] {
                return escape(String(describing: v))
            } else {
                return ""
            }
        }
        let line = cells.joined(separator: ",") + "\n"
        return Data(line.utf8)
    }
}
