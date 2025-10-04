//
//  HealthKitMetric.swift
//  Lifeline
//
//  Created by Vlad on 30/09/2025.
//

enum HealthMetric: String, Codable, CaseIterable, Identifiable {
    
    case sleepingTemp = "Sleeping Wrist Temperature (°C)"
    case bodyFat = "Body Fat (%)"
    case activeEnergyKcal = "Active Energy (kcal)"
    case basalEnergyKcal = "Basal Energy (kcal)"
    case dietaryEnergyKcal = "Consumed (kcal)"
    case dietaryProtein = "Protein (g)"
    case dietarySugar = "Sugar (g)"
    case restingHeartRate = "Resting HR"
    case bodyMass = "Weight (kg)"
    case bodyMassIndex = "BMI"
    case electroDermalActivity = "EDA"
    case height = "Height (cm)"
    case leanBodyMass = "Lean Body Mass (kg)"
    
    var name: String {
        return rawValue
    }
    
    var id: String {
        return rawValue
    }
    
    /// Returns the metrics that match the provided set of IDs.
    /// - Parameter ids: A set of `HealthMetric.ID` values (backed by the enum's `rawValue`).
    /// - Returns: An array of `HealthMetric` instances whose IDs are contained in `ids`.
    ///            The order of the returned array matches `HealthMetric.allCases` for determinism.
    static func metrics(from ids: Set<ID>) -> [HealthMetric] {
        allCases.filter { ids.contains($0.id) }
    }
}
