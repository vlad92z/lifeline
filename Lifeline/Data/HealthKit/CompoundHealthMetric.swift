//
//  HealthKitMetric.swift
//  Lifeline
//
//  Created by Vlad on 30/09/2025.
//

enum CompoundHealthMetric: Codable {
    
    case energyBurnedKcal(Double, Double)
    
    var name: String {
        switch self {
        case .energyBurnedKcal: "Total (kcal)"
        }
    }
    
    var value: Double {
        switch self {
        case let .energyBurnedKcal(basal, active):
            return basal + active
        }
    }
}
