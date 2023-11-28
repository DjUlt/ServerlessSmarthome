//
//  DeviceData.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 28.11.2023.
//

import SwiftUI
import SwiftData

@Model
final class DeviceData {
    let value: String
    let dateStamp: Date
    var parentDevice: SmartSystemDevice?
    
    var floatValue: Float {
        Float(value) ?? .zero
    }
    
    var dateStampString: String {
        dateStamp.toString(format: .full)
    }
    
    init(value: String, dateStamp: Date, parentDevice: SmartSystemDevice?) {
        self.value = value
        self.dateStamp = dateStamp
        self.parentDevice = parentDevice
    }
}
