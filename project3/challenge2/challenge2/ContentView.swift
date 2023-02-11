//
//  ContentView.swift
//  challenge2
//
//  Created by peppermint100 on 2023/02/11.
//

import SwiftUI


struct FlagImage: View {
    var image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
            .fontWeight(.semibold)
    }
}

extension Text { // View로 익스텐딩 해도 되지만 Text로 익스텐딩 해도 된다.
    func largeBlueFontStyle() -> some View {
        modifier(LargeBlueFont())
    }
}

struct ContentView: View {
    
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland",
        "Italy", "Nigeria", "Poland", "Russia",
        "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    
    @State private var indexOfFlagHasTapped = 0
    
    @State private var tryCount = 0

    var body: some View {
        ZStack {
            // ZStack은 가장 먼저 나온게 가장 아래에 깔림 즉 이 RadialGradient는 백그라운드 컬러처럼 작용
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), // 0.3까지 색깔 채움
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3) // 0.3부터 바로 red 색상 즉 그래디언트가 없음
                ],
                center: .top, // center 즉 원의 중앙이 .top 즉 위쪽에 있음
                startRadius: 200,
                endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag!")
                    .font(.largeTitle.bold()).foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        // foregroundStyle은 .primary와 .secondary로 light, dark모드에 맞는 색상을 출력
                        // 일반 색상을 넣으면(.red, .blue) 주변 색상에 영향을 받아 조금 보정된 색상을 보여줌
                        Text("Select the flag of").foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .largeBlueFontStyle()
//                            .modifier(LargeBlueFont())
//                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach (0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(image: countries[number])
                        }
                    }
                } // Vstack 카드
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial) // 백그라운드 컬러가 투과되어 보임
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score \(score)").foregroundColor(.white).font(.title.bold())
                Spacer()
            }.padding(20)
        }.alert(isPresented: $showingScore, content: {
            // 만약 내부 로직이 간단하다면 강의보다 이 문법을 사용하는게 좋을 듯
            if tryCount > 7 {
                return Alert(
                    title: Text(scoreTitle),
                    message: scoreTitle == "Correct"
                        ? Text("Your Final Score is \(score)")
                        : Text("Your Final Score is \(score), That's a flag of \(countries[indexOfFlagHasTapped])"),
                    dismissButton: .cancel(Text("Finish and Reset Score")) {
                        score = 0
                        tryCount = 0
                        askQuestion()
                    })
            } else {
                return Alert(
                    title: Text(scoreTitle),
                    message: scoreTitle == "Correct"
                        ? Text("Your Score is \(score)")
                        : Text("Your Score is \(score), That's a flag of \(countries[indexOfFlagHasTapped])"),
                    dismissButton: .cancel(Text("Continue")) { askQuestion() }
                )
            }
        })
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score+=1
        } else {
            scoreTitle = "Wrong"
            score-=1
            indexOfFlagHasTapped = number
        }
        tryCount+=1
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
