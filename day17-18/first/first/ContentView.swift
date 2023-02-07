
/*
 day 18
 1. Add a header to the third section, saying “Amount per person”
 2. Add another section showing the total amount for the check
 – i.e., the original amount plus tip value, without dividing by
 the number of people.
 3. Change the tip percentage picker to show a new screen rather
 than using a segmented control, and give it a wider range of options
 – everything from 0% to 100%. Tip: use the range 0..<101 for your
 range rather than a fixed array.
 */
import SwiftUI

struct ContentView: View {
    // @State 값이 바뀌면 body를 재렌더링함
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    // 인풋의 focus 상태를 나타냄
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = Array(1...100)
    
    // computed value
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmountIncludingTip: Double {
        if checkAmount <= 0 {
            return 0
        }
        
        return checkAmount + checkAmount * Double(tipPercentage) * 0.01
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
                    }.pickerStyle(.wheel)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson,
                         format: .currency(
                            code: Locale.current.currencyCode ?? "USD"))
                    
                } header: {
                    Text("Amount Per Person")
                }
                
                Section {
                    Text(totalAmountIncludingTip,
                         format: .currency(
                            code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total Amount(Including Tip)")
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
