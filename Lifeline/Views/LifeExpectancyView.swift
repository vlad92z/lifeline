//
//  ContentView.swift
//  Lifeline
//
//  Created by Vlad Z on 25/02/2024.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct LifeExpectancyView: View {
    @State private var birthday = Date()
    @State private var now = Date()
    @State private var lifeExpectancy = 83
    @SharedAppStorage("lifeExpectancy") var storedLifeExpectancy = 83
    @SharedAppStorage("selectedDate") var storedBirthday = Date().timeIntervalSince1970
    
    var age: Double {
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
        let yearsLeft = Int(lifeExpectancy - Int(age))
        let weeksLeft = yearsLeft * 52
        let percentage = 100 * yearsLeft / lifeExpectancy
        return (yearsLeft, weeksLeft, percentage)
    }
    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, hh:mm"
            return formatter
        }()
    
    var body: some View {
        let expectancy = max(lifeExpectancy, 1)
        VStack {
            
            VStack {
                Text("Lifeline")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                
                
                LifelineView(birthday: birthday, lifeExpectancy: expectancy)
                
                HStack {
                    Text("Age: ")
                        .font(.title3)
                    Text("\(String(format: "%.2f", age)) years")
                        .bold()
                        .font(.title3)
                }.padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0))
                
                    
                DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .onChange(of: birthday) {
                        storedBirthday = birthday.timeIntervalSince1970
                        WidgetCenter.shared.invalidateConfigurationRecommendations()
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                VStack(spacing: 0) {
                            HStack {
                                Image(systemName: "heart")
                                Text("Life Expectancy")
                                Spacer()
                                TextField("83", value: $lifeExpectancy, formatter: NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                    .keyboardType(.numberPad)
                                    .frame(width: 60)
                                    .toolbar {
                                        ToolbarItem(placement: .keyboard) {
                                            Button("Done") {
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            }
                                        }
                                    }
                                    .padding(0)
                                    .onChange(of: lifeExpectancy) { _, _ in
                                        storedLifeExpectancy = max(lifeExpectancy, 1)
                                        WidgetCenter.shared.invalidateConfigurationRecommendations()
                                        WidgetCenter.shared.reloadAllTimelines()
                                    }
                            }
                        }
                        .padding()
            }.padding()
        }.onAppear {
            let foreground = UIApplication.willEnterForegroundNotification
            NotificationCenter.default.addObserver(forName: foreground,
                                                   object: nil,
                                                   queue: .main) { _ in
                self.now = Date()
            }
            birthday = Date(timeIntervalSince1970: storedBirthday)
            lifeExpectancy = storedLifeExpectancy
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LifeExpectancyView()
    }
}
