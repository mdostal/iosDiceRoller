//
//  DiceDrawerView.swift
//  DiceRollingApp
//
//  Created by Mathew Dostal on 12/4/24.
//
import SwiftUI

struct DiceDrawerView: View {
    @ObservedObject var diceSet: DiceSet
    @Binding var isOpen: Bool

    var body: some View {
        VStack {
            HStack {
                Text("Select Dice")
                    .font(.headline)
                Spacer()
                Button(action: { isOpen = false }) {
                    Image(systemName: "xmark")
                        .padding()
                }
            }
            .padding()

            List(DieType.allCases) { type in
                HStack {
                    Text(type.displayName)
                        .font(.headline)
                    Spacer()
                    Stepper(
                        "\(diceSet.selectedDice[type, default: 0])",
                        value: Binding(
                            get: { diceSet.selectedDice[type, default: 0] },
                            set: { diceSet.updateDiceCount(for: type, count: $0) }
                        ),
                        in: 0...20 // Maximum number of dice
                    )
                }
            }
            .listStyle(PlainListStyle())
            .frame(maxHeight: 300)

            Spacer()
        }
        .frame(width: 300)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}
