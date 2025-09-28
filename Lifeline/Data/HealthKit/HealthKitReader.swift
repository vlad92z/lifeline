//
//  HealthKitReader.swift
//  Lifeline
//
//  Created by Vlad on 28/09/2025.
//
import HealthKit

struct HealthKitReader {
  let store = HKHealthStore()

    var isAvailable: Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
    
    func requestAuthorization() {
        guard isAvailable else {
            return
        }
        let quantityTypes: [HKQuantityTypeIdentifier] = [
            .stepCount,
            .activeEnergyBurned,
            .dietaryEnergyConsumed,
            .heartRate
        ]
        
        let readTypes: Set<HKObjectType> = Set(
            quantityTypes.compactMap { HKObjectType.quantityType(forIdentifier: $0) }
        )


        store.requestAuthorization(toShare: nil, read: readTypes) {
          success, error in
          if success {
            print("Success")
          } else {
            print("\(String(describing: error))")
          }
        }
      }
    
  func todaySteps() async throws -> Double {
    guard let type = HKObjectType.quantityType(forIdentifier: .stepCount) else { return 0 }
    let calendar = Calendar.current
    let startOfDay = calendar.startOfDay(for: Date())
    let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)

    return try await withCheckedThrowingContinuation { cont in
      let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, stats, error in
        if let error = error { return cont.resume(throwing: error) }
        let sum = stats?.sumQuantity()?.doubleValue(for: .count()) ?? 0
        cont.resume(returning: sum)
      }
      store.execute(query)
    }
  }
  /// Fetch total calories consumed between two dates.
  /// - Parameters:
  ///   - start: Start of the interval (inclusive)
  ///   - end: End of the interval (exclusive)
  /// - Returns: Total kilocalories (kcal) as a Double
  func caloriesConsumed(from start: Date, to end: Date) async throws -> Double {
    guard let type = HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed) else { return 0 }

    let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)

    return try await withCheckedThrowingContinuation { cont in
      let query = HKStatisticsQuery(quantityType: type,
                                    quantitySamplePredicate: predicate,
                                    options: .cumulativeSum) { _, stats, error in
        if let error = error {
          return cont.resume(throwing: error)
        }
        let unit = HKUnit.kilocalorie()
        let total = stats?.sumQuantity()?.doubleValue(for: unit) ?? 0
        cont.resume(returning: total)
      }
      store.execute(query)
    }
  }
}
