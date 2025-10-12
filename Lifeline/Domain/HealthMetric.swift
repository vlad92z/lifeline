//
//  HealthMetric.swift
//  Lifeline
//
//  Created by Vlad on 30/09/2025.
//

enum HealthMetric: String, Codable, CaseIterable, Identifiable {
    
    //MARK: - Body Measurements
    case height = "Height (cm)"
    case bodyMass = "Weight (kg)"
    case bodyMassIndex = "BMI"
    
    //MARK: - Body Measurements (Advanced)
    case bodyFat = "Body Fat (%)"
    case waistCircumference = "Waist Circumference (cm)"
    case leanBodyMass = "Lean Body Mass (kg)"
    
    // MARK: - Vitals
    case sleepingTemp = "Sleeping Wrist Temperature (°C)"
    case basalBodyTemperature = "Basal Body Temperature (°C)"
    case oxygenSaturation = "Oxygen Saturation (%)"
    case respiratoryRate = "Respiratory Rate (breaths/min)"
    
    // MARK: - Vitals (Advanced)
    case bloodPressureDiastolic = "Blood Pressure Diastolic (mmHg)"
    case bloodPressureSystolic = "Blood Pressure Systolic (mmHg)"
    case bodyTemperature = "Body Temperature (°C)"
    
    //MARK: - Energy
    case activeEnergyKcal = "Active Energy (kcal)"
    case basalEnergyKcal = "Basal Energy (kcal)"
    case dietaryEnergyKcal = "Consumed (kcal)"
    
    //MARK: Cardiovascular
    case restingHeartRate = "Resting HR"
    case vo2Max = "VO2 Max (mL/kg·min)"
    case heartRateVariabilitySDNN = "HRV SDNN (ms)"
    case maxHeartRate = "Max HR (bpm)"
    case heartRateRecoveryOneMinute = "HR Recovery 1min (bpm)"
    case walkingHeartRateAverage = "Walking HR Avg (bpm)"
    
    //MARK: - Nutrition
    case dietaryCarbohydrates = "Carbohydrates (g)"
    case dietaryFatTotal = "Total Fat (g)"
    case dietaryProtein = "Protein (g)"
    case dietarySugar = "Sugar (g)"
    case dietaryFiber = "Fiber (g)"
    case dietaryCholesterol = "Cholesterol (mg)"
    case dietaryFatMonounsaturated = "Monounsaturated Fat (g)"
    case dietaryFatPolyunsaturated = "Polyunsaturated Fat (g)"
    case dietaryFatSaturated = "Saturated Fat (g)"
    case dietarySodium = "Sodium (mg)"
    
    // MARK: - Nutrition (Advanced)
    case dietaryWater = "Water (ml)"
    case dietaryBiotin = "Biotin (mcg)"
    case dietaryCaffeine = "Caffeine (mg)"
    case dietaryCalcium = "Calcium (mg)"
    case dietaryChloride = "Chloride (mg)"
    case dietaryChromium = "Chromium (mcg)"
    case dietaryCopper = "Copper (mg)"
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
    case dietaryThiamin = "Thiamin (mg)"
    case dietaryVitaminA = "Vitamin A (mcg)"
    case dietaryVitaminB12 = "Vitamin B12 (mcg)"
    case dietaryVitaminB6 = "Vitamin B6 (mg)"
    case dietaryVitaminC = "Vitamin C (mg)"
    case dietaryVitaminD = "Vitamin D (mcg)"
    case dietaryVitaminE = "Vitamin E (mg)"
    case dietaryVitaminK = "Vitamin K (mcg)"
    case dietaryZinc = "Zinc (mg)"
    
    // MARK: - Fitness
    case stepCount = "Steps"
    case appleExerciseTime = "Exercise Time (min)"
    case appleMoveTime = "Move Time (min)"
    case appleStandTime = "Stand Time (min)"
    case distanceWalkingRunning = "Distance Walking+Running (km)"
    case flightsClimbed = "Flights Climbed"
    
    // MARK: - Fitness (Advanced)
    case physicalEffort = "Max Effort (kcal/hr·kg)"
    case estimatedWorkoutEffortScore = "Estimated Workout Effort Score"
    case workoutEffortScore = "Workout Effort Score"
    
    //MARK: Walking
    case walkingSpeed = "Walking Speed (m/s)"
    
    //MARK: Walking (Advanced)
    case walkingStepLength = "Walking Step Length (m)"
    case sixMinuteWalkTestDistance = "6-Min Walk Test Distance (m)"
    case stairAscentSpeed = "Stair Ascent Speed (m/s)"
    case stairDescentSpeed = "Stair Descent Speed (m/s)"
    case appleWalkingSteadiness = "Walking Steadiness"
    case walkingAsymmetryPercentage = "Walking Asymmetry (%)"
    case walkingDoubleSupportPercentage = "Walking Double Support (%)"
    
    //MARK: Running
    case runningSpeed = "Running Speed (m/s)"
    
    //MARK: Running (Advanced)
    case runningPower = "Running Power (W)"
    case runningGroundContactTime = "Running Ground Contact Time (ms)"
    case runningStrideLength = "Running Stride Length (m)"
    case runningVerticalOscillation = "Running Vertical Oscillation (cm)"
    
    //MARK: Cycling
    case distanceCycling = "Distance Cycling (km)"
    case cyclingSpeed = "Cycling Speed (m/s)"
    
    //MARK: Cycling (Advanced)
    case cyclingCadence = "Cycling Cadence (rpm)"
    case cyclingFunctionalThresholdPower = "Cycling FTP (W)"
    case cyclingPower = "Cycling Power (W)"
    
    //MARK: Swimming
    case distanceSwimming = "Distance Swimming (km)"
    case swimmingStrokeCount = "Swimming Strokes"
    case underwaterDepth = "Underwater Depth (m)"
    
    //MARK: Snow Sports
    case crossCountrySkiingSpeed = "XC Skiing Speed (m/s)"
    case distanceCrossCountrySkiing = "Distance XC Skiing (km)"
    case distanceDownhillSnowSports = "Distance Downhill Snow (km)"
    
    // MARK: Water sports
    case distanceRowing = "Distance Rowing (km)"
    case rowingSpeed = "Rowing Speed (m/s)"
    case distancePaddleSports = "Distance Paddle Sports (km)"
    case paddleSportsSpeed = "Paddle Sports Speed (m/s)"
    
    // MARK: Skate
    case distanceSkatingSports = "Distance Skating Sports (km)"
    
    // MARK: - Environment
    case headphoneAudioExposure = "Headphone Audio Exposure (dB)"
    case environmentalAudioExposure = "Environmental Audio Exposure (dB)"
    case environmentalSoundReduction = "Environmental Sound Reduction (dB)"
    case timeInDaylight = "Time in Daylight (seconds)"
    case uvExposure = "UV Exposure"
    
    //MARK: Wheelchair
    case distanceWheelchair = "Distance Wheelchair (km)"
    case pushCount = "Push Count"
    
    case appleSleepingBreathingDisturbances = "Sleeping Breathing Disturbances"
    
    
    //MARK: Other
    case electroDermalActivity = "EDA"
    case nikeFuel = "Nike Fuel"
    
    //MARK: Not automatically collected
    case atrialFibrillationBurden = "AFib Burden (%)"
    case peripheralPerfusionIndex = "Peripheral Perfusion Index"
    case bloodAlcoholContent = "Blood Alcohol Content (%)"
    case insulinDelivery = "Insulin Delivery (IU)"
    case numberOfAlcoholicBeverages = "Alcoholic Beverages (count)"
    case numberOfTimesFallen = "Number of Times Fallen"
    case waterTemperature = "Water Temperature (°C)"
    case forcedExpiratoryVolume1 = "FEV1 (L)"
    case forcedVitalCapacity = "FVC (L)"
    case inhalerUsage = "Inhaler Usage (count)"
    case peakExpiratoryFlowRate = "Peak Expiratory Flow (L/min)"
    case bloodGlucose = "Blood Glucose"
    
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
