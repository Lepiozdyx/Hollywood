//
//  QuotesService.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import Foundation

protocol QuotesServiceProtocol {
    func loadQuotes() async throws -> [Quote]
    func getRandomQuote(excluding: Set<UUID>) async throws -> Quote?
    func isQuoteAnswered(id: UUID, answeredQuotes: Set<UUID>) -> Bool
}

final class QuotesService: QuotesServiceProtocol {
    private var allQuotes: [Quote] = []
    
    func loadQuotes() async throws -> [Quote] {
        if allQuotes.isEmpty {
            guard let url = Bundle.main.url(forResource: "quotes", withExtension: "json") else {
                throw QuotesError.fileNotFound
            }
            
            let data = try Data(contentsOf: url)
            let quotesDTO = try JSONDecoder().decode(QuotesDTO.self, from: data)
            
            allQuotes = quotesDTO.quotes.map { dto in
                var options = dto.options
                options.shuffle()
                return Quote(
                    id: UUID(),
                    text: dto.text,
                    options: options,
                    correctAnswer: dto.correctAnswer
                )
            }
        }
        
        return allQuotes
    }
    
    func getRandomQuote(excluding answeredQuotes: Set<UUID>) async throws -> Quote? {
        let quotes = try await loadQuotes()
        let availableQuotes = quotes.filter { !answeredQuotes.contains($0.id) }
        return availableQuotes.randomElement()
    }
    
    func isQuoteAnswered(id: UUID, answeredQuotes: Set<UUID>) -> Bool {
        answeredQuotes.contains(id)
    }
}

// MARK: - Errors
extension QuotesService {
    enum QuotesError: Error {
        case fileNotFound
        case noAvailableQuotes
    }
}
