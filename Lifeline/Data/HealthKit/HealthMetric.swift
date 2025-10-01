//
//  HealthKitMetric.swift
//  Lifeline
//
//  Created by Vlad on 30/09/2025.
//

enum HealthMetric: Codable, CaseIterable {
    
    case activeEnergyKcal
    case basalEnergyKcal
    case dietaryEnergyKcal
    case dietaryProtein
    case dietarySugar
    case restingHeartRate
    case bodyMass
    
    var name: String {
        switch self {
        case .activeEnergyKcal: "Active (kcal)"
        case .basalEnergyKcal: "Basal (kcal)"
        case .dietaryEnergyKcal: "Consumed (kcal)"
        case .dietaryProtein: "Protein (g)"
        case .dietarySugar: "Sugar (g)"
        case .restingHeartRate: "Resting HR"
        case .bodyMass: "Weight (kg)"
        }
    }
}
