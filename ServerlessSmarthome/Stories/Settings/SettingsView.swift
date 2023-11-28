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
                populateTestData()
            }
            .font(.title2)
            .fontWeight(.semibold)
            .disabled(timeRemaining > 0 || smartSystem.devices.isEmpty)
            .padding()
            .frame(maxWidth: .infinity)
            .buttonBorderShape(.roundedRectangle(radius: 8))
            .background(Color.white.opacity(0.9))
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    withAnimation {
                        timeRemaining -= 1
                    }
                    UserDefaults.lastRefreshTimeout = timeRemaining
                }
            }
        }
        .navigationTitle(smartSystem.name)
    }
    
    private func populateTestData() {
        for device in smartSystem.devices {
            let newData = DeviceData(value: String(format: "%.2f", Float.random(in: 0...100)), dateStamp: Date(), parentDevice: device)
            device.deviceData.append(newData)
            modelContext.insert(newData)
        }
    }
}

private enum FileConstants {
    static let timerBlockSeconds: Int = 10
}
