//
//  FactService.swift
//  Hollywood
//
//  Created by Alex on 27.12.2024.
//

import Foundation

protocol FactsServiceProtocol {
    func loadFacts() async throws -> [Fact]
}

final class FactsService: FactsServiceProtocol {
    private var allFacts: [Fact] = []
    
    func loadFacts() async throws -> [Fact] {
        if allFacts.isEmpty {
            guard let url = Bundle.main.url(forResource: "facts", withExtension: "json") else {
                throw FactsError.fileNotFound
            }
            
            let data = try Data(contentsOf: url)
            let factsDTO = try JSONDecoder().decode(FactsDTO.self, from: data)
            allFacts = factsDTO.facts
        }
        
        return allFacts
    }
}

// MARK: - Errors
extension FactsService {
    enum FactsError: Error {
        case fileNotFound
    }
}
