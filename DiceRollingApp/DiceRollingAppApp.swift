//
//  DiceRollingAppApp.swift
//  DiceRollingApp
//
//  Created by Mathew Dostal on 12/4/24.
//

import SwiftUI
import SwiftData

@main
struct DiceRollingAppApp: App {
    @StateObject private var appState = AppState() // Use @StateObject for the root instance

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)

        }
        .modelContainer(sharedModelContainer)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState()) // Inject the environment object
    }
}
