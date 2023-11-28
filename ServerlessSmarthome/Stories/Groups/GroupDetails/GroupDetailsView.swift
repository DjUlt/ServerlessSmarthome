//
//  GroupDetailsView.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 28.11.2023.
//

import SwiftUI
import SwiftData

struct GroupDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var group: SmartSystemGroup
    
    @State private var isDeleteAlertPresented = false
    @State private var selectedItem: SmartSystemDevice?
    
    var body: some View {
        List {
            ForEach(group.items, id: \.self) { item in
                NavigationLink(destination: DeviceDetailsView(device: item)) {
                    HStack {
                        if let image = UIImage(data: item.backgroundImageData) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .contentShape(Rectangle())
                                .clipped()
                        }
                        Text(item.name)
                            .lineLimit(1)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                        Button(role: .destructive) {
                            selectedItem = item
                            isDeleteAlertPresented.toggle()
                        } label: {
                            Label("Delete", systemImage: "xmark.bin.fill")
                        }
                    })
                    .contextMenu {
                        Button(role: .destructive) {
                            selectedItem = item
                            isDeleteAlertPresented.toggle()
                        } label: {
                            Label("Delete", systemImage: "xmark.bin.fill")
                        }
                    }
                }
                .id(UUID())
            }
            .onMove { from, to in
                var tempArray = group.items
                tempArray.move(fromOffsets: from, toOffset: to)
                withAnimation {
                    group.items = tempArray
                }
            }
        }
        .scrollContentBackground(.hidden)
        .navigationTitle(group.name)
        .toolbar {
            NavigationLink(destination: GroupAddItemsView(group: group)) {
                Label("", systemImage: "plus.app.fill")
            }
            .disabled((group.parentSystem?.devices.filter({ !group.items.contains($0) }) ?? []).isEmpty)
            NavigationLink(destination: GroupStatisticsView(group: group)) {
                Label("", systemImage: "chart.bar.xaxis")
            }
            .disabled(group.items.flatMap { $0.deviceData }.isEmpty)
        }
        .background(
            ZStack {
                Image(uiImage: .init(data: group.backgroundImageData) ?? .init())
                    .resizable()
                    .scaledToFill()
                    .clipped()
                Color.white
                    .opacity(0.7)
            }
                .blur(radius: 4)
        )
        .clipped()
        .alert("Are you sure?", isPresented: $isDeleteAlertPresented) {
            Button(role: .destructive) {
                guard let selectedItem else { return }
                withAnimation {
                    group.items.removeAll(where: { $0 == selectedItem })
                }
                self.selectedItem = nil
            } label: {
                Label("Delete", systemImage: "xmark.bin.fill")
            }
        }
    }
}
