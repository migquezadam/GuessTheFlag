//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Miguel Quezada on 16-05-22.
//

import SwiftUI

struct FlagImage: View {
    
    let country:String

    var body: some View {
        
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
struct Title: ViewModifier {
    
    
    func body(content: Content) -> some View {
        content
        
            .font(.largeTitle)
            .foregroundColor(.primary)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}




struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var endGame = false
    @State private var qNumber = 1
    @State private var wrongMessage = ""
    
    
    
    
    var body: some View {
        
        
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                    .titleStyle()
                Spacer()
                Spacer()
                VStack (spacing: 15) {
                Text("Current question \(qNumber) / 8 ")
                        .font(.title).fontWeight(.bold)
                    
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        
                        Text(countries[correctAnswer])
                            
                            .font(.largeTitle.weight(.semibold))
                        
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            
                            
                        } label: {
                            FlagImage(country: countries[number])
                               
                            
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
                
            } .padding()
                

        }
        .alert("Well Done!", isPresented: $endGame) {
            Button("Reset", action: resetGame)
        } message: {
            Text("Your score was \(currentScore) Press reset to play again!")
            
            
        }
            
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(currentScore) \(wrongMessage)")
            
            
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
            

            
        } else {
            scoreTitle = "Wrong"
            wrongMessage = "Wrong! the correct answer was flag number  \(correctAnswer+1)"
            

           
        }
        
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        wrongMessage = ""
        qNumber += 1
        if qNumber > 8 {
            
            endGame = true
            qNumber = 8
        }
        
    }
    func resetGame(){
        qNumber = 0
        currentScore = 0
        askQuestion()
            
        }
            
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
