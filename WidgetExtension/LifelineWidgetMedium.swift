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
    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, hh:mm"
            return formatter
        }()
    
    var body: some View {
        let stats = LifeStats.generate(from: birthday,
                                       lifeExpectancy: lifeExpectancy)
        HStack {
            Image("Lifeline")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .cornerRadius(9)
            Spacer()
        }.padding(0)
        MarkerProgressView(progress: stats.age / Double(lifeExpectancy))
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

