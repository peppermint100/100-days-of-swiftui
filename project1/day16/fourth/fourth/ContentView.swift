//
//  ContentView.swift
//  fourth
//
//  Created by peppermint100 on 2023/02/06.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    // SwiftUI가 배열 내 요소를 구분하기 위해 id가 필요함
                    // React Native의 FlatList의 id와 같은 개념
                    ForEach(students, id: \.self) {
                        Text($0)
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
