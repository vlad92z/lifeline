//
//  ExportView.swift
//  Lifeline
//
//  Created by Vlad on 28/09/2025.
//
import SwiftUI
import UIKit

extension URL: @retroactive Identifiable {
    public var id: String {
        return absoluteString
    }
}

struct HealthExportView: View {
        
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section("Metrics") {
                        NavigationLink {
                            HealthMetricsToggleView(
                                title: "Select Export Metrics",
                                categories: HealthMetricCategory.all,
                                enabled: $viewModel.metricsToExport
                            )
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Select Metrics")
                                Text(viewModel.selectedText)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                    .lineLimit(5)
                            }
                        }
                    }

                    Section("Date Range") {
                        DatePicker("Start", selection: $viewModel.start, displayedComponents: .date)
                        DatePicker("End", selection: $viewModel.end, displayedComponents: .date)
                    }

                    Section {
                        Button("Export CSV") {
                            viewModel.isExporting = true
                            Task {
                                let url = await csvTempURL()
                                await MainActor.run {
                                    viewModel.shareURL = url
                                    viewModel.isExporting = false
                                }
                            }
                        }
                        .disabled(viewModel.isExporting)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .sheet(
                            item: $viewModel.shareURL,
                            onDismiss: { },
                            content: { url in
                            ActivityViewController(url: url)
                        })
                    }
                }
                .listStyle(.insetGrouped)
                    
                if viewModel.isExporting {
                    ZStack {
                        Color.black.opacity(0.2).ignoresSafeArea()
                        ProgressView("Preparing CSV...")
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .navigationTitle("Export")
            .onAppear {
                loadMetricsSelection()
            }
            .onChange(of: viewModel.metricsToExport) {
                saveMetricsSelection()
            }
            .onChange(of: viewModel.start) {
                let cal = Calendar.current
                let today = cal.startOfDay(for: Date())
                var normalizedStart = cal.startOfDay(for: viewModel.start)
                // Clamp start to not be in the future
                if normalizedStart > today { normalizedStart = today }
                viewModel.start = normalizedStart
                // Ensure start <= end
                if viewModel.start > viewModel.end { viewModel.end = viewModel.start }
            }
            .onChange(of: viewModel.end) {
                let cal = Calendar.current
                let today = cal.startOfDay(for: Date())
                var normalizedEnd = cal.startOfDay(for: viewModel.end)
                // Clamp end to not be in the future
                if normalizedEnd > today { normalizedEnd = today }
                viewModel.end = normalizedEnd
                // Ensure start <= end
                if viewModel.end < viewModel.start { viewModel.start = viewModel.end }
            }
        }
        
    }
    
    private func loadMetricsSelection() {
        if let saved = UserDefaults.standard.stringArray(forKey: viewModel.metricsSelectionDefaultsKey) {
            viewModel.metricsToExport = Set(saved)
        }
    }

    private func saveMetricsSelection() {
        let arr = Array(viewModel.metricsToExport).sorted()
        UserDefaults.standard.set(arr, forKey: viewModel.metricsSelectionDefaultsKey)
    }
    
    private func csvTempURL() async -> URL {
        let writer = CSVWriter()
        let metrics = HealthMetric.metrics(from: viewModel.metricsToExport)
        return await writer.write(metrics: metrics, from: viewModel.start, to: viewModel.end)
    }
    
    struct ActivityViewController: UIViewControllerRepresentable {
        let url: URL
        func makeUIViewController(context: Context) -> UIActivityViewController {
            UIActivityViewController(activityItems: [url], applicationActivities: nil)
        }
        
        func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        }
    }
}

#Preview("Export View") {
    HealthExportView()
}

