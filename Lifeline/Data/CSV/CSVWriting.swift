//
//  CSVWriting.swift
//  Lifeline
//
//  Created by Vlad on 12/10/2025.
//
import Foundation

protocol CSVWriting {
    
    var headers: [String] { get }
    var url: URL { get }
    var fileHandle: FileHandle { get }
    
    func write(row: [String: String?]) async
    func close() throws
}
