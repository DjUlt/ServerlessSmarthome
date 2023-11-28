//
//  ServerlessSmarthomeApp.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 18.10.2023.
//

import SwiftUI
import SwiftData

@main
struct ServerlessSmarthomeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SmartSystem.self,
            SmartSystemGroup.self,
            SmartSystemDevice.self,
            DeviceData.self,
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
                .preferredColorScheme(.light)
        }
        .modelContainer(sharedModelContainer)
    }
}
