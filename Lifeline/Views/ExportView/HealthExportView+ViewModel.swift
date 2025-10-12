//
//  HealthExportView+ViewModel.swift
//  Lifeline
//
//  Created by Vlad on 07/10/2025.
//

import Foundation

@MainActor
final class HealthExportViewModel: ObservableObject {
    
    @Published var isExporting: Bool = false
    @Published var shareURL: URL?
    @Published var availableMetrics: Set<HealthMetric.ID> = []
    @Published var metricsToExport: Set<String> = [] {
        didSet { saveMetricsSelection() }
    }
    @Published var start: Date = Calendar.current.startOfDay(for: Date()) {
        didSet { normalizeStartInternal() }
    }
    @Published var end: Date = Calendar.current.startOfDay(for: Date()) {
        didSet { normalizeEndInternal() }
    }
    
    let healthCSVWriter: HealthCSVWriting
    let metricsSelectionDefaultsKey: String = "metricsToExport"
    
    private let calendar = Calendar.current
    
    var selectedText: String {
        if metricsToExport.isEmpty { return "None" }
        return metricsToExport.sorted().joined(separator: ", ")
    }
    
    init(healthCSVWriter: HealthCSVWriting) {
        self.healthCSVWriter = healthCSVWriter
        if let saved = UserDefaults.standard.stringArray(forKey: metricsSelectionDefaultsKey) {
            metricsToExport = Set(saved)
        }
        Task {
            availableMetrics = await HealthMetricReader().getAvailableMetrics()
        }
    }
    
    func exportCSV() async {
        guard !isExporting else { return }
        isExporting = true
        let url = await csvTempURL()
        shareURL = url
        isExporting = false
    }
    
    private func saveMetricsSelection() {
        let selectedMetrics = Array(metricsToExport).sorted()
        UserDefaults.standard.set(selectedMetrics, forKey: metricsSelectionDefaultsKey)
    }
    
    private func normalizeStartInternal() {
        let today = calendar.startOfDay(for: Date())
        var normalized = calendar.startOfDay(for: start)
        if normalized > today { normalized = today }
        if normalized > end { end = normalized }
        if start != normalized { start = normalized }
    }

    private func normalizeEndInternal() {
        let today = calendar.startOfDay(for: Date())
        var normalized = calendar.startOfDay(for: end)
        if normalized > today { normalized = today }
        if normalized < start { start = normalized }
        if end != normalized { end = normalized }
    }
    
    private func csvTempURL() async -> URL {
        let metrics = HealthMetric.metrics(from: metricsToExport)
        return try! await healthCSVWriter.write(metrics: metrics, from: start, to: end)
    }
}
