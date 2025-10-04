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
    
    // MARK: - Daily Series via StatisticsCollectionQuery (efficient)
    /// Fetch a daily series for a single metric between two dates (inclusive start, exclusive end)
    func dailySeries(for metric: HealthMetric, from start: Date, to end: Date) async throws -> [Date: Double] {
        let calendar = Calendar.current
        let startOfStart = calendar.startOfDay(for: start)
        let endExcl = end
        let predicate = HKQuery.predicateForSamples(withStart: startOfStart, end: endExcl, options: .strictStartDate)
        
        return try await withCheckedThrowingContinuation { cont in
            let interval = DateComponents(day: 1)
            let query = HKStatisticsCollectionQuery(
                quantityType: metric.quantityType,
                quantitySamplePredicate: predicate,
                options: metric.aggregation,
                anchorDate: startOfStart,
                intervalComponents: interval
            )
            
            query.initialResultsHandler = { _, results, error in
                if let error = error { return cont.resume(throwing: error) }
                var out: [Date: Double] = [:]
                results?.enumerateStatistics(from: startOfStart, to: endExcl) { stats, _ in
                    let day = calendar.startOfDay(for: stats.startDate)
                    let value: Double?
                    switch metric.aggregation {
                    case .cumulativeSum:
                        value = stats.sumQuantity()?.doubleValue(for: metric.unit)
                    case .discreteAverage:
                        value = stats.averageQuantity()?.doubleValue(for: metric.unit)
                    case .mostRecent:
                        value = stats.mostRecentQuantity()?.doubleValue(for: metric.unit)
                    default:
                        value = nil
                    }
                    if let v = value { out[day] = v }
                }
                cont.resume(returning: out)
            }
            
            healthKit.execute(query)
        }
    }
    
    // MARK: - Single-Day Convenience Aggregates
    /// Aggregate a metric between two dates (inclusive start, exclusive end)
    func dailyValue(for metric: HealthMetric, from start: Date, to end: Date) async throws -> Double {
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
                
                let value: Double
                switch metric.aggregation {
                case .cumulativeSum:
                    value = stats?.sumQuantity()?.doubleValue(for: metric.unit) ?? 0
                case .discreteAverage:
                    value = stats?.averageQuantity()?.doubleValue(for: metric.unit) ?? 0
                case .mostRecent:
                    value = stats?.mostRecentQuantity()?.doubleValue(for: metric.unit) ?? 0
                default:
                    value = -1
                }
                continuation.resume(returning: value)
            }
            healthKit.execute(healthQuery)
        }
    }
    
    /// Convenience: get the aggregate for a metric on a specific calendar day.
    /// Uses the user's current Calendar boundaries (startOfDay..<(startOfDay+1d)).
    func dailyValue(_ metric: HealthMetric, date: Date) async throws -> Double {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding: .day, value: 1, to: start)!
        return try await dailyValue(for: metric, from: start, to: end)
    }
    
    /// Fetch daily series for multiple metrics efficiently (runs queries in parallel)
    func dailyValues(for metrics: [HealthMetric], date: Date) async throws -> [HealthMetric: Double] {
        var responseMap: [HealthMetric: Double] = [:]
        try await withThrowingTaskGroup(of: (HealthMetric, Double).self) { group in
            for metric in metrics {
                group.addTask {
                    print("read \(metric.name)")
                    let value = try? await dailyValue(metric, date: date)
                    print("success \(metric.name)")
                    return (metric, value ?? 0)
                }
            }
            for try await (metric, value) in group {
                responseMap[metric] = value
            }
        }
        return responseMap
    }
}
