//
//  ExportView.swift
//  Lifeline
//
//  Created by Vlad on 28/09/2025.
//
import SwiftUI

struct ExportView: View {
    
    @State private var showMail = false
    @State private var csvData = Data()
    @State var url = URL(string: "https://www.hackingwithswift.com")!
    
    var body: some View {
        VStack {
            Button(action: {
                Task {
                    let reader = HealthKitReader()
                    reader.requestAuthorization()
                }
            }) {
                Text("Access")
            }
            Button(action: {
                Task {
                    let reader = HealthKitReader()
                    let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
                    let endDate = Date()
                    let kcal = try await reader.caloriesConsumed(from: startDate, to: endDate)
                    print(kcal)
                }
            }) {
                Text("Export")
            }
            Button(action: {
                url = csvTempURL()
            }) {
                Text("Data")
            }
            ShareLink(item: url, message: Text("Learn Swift here!"))
        }
    }
    
    private func csvTempURL() -> URL {
        let headers = ["date","calories","note"]
        let rows: [[String: Any]] = [
            ["date": "2025-09-28", "calories": 2213, "note": "rest day"],
            ["date": "2025-09-27", "calories": 2450, "note": "leg day, protein shake"],
        ]
        csvData = CSV.make(headers: headers, rows: rows)
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("export.csv")
        do {
            try csvData.write(to: url, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
        return url
    }
}
