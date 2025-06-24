//
//  ContentView.swift
//  DungeonDice
//
//  Created by Miguel on 6/21/25.
//

import SwiftUI

struct ContentView: View {
    enum Dice: Int, CaseIterable, Identifiable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case oneHundred = 100
        
        var id: Int {   // We can remove the Return since it's 1 line/
            rawValue   // Each rawValue is unique, so it's a good ID.
        }
        
        var diceName: String {
            "\(rawValue)-sided"
        }
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    
    @State private var resultMessage = " "
    @State private var animationTrigger = false   // changed when animation occured
    @State private var isDoneAnimating = true
    
    
    
    var body: some View {
        VStack {
            Text("Dungeon Dice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.red)
            
            Spacer()
            
            Text(resultMessage)
                .font(.largeTitle)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
//                .scaleEffect(isDoneAnimating ? 1.0 : 0.6) // animate to 1.0
//                .opacity(isDoneAnimating ? 1.0 : 0.2)
                .rotation3DEffect(isDoneAnimating ? .degrees(360) : .degrees(0), axis: (x: 1, y: 0, z: 0))
                .frame(height: 150)
                .onChange(of: animationTrigger) {
                    isDoneAnimating = false
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                        isDoneAnimating = true
                    }
                }
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 102),alignment: .leading)]) {
                
                ForEach(Dice.allCases) { dice in
                    Button(dice.diceName) {
                        resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice"
                        animationTrigger.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
            }
            //            Group {
            //                ForEach(Dice.allCases, id: \.self) { dice in
            //                    Button("\(dice.rawValue)-sided") {
            //                        resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice"
            //                    }
            //
            //                }
            //                .buttonStyle(.borderedProminent)
            //                .tint(.red)
            //            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
