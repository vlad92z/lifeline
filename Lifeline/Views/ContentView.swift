//
//  ContentView.swift
//  Lifeline
//
//  Created by Vlad Z on 25/02/2024.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct ContentView: View {
    @State private var activity: Activity<WidgetExtensionAttributes>? = nil
    @State private var birthday = Date()
    @State private var lifeExpectancy = 83
    @AppStorage("showOnLockScreen") private var showOnLockScreen = false
    @SharedAppStorage("lifeExpectancy") var storedLifeExpectancy = 83
    @SharedAppStorage("selectedDate") var storedBirthday = Date().timeIntervalSince1970
    
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
                    .padding(.bottom, 40)
                LifelineView(birthday: birthday, lifeExpectancy: lifeExpectancy)
                
                Text("Your age is \(String(format: "%.2f", age)) years")
                    .bold()
                    .font(.title3)
                    .padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0))
                DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .onChange(of: birthday) {
                        storedBirthday = birthday.timeIntervalSince1970
                        WidgetCenter.shared.invalidateConfigurationRecommendations()
                        WidgetCenter.shared.reloadAllTimelines()
                        reloadLockScreen()
                    }
                VStack(spacing: 0) {
                            HStack {
                                Image(systemName: "heart")
                                Text("Life Expectancy")
                                Spacer()
                                TextField("83", value: $lifeExpectancy, formatter: NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .keyboardType(.numberPad)
                                    .frame(width: 100)
                                    .toolbar {
                                        ToolbarItem(placement: .keyboard) {
                                            Button("Done") {
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            }
                                        }
                                    }
                                    .onChange(of: lifeExpectancy) { _, _ in
                                        storedLifeExpectancy = lifeExpectancy
                                        WidgetCenter.shared.invalidateConfigurationRecommendations()
                                        WidgetCenter.shared.reloadAllTimelines()
                                        reloadLockScreen()
                                    }
                            }
                            
                            HStack {
                                Image(systemName: "lock")
                                Toggle("Show on lock screen", isOn: $showOnLockScreen)
                                    .onAppear {
                                        setLockScreen()
                                    }
                            }
                        }
                        .padding()
            }.padding()
        }.onAppear {
            birthday = Date(timeIntervalSince1970: storedBirthday)
            lifeExpectancy = storedLifeExpectancy
        }.onChange(of: showOnLockScreen) { _, _ in
            setLockScreen()
        }
    }
    
    func setLockScreen() {
        if showOnLockScreen {
            startActivity()
        } else {
            stopActivity()
        }
    }
    
    func reloadLockScreen() {
        if showOnLockScreen {
            stopActivity()
            startActivity()
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
