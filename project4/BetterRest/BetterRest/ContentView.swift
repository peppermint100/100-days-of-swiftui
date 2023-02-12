//
//  ContentView.swift
//  BetterRest
//
//  Created by peppermint100 on 2023/02/12.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    @State private var idealBedTime = defaultBedTime
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    static var defaultBedTime: Date{
        var components = DateComponents()
        components.hour = 21
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        DatePicker(
                            "Please enter a time",
                            selection: $wakeUp,
                            displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    } header: {
                        Text("When do you want to wake up?")
                            .font(.headline)
                    }
                    
                    Section {
                        Stepper(
                            "\(sleepAmount.formatted()) hours",
                            value: $sleepAmount,
                            in: 4...12, step: 0.25)
                    } header: {
                        Text("Desired amount of sleep")
                            .font(.headline)
                    }
                    
                    Section {
                        Picker("hello", selection: $coffeeAmount) {
                            ForEach(1...20, id: \.self) { number in
                                Text(String(number))
                            }
                        }.pickerStyle(.wheel)
                    } header: {
                        Text("Daily Coffee Intake")
                            .font(.headline)
                    }
                    
                }
                .navigationTitle("BetterRest")
                // omit을 사용하면 제외 할 수 있음
                Text("Your Ideal bed time is \(calculateBedTime().formatted(date: .omitted, time: .shortened))").font(.headline).fontWeight(.semibold)
            }
        }
    }
    
    func calculateBedTime() -> Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            return wakeUp - prediction.actualSleep
        } catch {
        }
        
        return Date.now
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
