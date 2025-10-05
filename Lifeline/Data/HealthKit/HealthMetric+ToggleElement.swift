//
//  HealthMetric+ToggleElement.swift
//  Lifeline
//
//  Created by Vlad on 04/10/2025.
//
import SwiftUI

extension HealthMetric: ToggleElement {
    
    var systemImage: String {
        switch self {
        // MARK: - Body Measurements
        case .height: return "ruler"
        case .bodyMass: return "scalemass"
        case .bodyMassIndex: return "chart.bar"
        case .bodyFat: return "percent"
        case .waistCircumference: return "ruler"
        case .leanBodyMass: return "dumbbell"

        // MARK: - Vitals
        case .sleepingTemp, .basalBodyTemperature, .bodyTemperature: return "thermometer"
        case .oxygenSaturation: return "lungs.fill"
        case .respiratoryRate: return "lungs"
        case .bloodPressureDiastolic, .bloodPressureSystolic: return "waveform.path.ecg"

        // MARK: - Energy
        case .activeEnergyKcal: return "flame.fill"
        case .basalEnergyKcal: return "bolt.fill"
        case .dietaryEnergyKcal: return "fork.knife"

        // MARK: - Cardiovascular
        case .restingHeartRate, .maxHeartRate, .walkingHeartRateAverage, .heartRateRecoveryOneMinute: return "heart.fill"
        case .vo2Max: return "figure.run"
        case .heartRateVariabilitySDNN: return "waveform.path.ecg"

        // MARK: - Nutrition
        case .dietaryWater: return "drop.fill"
        case .dietaryCaffeine: return "cup.and.saucer.fill"
        case .dietaryCarbohydrates, .dietaryFatTotal, .dietaryProtein, .dietarySugar, .dietaryFiber, .dietaryCholesterol,
             .dietaryFatMonounsaturated, .dietaryFatPolyunsaturated, .dietaryFatSaturated, .dietarySodium,
             .dietaryBiotin, .dietaryCalcium, .dietaryChloride, .dietaryChromium, .dietaryCopper, .dietaryFolate,
             .dietaryIodine, .dietaryIron, .dietaryMagnesium, .dietaryManganese, .dietaryMolybdenum, .dietaryNiacin,
             .dietaryPantothenicAcid, .dietaryPhosphorus, .dietaryPotassium, .dietaryRiboflavin, .dietarySelenium,
             .dietaryThiamin, .dietaryVitaminA, .dietaryVitaminB12, .dietaryVitaminB6, .dietaryVitaminC, .dietaryVitaminD,
             .dietaryVitaminE, .dietaryVitaminK, .dietaryZinc: return "fork.knife"

        // MARK: - Fitness
        case .stepCount: return "figure.walk"
        case .appleExerciseTime: return "figure.run"
        case .appleMoveTime: return "figure.walk.motion"
        case .appleStandTime: return "figure.stand"
        case .distanceWalkingRunning: return "figure.run"
        case .flightsClimbed: return "stairs"

        // MARK: - Fitness (Advanced)
        case .physicalEffort, .estimatedWorkoutEffortScore, .workoutEffortScore: return "gauge"

        // MARK: - Walking
        case .walkingSpeed: return "figure.walk"

        // MARK: - Walking (Advanced)
        case .walkingStepLength: return "ruler"
        case .sixMinuteWalkTestDistance: return "figure.walk.circle"
        case .stairAscentSpeed, .stairDescentSpeed: return "stairs"
        case .appleWalkingSteadiness, .walkingAsymmetryPercentage, .walkingDoubleSupportPercentage: return "figure.walk.motion"

        // MARK: - Running
        case .runningSpeed: return "figure.run"

        // MARK: - Running (Advanced)
        case .runningPower: return "bolt.fill"
        case .runningGroundContactTime: return "timer"
        case .runningStrideLength: return "ruler"
        case .runningVerticalOscillation: return "arrow.up.and.down"

        // MARK: - Cycling
        case .distanceCycling, .cyclingSpeed: return "bicycle"

        // MARK: - Cycling (Advanced)
        case .cyclingCadence: return "metronome"
        case .cyclingFunctionalThresholdPower, .cyclingPower: return "bolt.fill"

        // MARK: - Swimming
        case .distanceSwimming, .swimmingStrokeCount: return "figure.pool.swim"
        case .underwaterDepth: return "water.waves"

        // MARK: - Snow Sports
        case .crossCountrySkiingSpeed, .distanceCrossCountrySkiing: return "figure.skiing.crosscountry"
        case .distanceDownhillSnowSports: return "figure.skiing.downhill"

        // MARK: - Water sports
        case .distanceRowing, .rowingSpeed, .distancePaddleSports, .paddleSportsSpeed: return "figure.outdoor.rowing"

        // MARK: - Skate
        case .distanceSkatingSports: return "figure.skating"

        // MARK: - Environment
        case .headphoneAudioExposure: return "headphones"
        case .environmentalAudioExposure, .environmentalSoundReduction: return "ear"
        case .timeInDaylight: return "sun.max.fill"
        case .uvExposure: return "sun.max"

        // MARK: - Wheelchair
        case .distanceWheelchair, .pushCount: return "figure.roll"

        // MARK: - Sleep & breathing
        case .appleSleepingBreathingDisturbances: return "bed.double"

        // MARK: - Other
        case .electroDermalActivity: return "hand.raised"
        case .nikeFuel: return "bolt.circle"

        // MARK: - Not automatically collected
        case .atrialFibrillationBurden: return "waveform.path.ecg"
        case .peripheralPerfusionIndex: return "drop"
        case .bloodAlcoholContent, .numberOfAlcoholicBeverages: return "wineglass"
        case .insulinDelivery: return "syringe"
        case .numberOfTimesFallen: return "figure.fall"
        case .waterTemperature: return "thermometer"
        case .forcedExpiratoryVolume1, .forcedVitalCapacity, .peakExpiratoryFlowRate: return "lungs"
        case .inhalerUsage: return "pills"
        case .bloodGlucose: return "drop.fill"
        }
    }
    
    var imageColor: Color {
        return .blue
    }
    
}
