//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kevin Becker on 6/19/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var animationAmount = 0.0
    @State private var animationOpacity = 1.0
    @State private var animationScale: CGFloat = 1
 
    
  // Day 24 - Challenge 3
    struct FlagImage: View {
        var image: String
        
        var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            
                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                    .shadow(color: .black, radius: 2)
        }
    }

    var body: some View {
        ZStack {
            //Color.blue.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        withAnimation {
                            self.flagTapped(number)
                        }
                                                
                    }) {
                        FlagImage(image: self.countries[number])
                            .rotation3DEffect(
                                .degrees(number == correctAnswer ? animationAmount : 0.0),
                                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                            )
                            .opacity(number == correctAnswer ? 1.0 : animationOpacity)
                            .scaleEffect(number == correctAnswer ? 1.0 : animationScale)
                        
                            

                    }
                   
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
        
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            animationAmount += 360
            animationOpacity = 0.25
        } else {
            scoreTitle = "Wrong! That's \(countries[number])"
            animationScale = 0.5
            
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        animationOpacity = 1
        animationScale = 1.0
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
