//
//  HealthMetricCategory.swift
//  Lifeline
//
//  Created by Vlad on 04/10/2025.
//
struct HealthMetricCategory: Identifiable {
    let name: String
    let metrics: [HealthMetric]
    let advanced: [HealthMetric]
    
    var id: String {
        return name
    }
    
    static let all: [HealthMetricCategory] = [
        HealthMetricCategory(
            name: "Body Measurements",
            metrics: [.height, .bodyMass, .bodyMassIndex],
            advanced: [.bodyFat, .waistCircumference, .leanBodyMass]
        ),
        HealthMetricCategory(
            name: "Vitals",
            metrics: [.sleepingTemp, .basalBodyTemperature, .oxygenSaturation, .respiratoryRate],
            advanced: [.bloodPressureDiastolic, .bloodPressureSystolic, .bodyTemperature]
        ),
        HealthMetricCategory(
            name: "Energy",
            metrics: [.activeEnergyKcal, .basalEnergyKcal, .dietaryEnergyKcal],
            advanced: []
        ),
        HealthMetricCategory(
            name: "Heart",
            metrics: [.restingHeartRate, .vo2Max, .heartRateVariabilitySDNN, .heartRate, .heartRateRecoveryOneMinute, .walkingHeartRateAverage],
            advanced: []
        ),
        HealthMetricCategory(
            name: "Nutrition",
            metrics: [.dietaryCarbohydrates, .dietaryFatTotal, .dietaryProtein, .dietarySugar, .dietaryFiber, .dietaryCholesterol, .dietaryFatMonounsaturated, .dietaryFatPolyunsaturated, .dietaryFatSaturated, .dietarySodium],
            advanced: [.dietaryWater, .dietaryBiotin, .dietaryCaffeine, .dietaryCalcium, .dietaryChloride, .dietaryChromium, .dietaryCopper, .dietaryFolate, .dietaryIodine, .dietaryIron, .dietaryMagnesium, .dietaryManganese, .dietaryMolybdenum, .dietaryNiacin, .dietaryPantothenicAcid, .dietaryPhosphorus, .dietaryPotassium, .dietaryRiboflavin, .dietarySelenium, .dietaryThiamin, .dietaryVitaminA, .dietaryVitaminB12, .dietaryVitaminB6, .dietaryVitaminC, .dietaryVitaminD, .dietaryVitaminE, .dietaryVitaminK, .dietaryZinc]
        ),
        HealthMetricCategory(
            name: "Fitness",
            metrics: [.stepCount, .appleExerciseTime, .appleMoveTime, .appleStandTime, .distanceWalkingRunning, .flightsClimbed],
            advanced: [.physicalEffort, .estimatedWorkoutEffortScore, .workoutEffortScore]
        ),
        HealthMetricCategory(
            name: "Walking",
            metrics: [.walkingSpeed],
            advanced: [.walkingStepLength, .sixMinuteWalkTestDistance, .stairAscentSpeed, .stairDescentSpeed, .appleWalkingSteadiness, .walkingAsymmetryPercentage, .walkingDoubleSupportPercentage]
        ),
        HealthMetricCategory(
            name: "Running",
            metrics: [.runningSpeed],
            advanced: [.runningPower, .runningGroundContactTime, .runningStrideLength, .runningVerticalOscillation]
        ),
        HealthMetricCategory(
            name: "Cycling",
            metrics: [.distanceCycling, .cyclingSpeed],
            advanced: [.cyclingCadence, .cyclingFunctionalThresholdPower, .cyclingPower]
        ),
        HealthMetricCategory(
            name: "Swimming",
            metrics: [.distanceSwimming, .swimmingStrokeCount, .underwaterDepth],
            advanced: []
        ),
        HealthMetricCategory(
            name: "Snow Sports",
            metrics: [.crossCountrySkiingSpeed, .distanceCrossCountrySkiing, .distanceDownhillSnowSports],
            advanced: []
        ),
        HealthMetricCategory(
            name: "Water sports",
            metrics: [.distanceRowing, .rowingSpeed, .distancePaddleSports, .paddleSportsSpeed],
            advanced: []
        ),
        HealthMetricCategory(
            name: "Skate",
            metrics: [.distanceSkatingSports],
            advanced: []
        ),
        HealthMetricCategory(
            name: "Environment",
            metrics: [.headphoneAudioExposure, .environmentalAudioExposure, .environmentalSoundReduction, .timeInDaylight, .uvExposure],
            advanced: []
        ),
        HealthMetricCategory(
            name: "Wheelchair",
            metrics: [.distanceWheelchair, .pushCount],
            advanced: []
        )
    ]
}
