//
//  ButtonLayoutView.swift
//  Dungeon Dice
//
//  Created by GuitarLearnerJas on 18/9/2024.
//

import SwiftUI

struct buttonLayoutView: View {
    struct DeviceWidthPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
        
        typealias Value = CGFloat
    }
    @State private var buttonsLeftOver = 0 // # of buttons in a less than full row
    @Binding var displayedNoOfDice: Int
    @Binding var displayedDiceNo: Int
    
    let horizontalPadding:CGFloat = 16
    let spacing: CGFloat = 0
    let buttonWidth: CGFloat = 105
    
    enum Dice: Int, CaseIterable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        func roll() -> Int {
            switch self {
            case .four:
                return Int.random(in: 1...rawValue)
            case .six:
                return Int.random(in: 1...rawValue)
            case .eight:
                return Int.random(in: 1...rawValue)
            case .ten:
                return Int.random(in: 1...rawValue)
            case .twelve:
                return Int.random(in: 1...rawValue)
            case .twenty:
                return Int.random(in: 1...rawValue)
            case .hundred:
                return Int.random(in: 1...rawValue)
            }
        }
    }

    var body: some View {
            VStack{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: buttonWidth),spacing: spacing)]) {
                    ForEach(Dice.allCases.dropLast(buttonsLeftOver), id: \.self) { dice in
                        Button ("\(dice.rawValue)-Sided") {
                            displayedDiceNo = dice.roll()
                            displayedNoOfDice = dice.rawValue
                        }
                        .frame(width: buttonWidth)
                    }
                    //For all the buttons
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .tint(.red)
                }
                HStack(alignment: .center) {
                    ForEach(Dice.allCases.suffix(buttonsLeftOver), id: \.self) { dice in
                        Button ("\(dice.rawValue)-Sided") {
                            displayedDiceNo = dice.roll()
                            displayedNoOfDice = dice.rawValue
                        }
                        .frame(width: buttonWidth)
                    }
                    //For all the buttons
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .tint(.red)
                }
            }
        
            .overlay {
                GeometryReader {geo in
                    Color.clear
                        .preference(key: DeviceWidthPreferenceKey.self, value: geo.size.width)
                }
        }
            .onPreferenceChange(DeviceWidthPreferenceKey.self) { deviceWidth in
                arrangeGridItem(deviceWidth: deviceWidth)
            }
    }

    func arrangeGridItem(deviceWidth: CGFloat) {
        var avaliableScreenWidth = deviceWidth - horizontalPadding * 2 //padding on both sides
        if Dice.allCases.count > 1 {
            avaliableScreenWidth += spacing
        }
        //calculate numOfButtonsPerRow as an Int
        let numberOfButtonsPerRow = Int(avaliableScreenWidth) / Int(buttonWidth + spacing)
        buttonsLeftOver = Dice.allCases.count % numberOfButtonsPerRow
    }
}

#Preview {
    buttonLayoutView(displayedNoOfDice: .constant(Int()), displayedDiceNo: .constant(Int()))
}
