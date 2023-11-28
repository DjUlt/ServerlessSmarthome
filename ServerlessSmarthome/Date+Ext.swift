//
//  Date+Ext.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 28.11.2023.
//

import Foundation

extension Date {
    func toString(format: StringFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    enum StringFormat: String {
        case full = "E, d MMM yyyy HH:mm:ss"
        case chart = "dd.MM.yy\nHH:mm:ss"
    }
}
