//
//  ExportView.swift
//  Lifeline
//
//  Created by Vlad on 28/09/2025.
//
import SwiftUI

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

    
    var body: some View {
        VStack {
            HStack {
                DatePicker("Start", selection: $start, displayedComponents: [.date]).padding()
                DatePicker("End", selection: $end, displayedComponents: [.date]).padding()
            }
            
            Button("Request Access") {
                Task {
                    let reader = HealthKitReader()
                    reader.requestAuthorization()
                }
            }
            Button("Share CSV") {
                Task {
                    shareURL = await csvTempURL()
                }
            }
            .sheet(item: $shareURL, onDismiss: {
                
            }, content: { shareURL in
                ActivityViewController(url: shareURL)
            })
        }
    }
    
    private func csvTempURL() async -> URL {
        let writer = CSVWriter()
        return await writer.write(metrics: [.activeEnergyKcal,
                                            .basalEnergyKcal,
                                            .dietaryEnergyKcal,
                                            .dietaryProtein,
                                            .dietarySugar,
                                            .restingHeartRate],
                                  date: Date())
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
