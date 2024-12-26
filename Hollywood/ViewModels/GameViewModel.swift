//
//  GameViewModel.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import SwiftUI

@MainActor
final class GameViewModel<Service: GameDataService>: ObservableObject {
    // MARK: - Properties
    private let dataService: Service
    private let gameService: GameServiceProtocol
    private let storageService: StorageServiceProtocol
    
    @Published var currentItem: Service.Item?
    @Published var gameState: GameState
    @Published var isGameOver: Bool = false
    @Published var showWrongAnswerAnimation: Bool = false
    @Published var showCorrectAnswerAnimation: Bool = false
    @Published var selectedAnswer: String?
    @Published var disabledAnswerButtons: Set<String> = []
    
    private var fiftyFiftyDisabledAnswers: Set<String> = []
    private var totalItemsCount: Int = 0
    private var isAnimating: Bool = false
    
    // MARK: - Computed Properties
    var currentOptions: [String] {
        currentItem?.options ?? []
    }
    
    // MARK: - Initialization
    init(
        dataService: Service,
        gameService: GameServiceProtocol = GameService(),
        storageService: StorageServiceProtocol = StorageService()
    ) {
        self.dataService = dataService
        self.gameService = gameService
        self.storageService = storageService
        
        do {
            self.gameState = try storageService.loadGameState()
            self.gameState.answeredQuotes.removeAll()
            try storageService.saveGameState(self.gameState)
        } catch {
            self.gameState = GameState()
        }
    }
    
    // MARK: - Public Methods
    func isButtonDisabled(_ option: String) -> Bool {
        disabledAnswerButtons.contains(option) || fiftyFiftyDisabledAnswers.contains(option)
    }
    
    func getButtonOpacity(_ option: String) -> Double {
        if fiftyFiftyDisabledAnswers.contains(option) {
            return 0.5
        }
        if disabledAnswerButtons.contains(option) {
            return 0.5
        }
        return 1.0
    }
    
    func onAppear() {
        Task {
            do {
                let items = try await dataService.loadItems()
                totalItemsCount = items.count
                await loadNextItem()
            } catch {
                print("Error loading items: \(error)")
            }
        }
    }
    
    func handleAnswer(_ answer: String) {
        guard let item = currentItem, !isAnimating else { return }
        isAnimating = true
        selectedAnswer = answer
        
        let (isCorrect, newState) = gameService.handleAnswer(answer, for: item, gameState: gameState)
        
        Task { @MainActor in
            gameState = newState
            try? storageService.saveGameState(gameState)
            
            if isCorrect {
                showCorrectAnswerAnimation = true
                try? await Task.sleep(nanoseconds: 700_000_000)
                showCorrectAnswerAnimation = false
                selectedAnswer = nil
                await loadNextItem()
            } else {
                if gameState.abilities.first(where: { $0.type == .skipquestion && $0.isActive }) != nil {
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    await loadNextItem()
                } else {
                    showWrongAnswerAnimation = true
                    try? await Task.sleep(nanoseconds: 700_000_000)
                    showWrongAnswerAnimation = false
                    selectedAnswer = nil
                    await loadNextItem()
                }
            }
            isAnimating = false
        }
    }
    
    func useAbility(_ type: AbilityType) {
        guard !isAnimating else { return }
        
        if type == .fiftyfifty {
            if let item = currentItem {
                fiftyFiftyDisabledAnswers = gameService.getDisabledOptions(item.options, correctAnswer: item.correctAnswer)
            }
        }
        
        if let newState = gameService.useAbility(type, gameState: gameState) {
            gameState = newState
            try? storageService.saveGameState(gameState)
            
            if type == .skipquestion {
                Task {
                    await loadNextItem()
                }
            }
        }
    }
    
    func resetGame() {
        gameState.answeredQuotes.removeAll()
        isGameOver = false
        currentItem = nil
        disabledAnswerButtons.removeAll()
        fiftyFiftyDisabledAnswers.removeAll()
        try? storageService.saveGameState(gameState)
        Task {
            await loadNextItem()
        }
    }
    
    // MARK: - Private Methods
    private func loadNextItem() async {
        do {
            if gameService.isGameOver(gameState: gameState, totalQuotes: totalItemsCount) {
                isGameOver = true
                return
            }
            
            if let item = try await dataService.getRandomItem(excluding: gameState.answeredQuotes) {
                await MainActor.run {
                    withAnimation {
                        self.currentItem = item
                        self.disabledAnswerButtons.removeAll()
                        self.fiftyFiftyDisabledAnswers.removeAll()
                    }
                }
            } else {
                await MainActor.run {
                    self.isGameOver = true
                }
            }
        } catch {
            print("Error loading item: \(error)")
        }
    }
}
