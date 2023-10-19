//
//  SystemSelectView.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 18.10.2023.
//

import SwiftUI
import SwiftData

struct SystemSelectView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var smartSystems: [SmartSystem]
    
    @State private var isDeleteAlertPresented = false
    @State private var selectedSmartSystem: SmartSystem?
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.fixed((geometry.size.width - 10) / 2 - 10)),
                        GridItem(.fixed((geometry.size.width - 10) / 2 - 10)),
                    ]) {
                        ForEach(smartSystems) { smartSystem in
                            SystemCardView(system: .constant(smartSystem))
                                .frame(height: 150)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        selectedSmartSystem = smartSystem
                                        isDeleteAlertPresented.toggle()
                                    } label: {
                                        Label("Delete", systemImage: "xmark.bin.fill")
                                    }
                                }
                        }
                    }
                }
            }
        }
        .navigationTitle("System selection")
        .toolbar {
            NavigationLink(destination: SystemCreationView()) {
                Label("", systemImage: "plus.app.fill")
            }
        }
        .alert("Are you sure?", isPresented: $isDeleteAlertPresented) {
            Button(role: .destructive) {
                guard let selectedSmartSystem else { return }
                deleteItems(smartSystem: selectedSmartSystem)
                self.selectedSmartSystem = nil
            } label: {
                Label("Delete", systemImage: "xmark.bin.fill")
            }
            Button {
                selectedSmartSystem = nil
            } label: {
                Label("Cancel", systemImage: "return")
            }
        }
    }
    
    private func deleteItems(smartSystem: SmartSystem) {
        withAnimation {
            modelContext.delete(smartSystem)
        }
    }
}

#Preview {
    SystemSelectView()
        .modelContainer(for: SmartSystem.self, inMemory: true)
}

