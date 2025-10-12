//
//  CSVWritingFactory.swift
//  Lifeline
//
//  Created by Vlad on 12/10/2025.
//
protocol CSVWritingFactory {
    func make(filename: String, headers: [String]) throws -> CSVWriting
}

class CSVWriterFactory: CSVWritingFactory {
    
    func make(filename: String, headers: [String]) throws -> CSVWriting {
        return try CSVWriter(filename: filename, headers: headers)
    }
}
