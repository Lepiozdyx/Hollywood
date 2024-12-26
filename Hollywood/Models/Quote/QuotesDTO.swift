//
//  QuotesDTO.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import Foundation

struct QuotesDTO: Codable {
    let quotes: [QuoteDTO]
}

struct QuoteDTO: Codable {
    let id: String
    let text: String
    let options: [String]
    let correctAnswer: String
    
    func toDomain() -> Quote {
        Quote(
            id: UUID(),
            text: text,
            options: options,
            correctAnswer: correctAnswer
        )
    }
}
