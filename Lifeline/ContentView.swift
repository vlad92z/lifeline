//
//  ContentView.swift
//  Lifeline
//
//  Created by Vlad Z on 25/02/2024.
//

import SwiftUI

struct ContentView: View {

    @State private var birthday = Date()
    let lifeExpectency = 83
    var age: Double {
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
    
    var timeLeft: (yearsLeft: Int, weeksLeft: Int, percentageLeft: Int) {
        let yearsLeft = Int(lifeExpectency - Int(age))
        let weeksLeft = yearsLeft * 52
        let percentage = 100 * yearsLeft / lifeExpectency
        return (yearsLeft, weeksLeft, percentage)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("Lifeline")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                    let timeLeft = timeLeft
                    Text("You have \(timeLeft.yearsLeft) years, " +
                         "\(timeLeft.weeksLeft) weeks or " +
                         "\(timeLeft.percentageLeft)% left")
                    ProgressView(remaining: age / Double(lifeExpectency))
                        .frame(height: 4)
                    Divider()

                    Text("Your birthday").padding(.top, 40)
                    DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()

                    Text("Your age is \(String(format: "%.2f", age)) years")
                        .padding()
                }
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
