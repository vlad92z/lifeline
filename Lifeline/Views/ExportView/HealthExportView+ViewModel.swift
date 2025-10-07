//
//  HealthExportView+ViewModel.swift
//  Lifeline
//
//  Created by Vlad on 07/10/2025.
//

import Foundation

extension HealthExportView {
    
    @MainActor
    class ViewModel: ObservableObject {
        
        let metricsSelectionDefaultsKey = "HealthExport.metricsSelection"
        
        @Published var shareURL: URL?
        @Published var start = Calendar.current.startOfDay(for: Date())
        @Published var end = Calendar.current.startOfDay(for: Date())
        @Published var metricsToExport = Set<HealthMetric.ID>()
        @Published var isExporting = false
        
        var selectedText: String {
            if metricsToExport.isEmpty {
                return "Tap to select metrics to export"
            } else {
                return metricsToExport
                    .sorted()
                    .joined(separator: ", ")
            }
        }
    }
}
