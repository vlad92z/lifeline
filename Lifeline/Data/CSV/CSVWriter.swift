//
//  CSVWriter.swift
//  Lifeline
//
//  Created by Vlad on 11/10/2025.
//

import Foundation

class CSVWriter: CSVWriting {
    
    static let fileExtension = "csv"
    
    static func newFileUrl(_ filename: String) -> URL {
        FileManager.default.temporaryDirectory
            .appendingPathComponent(filename)
            .appendingPathExtension(CSVWriter.fileExtension)
    }
    
    let headers: [String]
    let url: URL
    let fileHandle: FileHandle
    
    init(filename: String, headers: [String]) throws {
        let url = CSVWriter.newFileUrl(filename)
        FileManager.default.createFile(atPath: url.path, contents: nil, attributes: nil)
        self.headers = headers
        self.url = url
        self.fileHandle = try FileHandle(forWritingTo: url)
        
        let headerRow = headers.map(addEscapeCharacters).joined(separator: ",") + "\n"
        self.fileHandle.write(Data(headerRow.utf8))
    }
    
    private func addEscapeCharacters(to original: String) -> String {
        let needsQuotes = original.contains { $0 == "," || $0 == "\n" || $0 == "\"" }
        let escaped = original.replacingOccurrences(of: "\"", with: "\"\"")
        return needsQuotes ? "\"\(escaped)\"" : escaped
    }
    
    private func rowData(data: [String: String?]) -> Data {
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
    
    func write(row: [String: String?]) async {
        fileHandle.write(rowData(data: row))
    }
    
    func close() throws {
        try fileHandle.close()
    }
}
