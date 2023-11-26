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
    @State private var selectedSmartSystem: SmartSystem?
    
    var body: some View {
        List(smartSystem.devices, rowContent: { device in
            HStack {
                if let image = UIImage(data: device.backgroundImageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 128, height: 64)
                }
                Text(device.name)
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.blue)
            }
            .onTapGesture {
                // TODO: Open device details
            }
        })
        .navigationTitle("Item selection")
        .toolbar {
            NavigationLink(destination: DeviceCreationView(smartSystem: smartSystem)) {
                Label("", systemImage: "plus.app.fill")
            }
        }
//        .alert("Are you sure?", isPresented: $isDeleteAlertPresented) {
//            Button(role: .destructive) {
//                guard let selectedSmartSystem else { return }
//                deleteItems(smartSystem: selectedSmartSystem)
//                self.selectedSmartSystem = nil
//            } label: {
//                Label("Delete", systemImage: "xmark.bin.fill")
//            }
//            Button {
//                selectedSmartSystem = nil
//            } label: {
//                Label("Cancel", systemImage: "return")
//            }
//        }
    }
    
//    private func deleteItems(smartSystem: SmartSystem) {
//        withAnimation {
//            modelContext.delete(smartSystem)
//        }
//    }
}
