//
//  DiceModel.swift
//  DiceRollingApp
//
//  Created by Mathew Dostal on 12/4/24.
//

import Foundation

enum DieType: Int, CaseIterable, Identifiable {
    case /* Add D2 D2 = 2,*/ D4 = 4, D6 = 6, D8 = 8, D10 = 10, D12 = 12, D20 = 20
    
    var id: Int { rawValue }
    var displayName: String { "D\(rawValue)" }
}

struct Die {
    let type: DieType
    let result: Int
}

class DiceSet: ObservableObject {
    @Published var selectedDice: [DieType: Int] = [:] // Dice type to count
    @Published var results: [Die] = []
    
    func rollDice() {
        results = selectedDice.flatMap { type, count in
            (1...count).map { _ in
                Die(type: type, result: Int.random(in: 1...type.rawValue))
            }
        }
    }
    
    func updateDiceCount(for type: DieType, count: Int) {
        if count > 0 {
            selectedDice[type] = count
        } else {
            selectedDice.removeValue(forKey: type)
        }
    }
}
