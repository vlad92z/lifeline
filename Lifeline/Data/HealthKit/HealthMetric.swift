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

    // MARK: - Body Measurements
    case waistCircumference = "Waist Circumference (cm)"

    // MARK: - Activity & Fitness
    case appleExerciseTime = "Exercise Time (min)"
    case appleMoveTime = "Move Time (min)"
    case appleStandTime = "Stand Time (min)"
    case crossCountrySkiingSpeed = "XC Skiing Speed (m/s)"
    case cyclingCadence = "Cycling Cadence (rpm)"
    case cyclingFunctionalThresholdPower = "Cycling FTP (W)"
    case cyclingPower = "Cycling Power (W)"
    case cyclingSpeed = "Cycling Speed (m/s)"
    case distanceCrossCountrySkiing = "Distance XC Skiing (km)"
    case distanceCycling = "Distance Cycling (km)"
    case distanceDownhillSnowSports = "Distance Downhill Snow (km)"
    case distancePaddleSports = "Distance Paddle Sports (km)"
    case distanceRowing = "Distance Rowing (km)"
    case distanceSkatingSports = "Distance Skating Sports (km)"
    case distanceSwimming = "Distance Swimming (km)"
    case distanceWalkingRunning = "Distance Walking+Running (km)"
    case distanceWheelchair = "Distance Wheelchair (km)"
    case estimatedWorkoutEffortScore = "Estimated Workout Effort Score"
    case flightsClimbed = "Flights Climbed"
    case nikeFuel = "Nike Fuel"
    case paddleSportsSpeed = "Paddle Sports Speed (m/s)"
    case physicalEffort = "Physical Effort"
    case pushCount = "Push Count"
    case rowingSpeed = "Rowing Speed (m/s)"
    case runningPower = "Running Power (W)"
    case runningSpeed = "Running Speed (m/s)"
    case stepCount = "Steps"
    case swimmingStrokeCount = "Swimming Strokes"
    case underwaterDepth = "Underwater Depth (m)"
    case workoutEffortScore = "Workout Effort Score"

    // MARK: - Audio Exposure
    case environmentalAudioExposure = "Environmental Audio Exposure (dB)"
    case environmentalSoundReduction = "Environmental Sound Reduction (dB)"
    case headphoneAudioExposure = "Headphone Audio Exposure (dB)"

    // MARK: - Cardio
    case atrialFibrillationBurden = "AFib Burden (%)"
    case heartRate = "Heart Rate (bpm)"
    case heartRateRecoveryOneMinute = "HR Recovery 1min (bpm)"
    case heartRateVariabilitySDNN = "HRV SDNN (ms)"
    case peripheralPerfusionIndex = "Peripheral Perfusion Index"
    case vo2Max = "VO2 Max (mL/kg·min)"
    case walkingHeartRateAverage = "Walking HR Avg (bpm)"

    // MARK: - Mobility & Gait
    case appleWalkingSteadiness = "Walking Steadiness"
    case runningGroundContactTime = "Running Ground Contact Time (ms)"
    case runningStrideLength = "Running Stride Length (m)"
    case runningVerticalOscillation = "Running Vertical Oscillation (cm)"
    case sixMinuteWalkTestDistance = "6-Min Walk Test Distance (m)"
    case stairAscentSpeed = "Stair Ascent Speed (m/s)"
    case stairDescentSpeed = "Stair Descent Speed (m/s)"
    case walkingAsymmetryPercentage = "Walking Asymmetry (%)"
    case walkingDoubleSupportPercentage = "Walking Double Support (%)"
    case walkingSpeed = "Walking Speed (m/s)"
    case walkingStepLength = "Walking Step Length (m)"

    // MARK: - Nutrition
    case dietaryBiotin = "Biotin (mcg)"
    case dietaryCaffeine = "Caffeine (mg)"
    case dietaryCalcium = "Calcium (mg)"
    case dietaryCarbohydrates = "Carbohydrates (g)"
    case dietaryChloride = "Chloride (mg)"
    case dietaryCholesterol = "Cholesterol (mg)"
    case dietaryChromium = "Chromium (mcg)"
    case dietaryCopper = "Copper (mg)"
    case dietaryFatMonounsaturated = "Monounsaturated Fat (g)"
    case dietaryFatPolyunsaturated = "Polyunsaturated Fat (g)"
    case dietaryFatSaturated = "Saturated Fat (g)"
    case dietaryFatTotal = "Total Fat (g)"
    case dietaryFiber = "Fiber (g)"
    case dietaryFolate = "Folate (mcg)"
    case dietaryIodine = "Iodine (mcg)"
    case dietaryIron = "Iron (mg)"
    case dietaryMagnesium = "Magnesium (mg)"
    case dietaryManganese = "Manganese (mg)"
    case dietaryMolybdenum = "Molybdenum (mcg)"
    case dietaryNiacin = "Niacin (mg)"
    case dietaryPantothenicAcid = "Pantothenic Acid (mg)"
    case dietaryPhosphorus = "Phosphorus (mg)"
    case dietaryPotassium = "Potassium (mg)"
    case dietaryRiboflavin = "Riboflavin (mg)"
    case dietarySelenium = "Selenium (mcg)"
    case dietarySodium = "Sodium (mg)"
    case dietaryThiamin = "Thiamin (mg)"
    case dietaryVitaminA = "Vitamin A (mcg)"
    case dietaryVitaminB12 = "Vitamin B12 (mcg)"
    case dietaryVitaminB6 = "Vitamin B6 (mg)"
    case dietaryVitaminC = "Vitamin C (mg)"
    case dietaryVitaminD = "Vitamin D (mcg)"
    case dietaryVitaminE = "Vitamin E (mg)"
    case dietaryVitaminK = "Vitamin K (mcg)"
    case dietaryWater = "Water (ml)"
    case dietaryZinc = "Zinc (mg)"

    // MARK: - Other Health Metrics
    case bloodAlcoholContent = "Blood Alcohol Content (%)"
    case bloodPressureDiastolic = "Blood Pressure Diastolic (mmHg)"
    case bloodPressureSystolic = "Blood Pressure Systolic (mmHg)"
    case insulinDelivery = "Insulin Delivery (IU)"
    case numberOfAlcoholicBeverages = "Alcoholic Beverages (count)"
    case numberOfTimesFallen = "Number of Times Fallen"
    case timeInDaylight = "Time in Daylight (min)"
    case uvExposure = "UV Exposure"
    case waterTemperature = "Water Temperature (°C)"
    case basalBodyTemperature = "Basal Body Temperature (°C)"
    case appleSleepingBreathingDisturbances = "Sleeping Breathing Disturbances"
    case forcedExpiratoryVolume1 = "FEV1 (L)"
    case forcedVitalCapacity = "FVC (L)"
    case inhalerUsage = "Inhaler Usage (count)"
    case oxygenSaturation = "Oxygen Saturation (%)"
    case peakExpiratoryFlowRate = "Peak Expiratory Flow (L/min)"
    case respiratoryRate = "Respiratory Rate (breaths/min)"
    case bloodGlucose = "Blood Glucose"
    case bodyTemperature = "Body Temperature (°C)"
    
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
