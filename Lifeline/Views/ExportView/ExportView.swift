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

struct ExportView: View {
        
    @State private var shareURL: URL?
    @State private var start = Calendar.current.startOfDay(for: Date())
    @State private var end = Calendar.current.startOfDay(for: Date())
    @State private var metricsToExport = Set<HealthMetric.ID>()
    @State private var isExporting = false
    
    
    var selectedText: String {
        if metricsToExport.isEmpty {
            return "Tap to select metrics to export"
        } else {
            return metricsToExport
                .sorted()
                .joined(separator: ", ")
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section("Metrics") {
                        NavigationLink {
                            HealthMetricsToggleView(
                                title: "Select Export Metrics",
                                categories: HealthMetricCategory.all,
                                enabled: $metricsToExport
                            )
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Select Metrics")
                                Text(selectedText)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                    .lineLimit(5)
                            }
                        }
                    }

                    Section("Date Range") {
                        DatePicker("Start", selection: $start, displayedComponents: .date)
                        DatePicker("End", selection: $end, displayedComponents: .date)
                    }

                    Section {
                        Button("Export CSV") {
                            isExporting = true
                            Task {
                                let url = await csvTempURL()
                                await MainActor.run {
                                    shareURL = url
                                    isExporting = false
                                }
                            }
                        }
                        .disabled(isExporting)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .sheet(
                            item: $shareURL,
                            onDismiss: { },
                            content: { url in
                            ActivityViewController(url: url)
                        })
                    }
                }
                .listStyle(.insetGrouped)
                    
                if isExporting {
                    ZStack {
                        Color.black.opacity(0.2).ignoresSafeArea()
                        ProgressView("Preparing CSV...")
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .navigationTitle("Export")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Request") {
                        HealthKitReader().requestAuthorization()
                    }
                }
            }
        }
        
    }
    
    private var header: some View {
        HStack {
            Spacer()
            Button("Request Access") {
                Task {
                    let reader = HealthKitReader()
                    reader.requestAuthorization()
                }
            }.buttonStyle(.borderedProminent)
        }
    }
    
    private func csvTempURL() async -> URL {
        let writer = CSVWriter()
        let metrics = HealthMetric.metrics(from: metricsToExport)
        print(start)
        print(end)
        return await writer.write(metrics: metrics, from: start, to: end)
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
    ExportView()
}

