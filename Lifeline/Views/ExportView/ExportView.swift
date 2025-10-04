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
    @State private var start = Date()
    @State private var end = Date()
    @State private var metricsToExport = Set<HealthMetric.ID>()
    @State private var isExporting = false
    @State private var showMetricsSheet = false
    
    var body: some View {
        ZStack {
            VStack {
                header
                
                Button("Select Metrics") {
                    showMetricsSheet = true
                }
                Spacer()
                .buttonStyle(.bordered)
                .sheet(isPresented: $showMetricsSheet) {
                    HealthMetricsToggleView(title: "Select Export Metrics", elements: HealthMetric.allCases, enabled: $metricsToExport)
                }
                HStack {
                    DatePicker("Start", selection: $start, displayedComponents: [.date]).padding()
                    DatePicker("End", selection: $end, displayedComponents: [.date]).padding()
                }
                Button("Share CSV") {
                    isExporting = true
                    Task {
                        let url = await csvTempURL()
                        await MainActor.run {
                            shareURL = url
                            isExporting = false
                        }
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .disabled(isExporting)
                .sheet(item: $shareURL, onDismiss: {
                    
                }, content: { url in
                    ActivityViewController(url: url)
                })
            }
            if isExporting {
                ZStack {
                    Color.black.opacity(0.2).ignoresSafeArea()
                    ProgressView("Preparing CSV...")
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                }
            }
        }
        //.background(Color(uiColor: .systemGroupedBackground))
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

