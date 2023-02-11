//
//  ContentView.swift
//  milestone1
//
//  Created by peppermint100 on 2023/02/11.
//

import SwiftUI

struct BigWhiteText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white).font(.largeTitle).textCase(.uppercase)
    }
}

extension Text {
    func bigWhite() -> some View{
        modifier(BigWhiteText())
    }
}

struct RSPCardView: View {
    var rspType: RSPType
    var onPress: (_ rspType: RSPType) -> Void
    
    var body: some View {
        Button(action: {
            onPress(rspType)
        }) {
            Text(rspType.rawValue)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.title2)
                .frame(width: 110, height: 110)
        }
        .frame(width: 110, height: 110)
        .background(Color.orange)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct ContentView: View {
    @State private var rspTypeSource = RSPType.random()
    @State private var win = true
    @State private var tryCount = 0
    @State private var score = 0
    
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            Color.cyan
        }.ignoresSafeArea()
        .overlay(
            // Vstack을 overlay로 꺼냄으로서 ignoreSafeArea도 무시된다.
            VStack (spacing: 20) {
                Spacer()
                Text(rspTypeSource.rawValue).bigWhite()
                Text(win ? "beats" : "loses to")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                HStack (spacing: 20){
                    ForEach(RSPType.allCases, id: \.self) { rsp in
                        RSPCardView(rspType: rsp
                                    , onPress: {(rsp: RSPType) -> Void in
                            onPressRspCard(rsp)
                        }
                        )
                    }
                }
                Spacer()
                Text("Your Score is \(score)").bigWhite()
                Spacer()
            }
        )
        .alert(isPresented: $showAlert, content: {
            Alert(
                title: Text("Game Over!"),
                message: Text("Your Final Score is \(score)"),
                dismissButton: .cancel(Text("continue")) {
                    score = 0
                    tryCount = 0
                }
            )
        })
    }
    
    func onPressRspCard(_ rspType: RSPType) {
        if rspTypeSource.beats(rspType) == win {
            score+=1
        } else {
            score-=1
        }
        tryCount+=1
        rspTypeSource = RSPType.random()
        win = Bool.random()
        
        showAlert = tryCount >= 10
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
