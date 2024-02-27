//
//  ContentView.swift
//  Lifeline
//
//  Created by Vlad Z on 25/02/2024.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var activity: Activity<WidgetExtensionAttributes>? = nil
    @State private var birthday = Date()
    @SharedAppStorage("selectedDate") var storedBirthday = Date().timeIntervalSince1970
    @AppStorage("showOnLockScreen") private var showOnLockScreen = false
    
    let lifeExpectancy = 83
    
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
        let yearsLeft = Int(lifeExpectancy - Int(age))
        let weeksLeft = yearsLeft * 52
        let percentage = 100 * yearsLeft / lifeExpectancy
        return (yearsLeft, weeksLeft, percentage)
    }
    
    var body: some View {
        VStack {
            
                VStack {
                    Text("Lifeline")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                    LifelineView(birthday: birthday)
                    
                    Text("Your age is \(String(format: "%.2f", age)) years")
                        .bold()
                        .font(.title3)
                        .padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0))
                    DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .onChange(of: birthday) {
                            storedBirthday = birthday.timeIntervalSince1970
                        }
                    HStack {
                        Image(systemName: "lock")
                        Toggle("Show on lock screen", isOn: $showOnLockScreen)
                                        .onAppear {
                                            updateLockScreen()
                                        }
                    }.padding()
                    
                    
                }
            

        }.onAppear {
            birthday = Date(timeIntervalSince1970: storedBirthday)
        }.onChange(of: showOnLockScreen) { _, _ in
            updateLockScreen()
        }
    }
    
    func updateLockScreen() {
        if showOnLockScreen {
            startActivity()
        } else {
            stopActivity()
        }
    }
    
    func startActivity() {
        let attr = WidgetExtensionAttributes()
        let state = WidgetExtensionAttributes.ContentState()
        activity = try? Activity<WidgetExtensionAttributes>.request(attributes: attr, contentState: state)
    }
    
    func stopActivity() {
        let state = WidgetExtensionAttributes.ContentState()
        Task {
            await activity?.end(using: state, dismissalPolicy: .immediate)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
