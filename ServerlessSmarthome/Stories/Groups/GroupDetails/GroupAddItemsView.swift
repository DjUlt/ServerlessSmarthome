//
//  GroupAddItemsView.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 28.11.2023.
//

import SwiftUI
import SwiftData

struct GroupAddItemsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var group: SmartSystemGroup
    
    @State private var selectedItems = Set<SmartSystemDevice>()
    
    var body: some View {
        VStack(spacing: .zero) {
            List(selection: $selectedItems) {
                ForEach(group.parentSystem?.devices.filter({ !group.items.contains($0) }) ?? [], id: \.self) { device in
                    HStack {
                        if let image = UIImage(data: device.backgroundImageData) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .contentShape(Rectangle())
                                .clipped()
                        }
                        Text(device.name)
                            .lineLimit(1)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
            }
            Button("Save") {
                withAnimation {
                    group.items.append(contentsOf: selectedItems)
                    dismiss()
                }
            }
            .font(.title)
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .infinity)
            .buttonBorderShape(.roundedRectangle(radius: 8))
            .background(Color.white.opacity(0.9))
        }
        .scrollContentBackground(.hidden)
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
    }
}
