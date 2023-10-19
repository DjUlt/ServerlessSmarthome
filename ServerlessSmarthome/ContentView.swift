//
//  ContentView.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 18.10.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationView {
            SystemSelectView()
                .modelContext(modelContext)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: SmartSystem.self, inMemory: true)
}
