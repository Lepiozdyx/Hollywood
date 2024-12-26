//
//  GameDataService.swift
//  Hollywood
//
//  Created by Alex on 26.12.2024.
//

import Foundation

protocol GameDataService {
    associatedtype Item: GameItem
    
    func loadItems() async throws -> [Item]
    func getRandomItem(excluding: Set<UUID>) async throws -> Item?
    func isItemAnswered(id: UUID, answeredItems: Set<UUID>) -> Bool
}

extension QuotesService: GameDataService {
    typealias Item = Quote
    
    func loadItems() async throws -> [Quote] {
        try await loadQuotes()
    }
    
    func getRandomItem(excluding: Set<UUID>) async throws -> Quote? {
        try await getRandomQuote(excluding: excluding)
    }
    
    func isItemAnswered(id: UUID, answeredItems: Set<UUID>) -> Bool {
        isQuoteAnswered(id: id, answeredQuotes: answeredItems)
    }
}

extension PicturesService: GameDataService {
    typealias Item = Picture
    
    func loadItems() async throws -> [Picture] {
        try await loadPictures()
    }
    
    func getRandomItem(excluding: Set<UUID>) async throws -> Picture? {
        try await getRandomPicture(excluding: excluding)
    }
    
    func isItemAnswered(id: UUID, answeredItems: Set<UUID>) -> Bool {
        isPictureAnswered(id: id, answeredPictures: answeredItems)
    }
}
