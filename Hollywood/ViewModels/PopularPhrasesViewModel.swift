import SwiftUI

@MainActor
final class PopularPhrasesViewModel: ObservableObject {
    // MARK: - Properties
    private let quotesService: QuotesServiceProtocol
    private let gameService: GameServiceProtocol
    private let storageService: StorageServiceProtocol
    
    @Published var currentQuote: Quote?
    @Published var gameState: GameState
    @Published var isGameOver: Bool = false
    @Published var showWrongAnswerAnimation: Bool = false
    @Published var showCorrectAnswerAnimation: Bool = false
    @Published var selectedAnswer: String?
    @Published var disabledAnswerButtons: Set<String> = []
    
    private var isAnimating: Bool = false
    
    // MARK: - Computed Properties
    var currentOptions: [String] {
        if let quote = currentQuote {
            if gameState.abilities.first(where: { $0.type == .fiftyfifty && $0.isActive }) != nil {
                return gameService.removeWrongAnswers(quote.options, correctAnswer: quote.correctAnswer)
            }
            return quote.options
        }
        return []
    }
    
    // MARK: - Initialization
    init(
        quotesService: QuotesServiceProtocol = QuotesService(),
        gameService: GameServiceProtocol = GameService(),
        storageService: StorageServiceProtocol = StorageService()
    ) {
        self.quotesService = quotesService
        self.gameService = gameService
        self.storageService = storageService
        
        do {
            self.gameState = try storageService.loadGameState()
            // Сбрасываем состояние игры при создании нового ViewModel
            self.gameState.answeredQuotes.removeAll()
            try storageService.saveGameState(self.gameState)
        } catch {
            self.gameState = GameState()
        }
    }
    
    // MARK: - Public Methods
    func onAppear() {
        Task {
            await loadNextQuote()
        }
    }
    
    func handleAnswer(_ answer: String) {
        guard let quote = currentQuote, !isAnimating else { return }
        isAnimating = true
        selectedAnswer = answer
        
        let (isCorrect, newState) = gameService.handleAnswer(answer, for: quote, gameState: gameState)
        gameState = newState
        
        try? storageService.saveGameState(gameState)
        
        if isCorrect {
            showCorrectAnswerAnimation = true
            Task {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                showCorrectAnswerAnimation = false
                selectedAnswer = nil
                await loadNextQuote()
                isAnimating = false
            }
        } else {
            if gameState.abilities.first(where: { $0.type == .righttomakeamistake && $0.isActive }) != nil {
                showWrongAnswerAnimation = true
                Task {
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    showWrongAnswerAnimation = false
                    selectedAnswer = nil
                    disabledAnswerButtons.insert(answer)
                    isAnimating = false
                }
            } else {
                showWrongAnswerAnimation = true
                Task {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    showWrongAnswerAnimation = false
                    selectedAnswer = nil
                    await loadNextQuote()
                    isAnimating = false
                }
            }
        }
    }
    
    func useAbility(_ type: AbilityType) {
        guard !isAnimating else { return }
        
        if let newState = gameService.useAbility(type, gameState: gameState) {
            gameState = newState
            try? storageService.saveGameState(gameState)
        }
    }
    
    func resetGame() {
        gameState.answeredQuotes.removeAll()
        isGameOver = false
        try? storageService.saveGameState(gameState)
        Task {
            await loadNextQuote()
        }
    }
    
    // MARK: - Private Methods
    private func loadNextQuote() async {
        do {
            let totalQuotes = try await quotesService.loadQuotes().count
            
            if gameService.isGameOver(gameState: gameState, totalQuotes: totalQuotes) {
                isGameOver = true
                return
            }
            
            if let quote = try await quotesService.getRandomQuote(excluding: gameState.answeredQuotes) {
                currentQuote = quote
                disabledAnswerButtons.removeAll()
            } else {
                isGameOver = true
            }
        } catch {
            print("Error loading quote: \(error)")
        }
    }
}
