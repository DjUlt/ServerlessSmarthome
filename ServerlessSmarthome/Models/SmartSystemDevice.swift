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
    var parentSystem: SmartSystem?
    var previousDevice: SmartSystemDevice? = nil
    var nextDevice: SmartSystemDevice? = nil
    
    init(timestamp: Date, name: String, selfKeyHash: UUID, backgroundImageData: Data, parentSystem: SmartSystem?) {
        self.timestamp = timestamp
        self.name = name
        self.selfKeyHash = selfKeyHash
        self.backgroundImageData = backgroundImageData
        self.parentSystem = parentSystem
    }
}
