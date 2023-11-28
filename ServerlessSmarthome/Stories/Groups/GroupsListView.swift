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
    @State private var selectedGroup: SmartSystemGroup?
    
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
                        .aspectRatio(1, contentMode: .fit)
                }
                Text(group.name)
                    .lineLimit(1)
                    .font(.title3)
                    .fontWeight(.semibold)
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
            .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                Button(role: .destructive) {
                    selectedGroup = group
                    isDeleteAlertPresented.toggle()
                } label: {
                    Label("Delete", systemImage: "xmark.bin.fill")
                }
            })
            .contextMenu {
                Button(role: .destructive) {
                    selectedGroup = group
                    isDeleteAlertPresented.toggle()
                } label: {
                    Label("Delete", systemImage: "xmark.bin.fill")
                }
            }
        })
        .scrollContentBackground(.hidden)
        .navigationTitle("Group selection")
        .toolbar {
            NavigationLink(destination: GroupCreationView(smartSystem: smartSystem)) {
                Label("", systemImage: "plus.app.fill")
            }
        }
        .alert("Are you sure?", isPresented: $isDeleteAlertPresented) {
            Button(role: .destructive) {
                guard let selectedGroup else { return }
                deleteItems(smartSystemGroup: selectedGroup)
                self.selectedGroup = nil
            } label: {
                Label("Delete", systemImage: "xmark.bin.fill")
            }
        }
    }
    
    private func deleteItems(smartSystemGroup: SmartSystemGroup) {
        withAnimation {
            modelContext.delete(smartSystemGroup)
        }
    }
}
