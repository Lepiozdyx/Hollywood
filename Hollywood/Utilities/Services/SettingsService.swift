//
//  SettingsService.swift
//  Hollywood
//
//  Created by Alex on 27.12.2024.
//

import Foundation

final class SettingsService {
    
    private enum Keys: String {
        case isSoundOn
        case isMusicOn
    }
    
    static let shared = SettingsService()
    
    var isSoundOn: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.isSoundOn.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.isSoundOn.rawValue) }
    }
    
    var isMusicOn: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.isMusicOn.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.isMusicOn.rawValue) }
    }
    
    private init() {
        if UserDefaults.standard.object(forKey: Keys.isSoundOn.rawValue) == nil {
            isSoundOn = true
        }
        if UserDefaults.standard.object(forKey: Keys.isMusicOn.rawValue) == nil {
            isMusicOn = true
        }
    }
}
