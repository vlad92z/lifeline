//
//  HealthKitAuthorizer.swift
//  Lifeline
//
//  Created by Vlad on 28/09/2025.
//
import HealthKit

final class HealthKitAuthorizer {
  private let store = HKHealthStore()

  func requestReadAuthorization() async throws {
    let qty = [
      HKObjectType.quantityType(forIdentifier: .stepCount)!,
      HKObjectType.quantityType(forIdentifier: .heartRate)!,
      HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
    ]
    let cat = [
      HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
    ]
    let readTypes: Set<HKObjectType> = Set(qty + cat + [HKObjectType.workoutType()])

    try await store.requestAuthorization(toShare: [], read: readTypes)
  }

  func isHealthDataAvailable() -> Bool { HKHealthStore.isHealthDataAvailable() }
}
