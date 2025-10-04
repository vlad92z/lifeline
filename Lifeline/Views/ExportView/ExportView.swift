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
    
    @State private var showMail = false
    @State private var csvData = Data()
    @State var url: URL?
    
    @State private var shareURL: URL?
    @State private var showShare = false
    @State private var start = Date()
    @State private var end = Date()
    
    @State var metricsToExport =  Set<HealthMetric.ID>()
    
    var body: some View {
        VStack {
            header
            ToggleView(elements: HealthMetric.allCases, enabled: $metricsToExport)
            HStack {
                DatePicker("Start", selection: $start, displayedComponents: [.date]).padding()
                DatePicker("End", selection: $end, displayedComponents: [.date]).padding()
            }
            Button("Share CSV") {
                Task {
                    shareURL = await csvTempURL()
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .sheet(item: $shareURL, onDismiss: {
                
            }, content: { url in
                ActivityViewController(url: url)
            })
        }.background(Color(uiColor: .systemGroupedBackground))
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

