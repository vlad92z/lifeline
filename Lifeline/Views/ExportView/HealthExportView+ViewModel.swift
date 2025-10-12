//
//  HealthExportView+ViewModel.swift
//  Lifeline
//
//  Created by Vlad on 07/10/2025.
//

import Foundation

@MainActor
final class HealthExportViewModel: ObservableObject {
    // Published properties used by the View
    @Published var metricsToExport: Set<String> = []
    @Published var start: Date = Calendar.current.startOfDay(for: Date())
    @Published var end: Date = Calendar.current.startOfDay(for: Date())
    @Published var isExporting: Bool = false
    @Published var shareURL: URL?
    @Published var availableMetrics: Set<HealthMetric.ID> = []
    
    // Defaults key previously read from the view
    let metricsSelectionDefaultsKey: String = "metricsToExport"
    
    // Dependencies (can be injected in future)
    private let calendar = Calendar.current
    
    var selectedText: String {
        if metricsToExport.isEmpty { return "None" }
        return metricsToExport.sorted().joined(separator: ", ")
    }
    
    func onAppear() {
        loadMetricsSelection()
        // Ensure dates are normalized on first appear
        normalizeStart()
        normalizeEnd()
    }
    
    func metricsSelectionDidChange() {
        saveMetricsSelection()
    }
    
    func normalizeStart() {
        let today = calendar.startOfDay(for: Date())
        var normalizedStart = calendar.startOfDay(for: start)
        if normalizedStart > today { normalizedStart = today }
        start = normalizedStart
        if start > end { end = start }
    }
    
    func normalizeEnd() {
        let today = calendar.startOfDay(for: Date())
        var normalizedEnd = calendar.startOfDay(for: end)
        if normalizedEnd > today { normalizedEnd = today }
        end = normalizedEnd
        if end < start { start = end }
    }
    
    func exportCSV() async {
        guard !isExporting else { return }
        isExporting = true
        let url = await csvTempURL()
        shareURL = url
        isExporting = false
    }
    
    // MARK: - Persistence
    private func loadMetricsSelection() {
        if let saved = UserDefaults.standard.stringArray(forKey: metricsSelectionDefaultsKey) {
            metricsToExport = Set(saved)
        }
    }
    
    private func saveMetricsSelection() {
        let arr = Array(metricsToExport).sorted()
        UserDefaults.standard.set(arr, forKey: metricsSelectionDefaultsKey)
    }
    
    // MARK: - CSV
    private func csvTempURL() async -> URL {
        let writer = HealthCSVWriter(csvWriterFactory: CSVWriterFactory())
        let metrics = HealthMetric.metrics(from: metricsToExport)
        return try! await writer.write(metrics: metrics, from: start, to: end)
    }
    
    func setAvailableMetrics() {
        Task {
            availableMetrics = await HealthMetricReader().getAvailableMetrics()
        }
    }
}
