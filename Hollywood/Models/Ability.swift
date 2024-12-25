//
//  Ability.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import Foundation

struct Ability: Identifiable {
    let id = UUID()
    let type: AbilityType
    var count: Int
    var isActive: Bool
}

enum AbilityType: String, CaseIterable, Codable {
    case fiftyfifty
    case righttomakeamistake
    
    var price: Int {
        switch self {
        case .fiftyfifty: return 25
        case .righttomakeamistake: return 25
        }
    }
    
    var abilityName: String {
        switch self {
        case .fiftyfifty: return "50/50"
        case .righttomakeamistake: return "!"
        }
    }
    
    var abilityDescription: String {
        switch self {
        case .fiftyfifty:
            return "Removes two wrong answers"
        case .righttomakeamistake:
            return "Right to make a mistake"
        }
    }
}
