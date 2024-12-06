//
//  DefaultState.swift
//  DiceRollingApp
//
//  Created by Mathew Dostal on 12/5/24.
//

import Foundation
enum DiceRenderMode {
    case flat
    case threeD
}

class AppState: ObservableObject {
    @Published var renderMode: DiceRenderMode = .threeD
}
