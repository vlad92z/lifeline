//
//  HealthKitReader.swift
//  Lifeline
//
//  Created by Vlad on 28/09/2025.
//
import HealthKit

struct HealthKitReader {
    let healthKit = HKHealthStore()
    
    var isAvailable: Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
    
    func requestAuthorization() {
        guard isAvailable else {
            return //todo should throw
        }
        let types = HealthMetric.allCases.map { $0.quantityType }
        let readTypes: Set<HKObjectType> = Set(types)
        
        healthKit.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            if success {
                print("Success")
            } else {
                print("\(String(describing: error))")
            }
        }
    }
    
    // MARK: - Convenience Aggregates
    /// Aggregate a metric between two dates (inclusive start, exclusive end)
    func value(for metric: HealthMetric, from start: Date, to end: Date) async throws -> Double? {
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        
        return try await withCheckedThrowingContinuation { continuation in
            let healthQuery = HKStatisticsQuery(
                quantityType: metric.quantityType,
                quantitySamplePredicate: predicate,
                options: metric.aggregation
            ) { _, stats, error in
                
                if let error = error {
                    return continuation.resume(throwing: error)
                }
                
                let value: Double?
                switch metric.aggregation {
                case .cumulativeSum:
                    value = stats?.sumQuantity()?.doubleValue(for: metric.unit)
                case .discreteAverage:
                    value = stats?.averageQuantity()?.doubleValue(for: metric.unit)
                case .mostRecent:
                    value = stats?.mostRecentQuantity()?.doubleValue(for: metric.unit)
                default:
                    value = nil
                }
                continuation.resume(returning: value)
            }
            healthKit.execute(healthQuery)
        }
    }
    
    /// Convenience: get the aggregate for a metric on a specific calendar day.
    /// Uses the user's current Calendar boundaries (startOfDay..<(startOfDay+1d)).
    func dailyValue(_ metric: HealthMetric, date: Date) async throws -> Double? {
        let start = date
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        return try await value(for: metric, from: start, to: end)
    }
    
    /// Fetch daily series for multiple metrics efficiently (runs queries in parallel)
    func dailyValues(for metrics: [HealthMetric], date: Date) async throws -> [HealthMetric: Double?] {
        var responseMap: [HealthMetric: Double?] = [:]
        try await withThrowingTaskGroup(of: (HealthMetric, Double?).self) { group in
            for metric in metrics {
                group.addTask {
                    let value = try? await dailyValue(metric, date: date)
                    return (metric, value)
                }
            }
            for try await (metric, value) in group {
                responseMap[metric] = value
            }
        }
        return responseMap
    }
}
