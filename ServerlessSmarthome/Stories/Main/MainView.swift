//
//  MainView.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 15.11.2023.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var smartSystem: SmartSystem
    
    var body: some View {
        TabView {
            NavigationView {
                GroupsListView(smartSystem: smartSystem)
            }
            .modelContext(modelContext)
                .tabItem {
                    Label("Groups", systemImage: "rectangle.3.group.fill")
                        .foregroundStyle(smartSystem.themeColor.color)
                }
            NavigationView {
                DevicesListView(smartSystem: smartSystem)
            }
                .modelContext(modelContext)
                .tabItem {
                    Label("Devices", systemImage: "externaldrive.fill.badge.wifi")
                        .foregroundStyle(smartSystem.themeColor.color)
                }
            NavigationView {
                SettingsView(smartSystem: smartSystem)
            }
                .modelContext(modelContext)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                        .foregroundStyle(smartSystem.themeColor.color)
                }
        }
        .onAppear {
            UserDefaults.lastSeenSystem = smartSystem.keyHash.uuidString
        }
    }
}
