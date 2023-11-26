//
//  GroupsListView.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 26.11.2023.
//

import SwiftUI
import SwiftData

struct GroupsListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var smartSystem: SmartSystem
    
    @State private var isDeleteAlertPresented = false
    @State private var selectedSmartSystem: SmartSystem?
    
    var body: some View {
        List(smartSystem.groups, rowContent: { group in
            HStack {
                Image(systemName: "folder.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                if let image = UIImage(data: group.backgroundImageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                Text(group.name)
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
        .navigationTitle("Group selection")
        .toolbar {
            NavigationLink(destination: GroupCreationView(smartSystem: smartSystem)) {
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
