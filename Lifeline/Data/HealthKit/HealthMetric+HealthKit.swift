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
        case .sleepingTemp: .appleSleepingWristTemperature
        case .bodyFat: .bodyFatPercentage
        case .activeEnergyKcal: .activeEnergyBurned
        case .basalEnergyKcal: .basalEnergyBurned
        case .dietaryEnergyKcal: .dietaryEnergyConsumed
        case .dietaryProtein: .dietaryProtein
        case .dietarySugar: .dietarySugar
        case .restingHeartRate: .restingHeartRate
        case .bodyMass: .bodyMass
        case .bodyMassIndex: .bodyMassIndex
        case .electroDermalActivity: .electrodermalActivity
        case .height: .height
        case .leanBodyMass: .leanBodyMass
        }
    }
    
    var quantityType: HKQuantityType {
        return HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!
    }
    
    var unit: HKUnit {
        switch self {
        case .sleepingTemp:
            return .degreeCelsius()
        case .activeEnergyKcal, .basalEnergyKcal, .dietaryEnergyKcal:
            return .kilocalorie()
        case .dietaryProtein, .dietarySugar:
            return .gram()
        case .restingHeartRate:
            return .count().unitDivided(by: .minute())
        case .bodyMass, .leanBodyMass:
            return .gramUnit(with: .kilo)
        case .bodyFat:
            return .percent()
        case .bodyMassIndex:
            return .count()
        case .electroDermalActivity:
            return .siemenUnit(with: .micro)
        case .height:
            return HKUnit.meterUnit(with: .centi)
        }
    }
    
    var aggregation: HKStatisticsOptions {
        switch self {
        case .sleepingTemp:
            return [.discreteAverage]
        case .activeEnergyKcal, .basalEnergyKcal, .dietaryEnergyKcal, .dietaryProtein, .dietarySugar:
            return [.cumulativeSum]
        case .restingHeartRate, .electroDermalActivity:
            return [.discreteAverage]
        case .bodyMass, .bodyFat, .bodyMassIndex, .leanBodyMass, .height:
            return [.mostRecent]
        }
    }
}
