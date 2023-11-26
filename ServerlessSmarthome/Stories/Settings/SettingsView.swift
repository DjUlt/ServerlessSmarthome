//
//  SettingsView.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 24.11.2023.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var smartSystem: SmartSystem
    
    @State private var timeRemaining = UserDefaults.lastRefreshTimeout
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            Button("Force refresh system data") {
                timeRemaining = FileConstants.timerBlockSeconds
                // TODO: Implement
            }
            .disabled(timeRemaining <= 0)
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    UserDefaults.lastRefreshTimeout = timeRemaining
                }
            }
        }
        .navigationTitle(smartSystem.name)
    }
}

private enum FileConstants {
    static let timerBlockSeconds: Int = 10
}
