//
//  HealthKitAccessView.swift
//  Lifeline
//
//  Created by Vlad on 05/10/2025.
//
import SwiftUI

struct HealthKitAuthorisationView: View {
    
    let healthReader: HealthKitReader
    @Binding var isHealthDataAccessRequested: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 12) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(.pink)
                Text("Connect Health Data")
                    .font(.title2.bold())
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("To export your health data, Lifeline needs **read-only access** to your Health metrics.")
                Text("You can choose **which metrics** to share — like steps, heart rate, or sleep — and you can **change these permissions anytime** in the Health app.")
            }
            .font(.body)
            .foregroundStyle(.secondary)
            
            VStack(alignment: .leading, spacing: 6) {
                Label("Steps", systemImage: "figure.walk")
                Label("Heart Rate", systemImage: "heart.fill")
                Label("Sleep Analysis", systemImage: "bed.double.fill")
            }
            .frame(maxWidth: .infinity)
            .font(.callout)
            .foregroundStyle(.secondary)
            .padding()
            .background(.thinMaterial)
            .cornerRadius(12)
            
            Text("Your health data never leaves your device unless you choose to export it. You can review or revoke access anytime in the Health app → Sources → Lifeline.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.top, 8)
            
            Button(action: {
                Task {
                    await healthReader.requestAuthorization()
                    isHealthDataAccessRequested = true
                }
            }
            ) {
                Text("Grant Access")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
            .controlSize(.large)
            .padding(.top, 10)
        }
        .padding()
    }
}

#Preview("HealthKitAccessView") {
    @Previewable @State var healthData = false
    HealthKitAuthorisationView(healthReader: HealthKitReader(), isHealthDataAccessRequested: $healthData)
}
