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
                    .background(
                        ZStack {
                            Image(uiImage: .init(data: smartSystem.backgroundImageData) ?? .init())
                                .resizable()
                                .scaledToFill()
                                .clipped()
                            Color.white
                                .opacity(0.7)
                        }
                            .blur(radius: 4)
                    )
            }
            .modelContext(modelContext)
            .tabItem {
                Label("Groups", systemImage: "rectangle.3.group.fill")
            }
            NavigationView {
                DevicesListView(smartSystem: smartSystem)
                    .background(
                        ZStack {
                            Image(uiImage: .init(data: smartSystem.backgroundImageData) ?? .init())
                                .resizable()
                                .scaledToFill()
                                .clipped()
                            Color.white
                                .opacity(0.7)
                        }
                            .blur(radius: 4)
                    )
            }
            .modelContext(modelContext)
            .tabItem {
                Label("Devices", systemImage: "externaldrive.fill.badge.wifi")
            }
            NavigationView {
                SettingsView(smartSystem: smartSystem)
                    .background(
                        ZStack {
                            Image(uiImage: .init(data: smartSystem.backgroundImageData) ?? .init())
                                .resizable()
                                .scaledToFill()
                                .clipped()
                            Color.white
                                .opacity(0.7)
                        }
                            .blur(radius: 4)
                    )
            }
            .modelContext(modelContext)
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
        .toolbarBackground(smartSystem.themeColor.color, for: .tabBar)
        .toolbarBackground(smartSystem.themeColor.color, for: .navigationBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            UserDefaults.lastSeenSystem = smartSystem.keyHash.uuidString
        }
    }
}
