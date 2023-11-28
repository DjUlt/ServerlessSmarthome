//
//  SmartSystemDevice.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 26.11.2023.
//

import SwiftUI
import SwiftData

@Model
final class SmartSystemDevice {
    let timestamp: Date
    let name: String
    let selfKeyHash: UUID
    let backgroundImageData: Data
    let colorComponents: ColorComponents
    var parentSystem: SmartSystem?
    var previousDevice: SmartSystemDevice? = nil
    var nextDevice: SmartSystemDevice? = nil
    @Relationship(deleteRule: .cascade) var deviceData: [DeviceData] = []
    
    var color: Color {
        colorComponents.color
    }
    
    var dataDict: [Date: Float] {
        var dict: [Date: Float] = [:]
        for deviceDatum in deviceData {
            dict[deviceDatum.dateStamp] = deviceDatum.floatValue
        }
        return dict
    }
    
    var dataValCountDict: [Int: Int] {
        var dict: [Int: Int] = [:]
        for deviceDatum in deviceData {
            dict[Int(deviceDatum.floatValue)] = (dict[Int(deviceDatum.floatValue)] ?? .zero) + 1
        }
        return dict
    }
    
    init(timestamp: Date, name: String, selfKeyHash: UUID, backgroundImageData: Data, parentSystem: SmartSystem?, colorComponents: ColorComponents) {
        self.timestamp = timestamp
        self.name = name
        self.selfKeyHash = selfKeyHash
        self.backgroundImageData = backgroundImageData
        self.colorComponents = colorComponents
        self.parentSystem = parentSystem
    }
}
