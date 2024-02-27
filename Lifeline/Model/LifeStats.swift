//
//  LifeStats.swift
//  Lifeline
//
//  Created by Vlad Z on 26/02/2024.
//

import Foundation

class LifeStats {
    
    typealias Stats = (
        yearsLeft: Int,
        weeksLeft: Int,
        daysLeft: Int,
        progress: Int,
        daysSpent: Int,
        age: Double
    )
    
    private init() {}
    
    static let lifeExpectancy = 83
    
    private static func getAge(from birthday: Date) -> Double {
        let now = Date()
        let ageComponents = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: birthday,
            to: now
        )
        
        let years = Double(ageComponents.year ?? 0)
        let months = Double(ageComponents.month ?? 0) / 12
        let days = Double(ageComponents.day ?? 0) / 365.25
        
        return years + months + days
    }
    
    static func generate(from birthday: Date) -> Stats {
        let age = getAge(from: birthday)
        
        let yearsLeft = Double(lifeExpectancy) - age
        let daysSpent = Int(age * 365.25)
        let daysLeft = Int(yearsLeft * 365.25)
        
        let ageInt = Int(age)
        let yearsLeftInt = Int(yearsLeft)
        let weeksLeft = Int(yearsLeft * 52)
        let percentage = 100 * ageInt / lifeExpectancy
        return (yearsLeftInt, weeksLeft, daysLeft, percentage, daysSpent, age)
    }
}
