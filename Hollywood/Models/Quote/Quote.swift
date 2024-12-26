//
//  Quote.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import Foundation

struct Quote: Identifiable, Codable, Equatable, GameItem {
    let id: UUID
    let text: String
    let options: [String]
    let correctAnswer: String
    
    var displayContent: String {
        return text
    }
    
    init(id: UUID = UUID(), text: String, options: [String], correctAnswer: String) {
        self.id = id
        self.text = text
        self.options = options
        self.correctAnswer = correctAnswer
    }
    
    static func == (lhs: Quote, rhs: Quote) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Mock Data
extension Quote {
    static var mock: Quote {
        Quote(
            text: "May the Force be with you.",
            options: [
                "Star Wars",
                "Star Trek",
                "Guardians of the Galaxy",
                "Dune"
            ],
            correctAnswer: "Star Wars"
        )
    }
}
