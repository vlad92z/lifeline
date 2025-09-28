//
//  HealthKitManager.swift
//  Lifeline
//
//  Created by Vlad on 28/09/2025.
//
import Foundation
import HealthKit
import WidgetKit

class HealthKitManager: ObservableObject {
  static let shared = HealthKitManager()

  var healthStore = HKHealthStore()

  var stepCountToday: Int = 0
  var thisWeekSteps: [Int: Int] = [1: 0, 2: 0, 3: 0,
                                   4: 0, 5: 0, 6: 0, 7: 0]
}
