//
//  DeviceDetailsView.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 28.11.2023.
//

import SwiftUI
import SwiftData

struct DeviceDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var device: SmartSystemDevice
    
    var body: some View {
        VStack {
            List {
                ForEach(device.deviceData, id: \.self) { deviceData in
                    HStack {
                        VStack {
                            Text(device.name)
                                .lineLimit(1)
                            Text(deviceData.value)
                                .lineLimit(1)
                                .font(.title3)
                                .fontWidth(.expanded)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        Text(deviceData.dateStampString)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .navigationTitle(device.name)
        .toolbar {
            Button("Add test data", systemImage: "pencil.tip.crop.circle.badge.plus.fill") {
                let newData = DeviceData(value: String(format: "%.2f", Float.random(in: 0...100)), dateStamp: Date(), parentDevice: device)
                withAnimation {
                    device.deviceData.append(newData)
                    modelContext.insert(newData)
                }
            }
            NavigationLink(destination: DeviceStatisticsView(device: device)) {
                Label("", systemImage: "chart.bar.xaxis")
            }
            .disabled(device.deviceData.isEmpty)
        }
        .background(
            ZStack {
                Image(uiImage: .init(data: device.backgroundImageData) ?? .init())
                    .resizable()
                    .scaledToFill()
                Color.white
                    .opacity(0.7)
            }
                .blur(radius: 4)
        )
        .clipped()
    }
}
