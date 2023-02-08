//
//  ContentView.swift
//  day19
//
//  Created by peppermint100 on 2023/02/07.
//

import SwiftUI


struct ContentView: View {
    
    @State private var sourceTemperature: Double = 0.0
    
    @State private var sourceTemperatureType: TemperatureType = .celsius
    @State private var targetTemperatureType: TemperatureType = .celsius
    
    @FocusState private var sourceTemperatureFocus: Bool
    
    var targetTemperature: Double {
        let targetTemp = sourceTemperatureType.convert(
            sourceTemperature,
            to: targetTemperatureType)
        
        return targetTemp
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Source", value: $sourceTemperature, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($sourceTemperatureFocus)
                } header: {
                    Text("Your Current Temperature Here Mate!")
                }
                Section {
                    Picker("Source Temperture Type", selection: $sourceTemperatureType) {
                        ForEach (TemperatureType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                }
                Section {
                    Picker("Target Temperture Type", selection: $targetTemperatureType) {
                        ForEach (TemperatureType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Your Destination Temperature Type Here!")
                }
                Section {
                    Text(targetTemperature, format: .number)
                } header: {
                    Text("Calculated Temperature Here!")
                }
            }
            .navigationTitle("Temperature Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
