//
//  AbilityShopViewModel.swift
//  Hollywood
//
//  Created by Alex on 26.12.2024.
//

import SwiftUI

@MainActor
final class AbilityShopViewModel: ObservableObject {
    // MARK: - Properties
    private let gameService: GameServiceProtocol
    private let storageService: StorageServiceProtocol
    
    @Published var gameState: GameState
    @Published var showWelcomeAlert: Bool = false
    
    // MARK: - Initialization
    init(
        gameService: GameServiceProtocol = GameService(),
        storageService: StorageServiceProtocol = StorageService()
    ) {
        self.gameService = gameService
        self.storageService = storageService
        
        do {
            self.gameState = try storageService.loadGameState()
        } catch {
            self.gameState = GameState()
        }
    }
    
    // MARK: - Public Methods
    func onAppear() {
        checkFirstLaunch()
    }
    
    func buyAbility(_ type: AbilityType) {
        if let newState = gameService.buyAbility(type, gameState: gameState) {
            gameState = newState
            try? storageService.saveGameState(gameState)
        }
    }
    
    func getAbilityCount(_ type: AbilityType) -> Int {
        gameState.abilities.first(where: { $0.type == type })?.count ?? 0
    }
    
    // MARK: - Private Methods
    private func checkFirstLaunch() {
        if storageService.isFirstLaunch() {
            showWelcomeAlert = true
            storageService.setFirstLaunch()
        }
    }
}
