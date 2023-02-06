//
//  ContentView.swift
//  third
//
//  Created by peppermint100 on 2023/02/06.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    
    var body: some View {
        Form {
            // $를 @State앞에 붙여서 two-way binding
            TextField("Enter your name", text: $name)
            // 여기는 값을 변환하는게 아니라 보여주기만 하므로 $를 붙이지 않음
            Text("Your name is \(name)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
