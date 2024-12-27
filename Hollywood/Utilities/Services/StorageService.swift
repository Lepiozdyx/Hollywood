//
//  StorageService.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import Foundation

protocol StorageServiceProtocol {
    func saveGameState(_ state: GameState) throws
    func loadGameState() throws -> GameState
    func isFirstLaunch() -> Bool
    func setFirstLaunch()
}

final class StorageService: StorageServiceProtocol {
    private let defaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func saveGameState(_ state: GameState) throws {
        let data = try encoder.encode(state)
        defaults.set(data, forKey: GameState.UserDefaultsKeys.gameState)
    }
    
    func loadGameState() throws -> GameState {
        guard let data = defaults.data(forKey: GameState.UserDefaultsKeys.gameState) else {
            return GameState()
        }
        
        return try decoder.decode(GameState.self, from: data)
    }
    
    func isFirstLaunch() -> Bool {
        !defaults.bool(forKey: GameState.UserDefaultsKeys.isFirstLaunch)
    }
    
    func setFirstLaunch() {
        defaults.set(true, forKey: GameState.UserDefaultsKeys.isFirstLaunch)
    }
}

// MARK: - Errors
extension StorageService {
    enum StorageError: Error {
        case encodingError
        case decodingError
        case noDataFound
    }
}
