//
//  Color+Ext.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 28.11.2023.
//

import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
