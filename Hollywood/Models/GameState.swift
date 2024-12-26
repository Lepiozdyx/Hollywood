//
//  GameState.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import Foundation

struct GameState: Codable {
    var currentQuote: Quote?
    var answeredQuotes: Set<UUID>
    var stars: Int
    var abilities: [Ability]
    
    init(
        currentQuote: Quote? = nil,
        answeredQuotes: Set<UUID> = [],
        stars: Int = 50,
        abilities: [Ability] = []
    ) {
        self.currentQuote = currentQuote
        self.answeredQuotes = answeredQuotes
        self.stars = stars
        self.abilities = abilities
    }
}

// MARK: - UserDefaults Keys
extension GameState {
    enum UserDefaultsKeys {
        static let gameState = "game_state"
        static let isFirstLaunch = "is_first_launch"
    }
}
