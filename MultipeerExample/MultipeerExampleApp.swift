//
//  MultipeerExampleApp.swift
//  MultipeerExample
//
//  Created by Daud on 30/05/24.
//

import SwiftUI
import SwiftData

@main
struct MultipeerExampleApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Plant.self
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
        }
        .modelContainer(sharedModelContainer)
    }
}
