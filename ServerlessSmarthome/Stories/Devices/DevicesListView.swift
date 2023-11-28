//
//  DevicesListView.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 26.11.2023.
//

import SwiftUI
import SwiftData

struct DevicesListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var smartSystem: SmartSystem
    
    @State private var isDeleteAlertPresented = false
    @State private var selectedItem: SmartSystemDevice?
    
    var body: some View {
        List(smartSystem.devices, rowContent: { device in
            NavigationLink(destination: DeviceDetailsView(device: device)) {
                HStack {
                    if let image = UIImage(data: device.backgroundImageData) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                    }
                    Text(device.name)
                        .lineLimit(1)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                    Button(role: .destructive) {
                        selectedItem = device
                        isDeleteAlertPresented.toggle()
                    } label: {
                        Label("Delete", systemImage: "xmark.bin.fill")
                    }
                })
                .contextMenu {
                    Button(role: .destructive) {
                        selectedItem = device
                        isDeleteAlertPresented.toggle()
                    } label: {
                        Label("Delete", systemImage: "xmark.bin.fill")
                    }
                }
            }
        })
        .scrollContentBackground(.hidden)
        .navigationTitle("Item selection")
        .toolbar {
            NavigationLink(destination: DeviceCreationView(smartSystem: smartSystem)) {
                Label("", systemImage: "plus.app.fill")
            }
        }
        .alert("Are you sure?", isPresented: $isDeleteAlertPresented) {
            Button(role: .destructive) {
                guard let selectedItem else { return }
                deleteItems(smartSystemDevice: selectedItem)
                self.selectedItem = nil
            } label: {
                Label("Delete", systemImage: "xmark.bin.fill")
            }
        }
    }
    
    private func deleteItems(smartSystemDevice: SmartSystemDevice) {
        withAnimation {
            modelContext.delete(smartSystemDevice)
        }
    }
}
