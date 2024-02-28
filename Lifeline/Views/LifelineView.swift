//
//  LifelineView.swift
//  Lifeline
//
//  Created by Vlad Z on 25/02/2024.
//

import SwiftUI

struct LifelineView: View {
    
    let birthday: Date
    let lifeExpectancy: Int
    
    var body: some View {
        let stats = LifeStats.generate(from: birthday,
                                       lifeExpectancy: lifeExpectancy)
        MarkerProgressView(progress: stats.age / Double(lifeExpectancy))
        HStack {
            Text("Days spent")
            Text("\(stats.daysSpent)").bold()
            Spacer()
            Text("Days left")
            Text("\(stats.daysLeft)").bold()
        }
        HStack {
            Text("Weeks spent")
            Text("\(stats.weeksSpent)").bold()
            Spacer()
            Text("Weeks left")
            Text("\(stats.weeksLeft)").bold()
        }
    }
}

#Preview {
    let now = Date()
    let calendar = Calendar.current
    var dateComponents = DateComponents()
    dateComponents.year = -25

    let before = calendar.date(byAdding: dateComponents, to: now)
    return LifelineView(birthday: before ?? Date.distantPast, lifeExpectancy: 100)
}
