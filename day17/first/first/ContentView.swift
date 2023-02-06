//
//  ContentView.swift
//  first
//
//  Created by peppermint100 on 2023/02/06.
//

import SwiftUI

struct ContentView: View {
    // @State 값이 바뀌면 body를 재렌더링함
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    // 인풋의 focus 상태를 나타냄
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        // 강의 내용과 다르게 NavigationView가 있든 없든 iOS 16부터는 전부 셀렉션으로 작동함
        NavigationView {
            Form {
                Section {
                    // checkAmount는 Double이므로 text: argument label을 사용할 수 없음
                    TextField("Amount", value: $checkAmount,
                              format: .currency(
                                code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            // 디폴트 값이 4인 이유: numberOfPeople이 0, 1, 2 인덱스 즉 3번째 값을 뜻하게 된다
                            // 2부터 시작이므로 4번째 부터 세기 시작
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson,
                         format: .currency(
                            code: Locale.current.currencyCode ?? "USD"))
                    
                }
            }.navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        // done 버튼을 옆으로 밀어버리고 자리를 차지함
                        Spacer()
                        Button("Done") {
                            // onPress Done Button 인풋의 focus 상태를 false
                            amountIsFocused = false
                        }
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
