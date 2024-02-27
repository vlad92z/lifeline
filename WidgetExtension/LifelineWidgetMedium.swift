//
//  LifelineWidgetMedium.swift
//  WidgetExtensionExtension
//
//  Created by Vlad Z on 26/02/2024.
//

import SwiftUI
import WidgetKit

struct LifelineWidgetMedium: View {
    
    let birthday: Date
    let lifeExpectancy: Int
    
    var body: some View {
        let stats = LifeStats.generate(from: birthday,
                                       lifeExpectancy: lifeExpectancy)
        HStack {
            Text("Progress: \(stats.progress)%")
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
        }
        
        LifelineProgressView(remaining: stats.age / Double(lifeExpectancy))
            .frame(height: 4)
        HStack {
            Text("Days spent")
            Text("\(stats.daysSpent)").bold()
            Spacer()
            Text("Days left")
            Text("\(stats.daysLeft)").bold()
        }
        Spacer()
        HStack {
            Text("\(stats.yearsLeft) years or " +
                 "\(stats.weeksLeft) weeks left").italic()
        }
    }
}

struct LifelineWidgetMediumPreviews: PreviewProvider {

    static var pastDate: Date {
        let now = Date()
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = -25
        
        let maybeDate = calendar.date(byAdding: dateComponents, to: now)
        return maybeDate ?? Date.distantPast
    }
    
  static var previews: some View {
      
    VStack {
        LifelineWidgetMedium(birthday: pastDate, lifeExpectancy: 83)
    }
    .containerBackground(.fill.tertiary, for: .widget)
    .previewContext(WidgetPreviewContext(family: .systemMedium))
  }
}

