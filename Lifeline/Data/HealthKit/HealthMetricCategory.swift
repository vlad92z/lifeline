//
//  HealthMetricCategory.swift
//  Lifeline
//
//  Created by Vlad on 04/10/2025.
//
struct HealthMetricCategory {
    let name: String
    let metrics: [HealthMetric]
    let advanced: [HealthMetric]
    
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
        ]
}
