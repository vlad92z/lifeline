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
