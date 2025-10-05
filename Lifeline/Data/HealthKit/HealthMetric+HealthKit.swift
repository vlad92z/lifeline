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
        // Existing basics
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

        // Body Measurements
        case .waistCircumference: .waistCircumference

        // Activity & Fitness
        case .appleExerciseTime: .appleExerciseTime
        case .appleMoveTime: .appleMoveTime
        case .appleStandTime: .appleStandTime
        case .crossCountrySkiingSpeed: .crossCountrySkiingSpeed
        case .cyclingCadence: .cyclingCadence
        case .cyclingFunctionalThresholdPower: .cyclingFunctionalThresholdPower
        case .cyclingPower: .cyclingPower
        case .cyclingSpeed: .cyclingSpeed
        case .distanceCrossCountrySkiing: .distanceCrossCountrySkiing
        case .distanceCycling: .distanceCycling
        case .distanceDownhillSnowSports: .distanceDownhillSnowSports
        case .distancePaddleSports: .distancePaddleSports
        case .distanceRowing: .distanceRowing
        case .distanceSkatingSports: .distanceSkatingSports
        case .distanceSwimming: .distanceSwimming
        case .distanceWalkingRunning: .distanceWalkingRunning
        case .distanceWheelchair: .distanceWheelchair
        case .estimatedWorkoutEffortScore: .estimatedWorkoutEffortScore
        case .flightsClimbed: .flightsClimbed
        case .nikeFuel: .nikeFuel
        case .paddleSportsSpeed: .paddleSportsSpeed
        case .physicalEffort: .physicalEffort
        case .pushCount: .pushCount
        case .rowingSpeed: .rowingSpeed
        case .runningPower: .runningPower
        case .runningSpeed: .runningSpeed
        case .stepCount: .stepCount
        case .swimmingStrokeCount: .swimmingStrokeCount
        case .underwaterDepth: .underwaterDepth
        case .workoutEffortScore: .workoutEffortScore

        // Audio Exposure
        case .environmentalAudioExposure: .environmentalAudioExposure
        case .environmentalSoundReduction: .environmentalSoundReduction
        case .headphoneAudioExposure: .headphoneAudioExposure

        // Cardio
        case .atrialFibrillationBurden: .atrialFibrillationBurden
        case .maxHeartRate: .heartRate
        case .heartRateRecoveryOneMinute: .heartRateRecoveryOneMinute
        case .heartRateVariabilitySDNN: .heartRateVariabilitySDNN
        case .peripheralPerfusionIndex: .peripheralPerfusionIndex
        case .vo2Max: .vo2Max
        case .walkingHeartRateAverage: .walkingHeartRateAverage

        // Mobility & Gait
        case .appleWalkingSteadiness: .appleWalkingSteadiness
        case .runningGroundContactTime: .runningGroundContactTime
        case .runningStrideLength: .runningStrideLength
        case .runningVerticalOscillation: .runningVerticalOscillation
        case .sixMinuteWalkTestDistance: .sixMinuteWalkTestDistance
        case .stairAscentSpeed: .stairAscentSpeed
        case .stairDescentSpeed: .stairDescentSpeed
        case .walkingAsymmetryPercentage: .walkingAsymmetryPercentage
        case .walkingDoubleSupportPercentage: .walkingDoubleSupportPercentage
        case .walkingSpeed: .walkingSpeed
        case .walkingStepLength: .walkingStepLength

        // Nutrition
        case .dietaryBiotin: .dietaryBiotin
        case .dietaryCaffeine: .dietaryCaffeine
        case .dietaryCalcium: .dietaryCalcium
        case .dietaryCarbohydrates: .dietaryCarbohydrates
        case .dietaryChloride: .dietaryChloride
        case .dietaryCholesterol: .dietaryCholesterol
        case .dietaryChromium: .dietaryChromium
        case .dietaryCopper: .dietaryCopper
        case .dietaryFatMonounsaturated: .dietaryFatMonounsaturated
        case .dietaryFatPolyunsaturated: .dietaryFatPolyunsaturated
        case .dietaryFatSaturated: .dietaryFatSaturated
        case .dietaryFatTotal: .dietaryFatTotal
        case .dietaryFiber: .dietaryFiber
        case .dietaryFolate: .dietaryFolate
        case .dietaryIodine: .dietaryIodine
        case .dietaryIron: .dietaryIron
        case .dietaryMagnesium: .dietaryMagnesium
        case .dietaryManganese: .dietaryManganese
        case .dietaryMolybdenum: .dietaryMolybdenum
        case .dietaryNiacin: .dietaryNiacin
        case .dietaryPantothenicAcid: .dietaryPantothenicAcid
        case .dietaryPhosphorus: .dietaryPhosphorus
        case .dietaryPotassium: .dietaryPotassium
        case .dietaryRiboflavin: .dietaryRiboflavin
        case .dietarySelenium: .dietarySelenium
        case .dietarySodium: .dietarySodium
        case .dietaryThiamin: .dietaryThiamin
        case .dietaryVitaminA: .dietaryVitaminA
        case .dietaryVitaminB12: .dietaryVitaminB12
        case .dietaryVitaminB6: .dietaryVitaminB6
        case .dietaryVitaminC: .dietaryVitaminC
        case .dietaryVitaminD: .dietaryVitaminD
        case .dietaryVitaminE: .dietaryVitaminE
        case .dietaryVitaminK: .dietaryVitaminK
        case .dietaryWater: .dietaryWater
        case .dietaryZinc: .dietaryZinc

        // Other Health Metrics
        case .bloodAlcoholContent: .bloodAlcoholContent
        case .bloodPressureDiastolic: .bloodPressureDiastolic
        case .bloodPressureSystolic: .bloodPressureSystolic
        case .insulinDelivery: .insulinDelivery
        case .numberOfAlcoholicBeverages: .numberOfAlcoholicBeverages
        case .numberOfTimesFallen: .numberOfTimesFallen
        case .timeInDaylight: .timeInDaylight
        case .uvExposure: .uvExposure
        case .waterTemperature: .waterTemperature
        case .basalBodyTemperature: .basalBodyTemperature
        case .appleSleepingBreathingDisturbances: .appleSleepingBreathingDisturbances
        case .forcedExpiratoryVolume1: .forcedExpiratoryVolume1
        case .forcedVitalCapacity: .forcedVitalCapacity
        case .inhalerUsage: .inhalerUsage
        case .oxygenSaturation: .oxygenSaturation
        case .peakExpiratoryFlowRate: .peakExpiratoryFlowRate
        case .respiratoryRate: .respiratoryRate
        case .bloodGlucose: .bloodGlucose
        case .bodyTemperature: .bodyTemperature
        }
    }
    
    var quantityType: HKQuantityType {
        return HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!
    }
    
    var unit: HKUnit {
        switch self {
        // Temperatures
        case .sleepingTemp, .waterTemperature, .basalBodyTemperature, .bodyTemperature:
            return .degreeCelsius()

        // Energy
        case .activeEnergyKcal, .basalEnergyKcal, .dietaryEnergyKcal:
            return .kilocalorie()

        // Dietary macros (grams)
        case .dietaryProtein, .dietarySugar, .dietaryCarbohydrates, .dietaryFatMonounsaturated, .dietaryFatPolyunsaturated, .dietaryFatSaturated, .dietaryFatTotal, .dietaryFiber:
            return .gram()

        // Dietary milligrams
        case .dietaryCaffeine, .dietaryCalcium, .dietaryChloride, .dietaryCholesterol, .dietaryCopper, .dietaryIron, .dietaryMagnesium, .dietaryManganese, .dietaryNiacin, .dietaryPantothenicAcid, .dietaryPhosphorus, .dietaryPotassium, .dietaryRiboflavin, .dietarySodium, .dietaryVitaminB6, .dietaryVitaminC, .dietaryVitaminE, .dietaryZinc:
            return .gramUnit(with: .milli)

        // Dietary micrograms
        case .dietaryBiotin, .dietaryChromium, .dietaryFolate, .dietaryIodine, .dietaryMolybdenum, .dietarySelenium, .dietaryThiamin, .dietaryVitaminA, .dietaryVitaminB12, .dietaryVitaminD, .dietaryVitaminK:
            return .gramUnit(with: .micro)

        // Dietary water (mL)
        case .dietaryWater:
            return .literUnit(with: .milli)

        // Heart rate (beats per minute)
        case .restingHeartRate, .maxHeartRate, .walkingHeartRateAverage, .heartRateRecoveryOneMinute:
            return .count().unitDivided(by: .minute())

        // Body composition
        case .bodyMass, .leanBodyMass:
            return .gramUnit(with: .kilo)
        case .bodyFat, .atrialFibrillationBurden, .walkingAsymmetryPercentage, .walkingDoubleSupportPercentage, .oxygenSaturation, .peripheralPerfusionIndex:
            return .percent()
        case .bodyMassIndex:
            return .count()
        case .waistCircumference:
            return .meterUnit(with: .centi)
        case .height:
            return .meterUnit(with: .centi)

        // EDA
        case .electroDermalActivity:
            return .siemenUnit(with: .micro)

        // Distances (kilometers)
        case .distanceCrossCountrySkiing, .distanceCycling, .distanceDownhillSnowSports, .distancePaddleSports, .distanceRowing, .distanceSkatingSports, .distanceSwimming, .distanceWalkingRunning, .distanceWheelchair:
            return .meterUnit(with: .kilo)

        // Speeds (meters/second)
        case .crossCountrySkiingSpeed, .cyclingSpeed, .paddleSportsSpeed, .rowingSpeed, .runningSpeed, .stairAscentSpeed, .stairDescentSpeed, .walkingSpeed:
            return .meter().unitDivided(by: .second())

        // Power (Watts)
        case .cyclingPower, .cyclingFunctionalThresholdPower, .runningPower:
            return .watt()

        // Cadence (revolutions per minute)
        case .cyclingCadence:
            return .count().unitDivided(by: .minute())

        // Counts
        case .stepCount, .swimmingStrokeCount, .flightsClimbed, .pushCount, .numberOfTimesFallen, .numberOfAlcoholicBeverages, .nikeFuel:
            return .count()

        // Depth (meters)
        case .underwaterDepth:
            return .meter()

        // Time quantities (minutes)
        case .appleExerciseTime, .appleMoveTime, .appleStandTime:
            return .minute()
            
        case .timeInDaylight:
            return .second()

        // Audio exposure (A-weighted dB)
        case .environmentalAudioExposure, .environmentalSoundReduction, .headphoneAudioExposure:
            return .decibelAWeightedSoundPressureLevel()

        // Cardio and fitness
        case .heartRateVariabilitySDNN:
            return .secondUnit(with: .milli)
        case .vo2Max:
            return .literUnit(with: .milli).unitDivided(by: .gramUnit(with: .kilo)).unitDivided(by: .minute())

        // Gait & mobility
        case .appleWalkingSteadiness:
            return .percent()
        case .runningGroundContactTime:
            return .secondUnit(with: .milli)
        case .runningStrideLength:
            return .meter()
        case .runningVerticalOscillation:
            return .meterUnit(with: .centi)
        case .sixMinuteWalkTestDistance:
            return .meter()
        case .walkingStepLength:
            return .meter()

        // Other health metrics
        case .bloodAlcoholContent:
            return .percent()
        case .bloodPressureDiastolic, .bloodPressureSystolic:
            return .millimeterOfMercury()
        case .insulinDelivery:
            return .internationalUnit()
        case .uvExposure:
            return .count()
        case .appleSleepingBreathingDisturbances:
            return .count()
        case .forcedExpiratoryVolume1, .forcedVitalCapacity:
            return .liter()
        case .inhalerUsage:
            return .count()
        case .peakExpiratoryFlowRate:
            return .liter().unitDivided(by: .minute())
        case .respiratoryRate:
            return .count().unitDivided(by: .minute())
        case .bloodGlucose:
            return .moleUnit(with: .milli, molarMass: HKUnitMolarMassBloodGlucose).unitDivided(by: .liter())

        // Workout effort
        case .estimatedWorkoutEffortScore, .workoutEffortScore:
            return .appleEffortScore()
        case .physicalEffort:
            return HKUnit(from: "kcal/hr·kg")
        }
    }
    
    var aggregation: HKStatisticsOptions {
        switch self {
        // Temperatures
        case .sleepingTemp, .waterTemperature, .basalBodyTemperature, .bodyTemperature:
            return .discreteAverage

        // Energy & nutrition totals
        case .activeEnergyKcal, .basalEnergyKcal, .dietaryEnergyKcal,
             .dietaryProtein, .dietarySugar, .dietaryCarbohydrates,
             .dietaryFatMonounsaturated, .dietaryFatPolyunsaturated, .dietaryFatSaturated, .dietaryFatTotal,
             .dietaryFiber, .dietaryCaffeine, .dietaryCalcium, .dietaryChloride, .dietaryCholesterol,
             .dietaryCopper, .dietaryIron, .dietaryMagnesium, .dietaryManganese, .dietaryNiacin,
             .dietaryPantothenicAcid, .dietaryPhosphorus, .dietaryPotassium, .dietaryRiboflavin,
             .dietarySodium, .dietaryVitaminB6, .dietaryVitaminC, .dietaryVitaminE, .dietaryZinc,
             .dietaryBiotin, .dietaryChromium, .dietaryFolate, .dietaryIodine, .dietaryMolybdenum,
             .dietarySelenium, .dietaryThiamin, .dietaryVitaminA, .dietaryVitaminB12, .dietaryVitaminD,
             .dietaryVitaminK, .dietaryWater:
            return .cumulativeSum

        // Body composition & measurements (snapshot)
        case .bodyMass, .leanBodyMass, .bodyFat, .bodyMassIndex, .height, .waistCircumference:
            return .mostRecent

        // Distance totals
        case .insulinDelivery, .flightsClimbed, .pushCount, .numberOfTimesFallen, .numberOfAlcoholicBeverages, .appleExerciseTime, .appleMoveTime, .appleStandTime, .timeInDaylight, .swimmingStrokeCount, .distanceCrossCountrySkiing, .distanceCycling, .distanceDownhillSnowSports,
             .distancePaddleSports, .distanceRowing, .distanceSkatingSports,
             .distanceSwimming, .distanceWalkingRunning, .distanceWheelchair, .stepCount:
            return .cumulativeSum

        // Speeds & rates (averages over the day)
        case .cyclingPower, .runningPower, .cyclingCadence, .crossCountrySkiingSpeed, .cyclingSpeed, .paddleSportsSpeed, .rowingSpeed,
             .runningSpeed, .stairAscentSpeed, .stairDescentSpeed, .walkingSpeed,
             .underwaterDepth, .appleSleepingBreathingDisturbances:
            return .discreteAverage
            
        case .cyclingFunctionalThresholdPower:
            return .mostRecent

        // Audio exposure (typical daily average)
        case .environmentalAudioExposure, .environmentalSoundReduction, .headphoneAudioExposure:
            return .discreteAverage

        // Cardio metrics
        case .restingHeartRate, .walkingHeartRateAverage:
            return .discreteAverage
        case .maxHeartRate:
            return .discreteMax
        case .heartRateRecoveryOneMinute:
            return .mostRecent
        case .heartRateVariabilitySDNN:
            return .discreteAverage
        case .atrialFibrillationBurden:
            return .discreteAverage
        case .peripheralPerfusionIndex:
            return .discreteAverage
        case .vo2Max:
            return .mostRecent

        // Mobility & gait
        case .appleWalkingSteadiness:
            return .mostRecent
        case .runningGroundContactTime, .runningStrideLength, .runningVerticalOscillation,
             .walkingAsymmetryPercentage, .walkingDoubleSupportPercentage, .walkingStepLength:
            return .discreteAverage
        case .sixMinuteWalkTestDistance:
            return .mostRecent

        // Respiratory & related
        case .oxygenSaturation, .respiratoryRate:
            return .discreteAverage
        case .forcedExpiratoryVolume1, .forcedVitalCapacity, .peakExpiratoryFlowRate:
            return .mostRecent
        case .inhalerUsage:
            return .cumulativeSum

        // Other
        case .bloodAlcoholContent:
            return .mostRecent
        case .bloodPressureDiastolic, .bloodPressureSystolic:
            return .mostRecent
        case .uvExposure:
            return .discreteAverage
        case .estimatedWorkoutEffortScore, .workoutEffortScore, .physicalEffort:
            return .discreteMax
        case .electroDermalActivity:
            return .discreteAverage
        case .nikeFuel:
            return .cumulativeSum
        case .bloodGlucose:
            return .discreteAverage
        }
    }
}

