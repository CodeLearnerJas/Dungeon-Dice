//
//  ContentView.swift
//  Dungeon Dice
//
//  Created by GuitarLearnerJas on 16/9/2024.
//
import SwiftUI

struct ContentView: View {
    
    @State private var displayedDiceNo: Int = 0
    @State private var displayedNoOfDice: Int = 0
    @State private var resultMessage = ""
    @State private var players = ["Elle", "Mike", "Will", "Lucas", "Sam", "Dustin"]
    
    var body: some View {
        VStack {
            titleView
            
            Spacer()
            
            resultMessageView
            
            Spacer()
            
            buttonLayoutView(displayedNoOfDice: $displayedNoOfDice, displayedDiceNo: $displayedDiceNo)
            
        }
        .padding()

    }
}

extension ContentView {
    private var titleView: some View {
        Text("Dungeon Dice")
            .font(.largeTitle)
            .foregroundStyle(.red)
            .fontWeight(.black)
    }
    
    private var resultMessageView: some View {
        Text("You rolled a \(displayedDiceNo) on a \(displayedNoOfDice)- sided dice")
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .frame(height: 150)
    }
}


#Preview {
    ContentView()
}
