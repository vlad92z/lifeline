//
//  HealthKitReader.swift
//  Lifeline
//
//  Created by Vlad on 28/09/2025.
//
import HealthKit

struct HealthMetricReader {
    let healthKit = HKHealthStore()
    
    var isAvailable: Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
    
    func requestAuthorization() async {
        guard isAvailable else {
            return
        }
        await withCheckedContinuation { continuation in
            let types = HealthMetric.allCases.map { $0.quantityType }
            let readTypes: Set<HKObjectType> = Set(types)
            healthKit.requestAuthorization(toShare: nil, read: readTypes) { success, error in
                continuation.resume()
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
                case .discreteMax:
                    value = stats?.maximumQuantity()?.doubleValue(for: metric.unit)
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
    
    /// Check if HealthKit has any data for a given HealthMetric.
    /// Returns true if at least one sample exists for the metric's quantity type.
    func hasData(for metric: HealthMetric) async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            let sampleType = metric.quantityType
            // No date predicate: search across all available time
            let predicate: NSPredicate? = nil
            let query = HKSampleQuery(sampleType: sampleType,
                                      predicate: predicate,
                                      limit: 1,
                                      sortDescriptors: nil) { _, samples, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                let hasAny = (samples?.isEmpty == false)
                continuation.resume(returning: hasAny)
            }
            healthKit.execute(query)
        }
    }
    
    func getAvailableMetrics() async -> Set<HealthMetric.ID> {
        guard isAvailable else { return [] }
        let metrics = Array(HealthMetric.allCases)
        var available = Set<HealthMetric.ID>()

        await withTaskGroup(of: (HealthMetric.ID, Bool).self) { group in
            for metric in metrics {
                group.addTask {
                    let has: Bool = (try? await hasData(for: metric)) ?? false
                    return (metric.id, has)
                }
            }
            for await (id, has) in group {
                if has { available.insert(id) }
            }
        }
        return available
    }
}
