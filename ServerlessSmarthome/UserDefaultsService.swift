//
//  UserDefaultsService.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 24.11.2023.
//

import Foundation

extension UserDefaults {
    private static let defaultSuite = UserDefaults.standard
    
    static var lastRefreshTimeout: Int {
        get {
            defaultSuite.integer(forKey: FileConstants.Keys.lastRefreshTimeout.rawValue)
        }
        set {
            defaultSuite.setValue(newValue, forKey: FileConstants.Keys.lastRefreshTimeout.rawValue)
        }
    }
    
    static var lastSeenSystem: String? {
        get {
            defaultSuite.string(forKey: FileConstants.Keys.lastSeenSystem.rawValue)
        }
        set {
            defaultSuite.setValue(newValue, forKey: FileConstants.Keys.lastSeenSystem.rawValue)
        }
    }
}

private enum FileConstants {
    enum Keys: String {
        case lastRefreshTimeout
        case lastSeenSystem
    }
}
