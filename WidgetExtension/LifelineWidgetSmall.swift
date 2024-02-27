//
//  LifelineWidgetSmall.swift
//  WidgetExtensionExtension
//
//  Created by Vlad Z on 26/02/2024.
//

import SwiftUI
import WidgetKit

struct LifelineWidgetSmall: View {
    
    let birthday: Date
    
    var body: some View {
        let stats = LifeStats.generate(from: birthday)
        VStack {
            Text("Progress: \(stats.progress)%").bold()
            LifelineProgressView(remaining: stats.age / Double(LifeStats.lifeExpectancy)).frame(height: 4)
            Spacer()
            
            Text("Remaining").bold()
            HStack {
                Text("Weeks:")
                Text("\(stats.weeksLeft)").bold()
            }
            HStack {
                Text("Days:")
                Text("\(stats.daysLeft)").bold()
            }
        }
    }
}

struct WidgetViewPreviews: PreviewProvider {

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
        LifelineWidgetSmall(birthday: pastDate)
    }
    .containerBackground(.fill.tertiary, for: .widget)
    .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}

