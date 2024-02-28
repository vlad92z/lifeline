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
    let lifeExpectancy: Int
    
    var body: some View {
        let stats = LifeStats.generate(from: birthday,
                                       lifeExpectancy: lifeExpectancy)
        
        VStack {
            HStack {
                Image("Lifeline")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Spacer()
                Text("Weeks").frame(width: 70, height: 40, alignment: .center).font(.title3)
                Spacer()
            }.padding(0)
            
            HStack {
                Text("Spent").font(.callout)
                Spacer()
                Text("\(stats.weeksSpent)").bold()
            }
            HStack {
                Text("Left").font(.callout)
                Spacer()
                Text("\(stats.weeksLeft)").bold()
            }
            MarkerProgressView(progress: stats.age / Double(lifeExpectancy)).padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
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
            LifelineWidgetSmall(birthday: pastDate, lifeExpectancy: 83)
        }
        .containerBackground(.fill.tertiary, for: .widget)
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

