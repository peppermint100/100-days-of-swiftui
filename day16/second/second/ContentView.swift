//
//  ContentView.swift
//  second
//
//  Created by peppermint100 on 2023/02/06.
//

import SwiftUI

struct ContentView: View {
    /*
    struct는 변할 수 없는 구조체이므로 tapCount의 값을
    mutate하고 싶다면 @State를 추가해야 함
    struct 내부가 아닌 다른 곳에 값을 저장하도록 함
    그렇다면 왜 그냥 class를 사용하지 않을까
    이유는 Swift는 퍼포먼스가 중요해서 간단하고 가벼운 구조인 struct가 더 어울리기 때문
    자주 뷰를 생성하고 지우는데 class는 성능상 좋지 않음
    */
    
    // private를 붙여줌으로서 로컬에서만 사용하는 상태임을 표시
    // react의 useState
    @State private var tapCount = 0
    
    var body: some View {
        Button("Tap Count: \(tapCount)") {
            tapCount+=1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
