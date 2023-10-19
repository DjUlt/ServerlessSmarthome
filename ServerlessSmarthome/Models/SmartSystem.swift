//
//  SmartSystem.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 18.10.2023.
//

import SwiftUI
import SwiftData

@Model
final class SmartSystem {
    let timestamp: Date
    let name: String
    let keyHash: UUID
    let backgroundImageData: Data
    let themeColor: ColorComponents
    
    init(timestamp: Date, name: String, keyHash: UUID, backgroundImageData: Data, themeColor: ColorComponents) {
        self.timestamp = timestamp
        self.name = name
        self.keyHash = keyHash
        self.backgroundImageData = backgroundImageData
        self.themeColor = themeColor
    }
}

struct ColorComponents: Codable {
    var red: Float
    var green: Float
    var blue: Float
    
    var color: Color {
        Color(red: Double(red) / 255, green: Double(green) / 255, blue: Double(blue) / 255)
    }
    
    static func fromColor(_ color: Color) -> ColorComponents {
        let resolved = color.resolve(in: EnvironmentValues())
        return ColorComponents(
            red: resolved.red,
            green: resolved.green,
            blue: resolved.blue
        )
    }
}
