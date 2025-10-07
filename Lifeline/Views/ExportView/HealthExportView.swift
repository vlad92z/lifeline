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
        
    @StateObject private var viewModel = HealthExportViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section("Metrics") {
                        NavigationLink {
                            HealthMetricsToggleView(
                                title: "Select Export Metrics",
                                categories: HealthMetricCategory.all,
                                available: viewModel.availableMetrics,
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
                            Task { await viewModel.exportCSV() }
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
            .task { viewModel.onAppear() }
            .task { viewModel.setAvailableMetrics()}
            .onChange(of: viewModel.metricsToExport) { viewModel.metricsSelectionDidChange() }
            .onChange(of: viewModel.start) {
                viewModel.normalizeStart()
            }
            .onChange(of: viewModel.end) {
                viewModel.normalizeEnd()
            }
        }
        
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
