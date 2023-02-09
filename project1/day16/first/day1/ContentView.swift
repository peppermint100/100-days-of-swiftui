//
//  ContentView.swift
//  day1
//
//  Created by peppermint100 on 2023/02/06.
//

import SwiftUI

struct ContentView: View {
    // body is one thing that is required
    var body: some View {
        NavigationView {
            Form {
                // 비주얼적으로 나누어줌
                Section {
                    Text("Hello World!")
                }
                Section {
                    Text("Hello World!")
                }
                // 한 개의 폼 안에 10개 이상의 Text를 담을 수 없음
                // Group으로 각 10개 이하로 가지도록 나눠줌
                Group {
                    Text("Hello World!")
                    Text("Hello World!")
                    Text("Hello World!")
                    Text("Hello World!")
                    Text("Hello World!")
                    Text("Hello World!")
                }
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// only for debugging, testing, designing
// Canvas를 그려주는 역할
// virtual layout
// option + cmd + p for resume
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
