//
//  HealthMetric+HealthKit.swift
//  Lifeline
//
//  Created by Vlad on 30/09/2025.
//
import HealthKit

extension HealthMetric {
    
    var quantityTypeIdentifier: HKQuantityTypeIdentifier {
        switch self {
        case .activeEnergyKcal: .activeEnergyBurned
        case .basalEnergyKcal: .basalEnergyBurned
        case .dietaryEnergyKcal: .dietaryEnergyConsumed
        case .dietaryProtein: .dietaryProtein
        case .dietarySugar: .dietarySugar
        case .restingHeartRate: .restingHeartRate
        case .bodyMass: .bodyMass
        }
    }
    
    var quantityType: HKQuantityType {
        return HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!
    }
    
    var unit: HKUnit {
        switch self {
        case .activeEnergyKcal, .basalEnergyKcal, .dietaryEnergyKcal:
            return .kilocalorie()
        case .dietaryProtein, .dietarySugar:
            return .gram()
        case .restingHeartRate:
            return .count().unitDivided(by: .minute())
        case .bodyMass:
            return .gramUnit(with: .kilo)
        }
    }
    
    var aggregation: HKStatisticsOptions {
        switch self {
        case .activeEnergyKcal, .basalEnergyKcal, .dietaryEnergyKcal, .dietaryProtein, .dietarySugar:
            return [.cumulativeSum]
        case .restingHeartRate:
            return [.discreteAverage]
        case .bodyMass:
            return [.mostRecent]
        }
    }
}
