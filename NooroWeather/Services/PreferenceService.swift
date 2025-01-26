//
//  PreferenceService.swift
//  NooroWeather
//
//  Created by Kevin Sullivan on 1/26/25.
//

import Foundation

enum Preference: String {
    case selectedCity
}

protocol PreferenceServiceProtocol {
    func set(value: Any?, for preference: Preference)
    func read<T>(_ preference: Preference, as type: T.Type) -> T?
}

class PreferenceService: PreferenceServiceProtocol {
    
    private let defaults = UserDefaults.standard
    
    func set(value: Any?, for preference: Preference) {
        defaults.set(value, forKey: preference.rawValue)
    }
    
    func read<T>(_ preference: Preference, as type: T.Type) -> T? {
        guard defaults.object(forKey: preference.rawValue) != nil else { return nil }
        
        switch type {
        case is Int.Type: return defaults.integer(forKey: preference.rawValue) as? T
        case is String.Type: return defaults.string(forKey: preference.rawValue) as? T
        case is Bool.Type: return defaults.bool(forKey: preference.rawValue) as? T
        default: return defaults.object(forKey: preference.rawValue) as? T
        }
    }
}
