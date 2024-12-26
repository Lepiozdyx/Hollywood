//
//  Ability.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import Foundation

struct Ability: Identifiable, Codable {
    var id = UUID()
    let type: AbilityType
    var count: Int
    var isActive: Bool
}

enum AbilityType: String, CaseIterable, Codable {
    case fiftyfifty
    case skipquestion
    
    var price: Int {
        switch self {
        case .fiftyfifty: return 25
        case .skipquestion: return 25
        }
    }
    
    var abilityName: String {
        switch self {
        case .fiftyfifty: return "50/50"
        case .skipquestion: return "Skip"
        }
    }
    
    var abilityDescription: String {
        switch self {
        case .fiftyfifty:
            return "Removes two wrong answers"
        case .skipquestion:
            return "Skip question without penalty"
        }
    }
}
