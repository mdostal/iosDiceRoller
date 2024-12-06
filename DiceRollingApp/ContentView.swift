//
//  ContentView.swift
//  DiceRollingApp
//
//  Created by Mathew Dostal on 12/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        MainBoardView()

    }
}

#Preview {

    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
