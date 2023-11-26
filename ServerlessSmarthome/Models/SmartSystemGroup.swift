//
//  SmartSystemGroup.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 26.11.2023.
//

import SwiftUI
import SwiftData

@Model
final class SmartSystemGroup {
    let name: String
    let backgroundImageData: Data
    var items = [SmartSystemDevice]()
    var parentSystem: SmartSystem?
    
    init(name: String, backgroundImageData: Data, parentSystem: SmartSystem?) {
        self.name = name
        self.backgroundImageData = backgroundImageData
        self.parentSystem = parentSystem
    }
}
