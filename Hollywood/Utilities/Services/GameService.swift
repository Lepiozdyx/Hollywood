//
//  GameService.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import Foundation

protocol GameServiceProtocol {
    func handleAnswer<T: GameItem>(_ answer: String, for item: T, gameState: GameState) -> (isCorrect: Bool, newState: GameState)
    func useAbility(_ type: AbilityType, gameState: GameState) -> GameState?
    func isGameOver(gameState: GameState, totalQuotes: Int) -> Bool
    func buyAbility(_ type: AbilityType, gameState: GameState) -> GameState?
    func prepareForNextQuote(_ gameState: GameState) -> GameState
    func getDisabledOptions(_ options: [String], correctAnswer: String) -> Set<String>
}

final class GameService: GameServiceProtocol {
    private let starsForCorrectAnswer = 10
    private let starsForWrongAnswer = -10
    
    func handleAnswer<T: GameItem>(_ answer: String, for item: T, gameState: GameState) -> (isCorrect: Bool, newState: GameState) {
        var newState = gameState
        let isCorrect = answer == item.correctAnswer
        
        if isCorrect {
            newState.stars += starsForCorrectAnswer
        } else {
            let skipAbilityActive = newState.abilities.first(where: {
                $0.type == .skipquestion && $0.isActive
            }) != nil
            
            if !skipAbilityActive {
                newState.stars = max(0, newState.stars + starsForWrongAnswer)
            }
        }
        
        newState.answeredQuotes.insert(item.id)
        newState = prepareForNextQuote(newState)
        return (isCorrect, newState)
    }
    
    func useAbility(_ type: AbilityType, gameState: GameState) -> GameState? {
        var newState = gameState
        
        // Находим индекс способности
        guard let abilityIndex = newState.abilities.firstIndex(where: {
            $0.type == type && $0.count > 0 && !$0.isActive
        }) else {
            return nil
        }
        
        // Уменьшаем количество доступных использований
        newState.abilities[abilityIndex].count -= 1
        
        // Активируем способность
        newState.abilities[abilityIndex].isActive = true
        
        return newState
    }
    
    func isGameOver(gameState: GameState, totalQuotes: Int) -> Bool {
        gameState.answeredQuotes.count >= totalQuotes
    }
    
    func buyAbility(_ type: AbilityType, gameState: GameState) -> GameState? {
        guard gameState.stars >= type.price else { return nil }
        
        var newState = gameState
        newState.stars -= type.price
        
        if let index = newState.abilities.firstIndex(where: { $0.type == type }) {
            newState.abilities[index].count += 1
        } else {
            newState.abilities.append(Ability(type: type, count: 1, isActive: false))
        }
        
        return newState
    }
    
    func prepareForNextQuote(_ gameState: GameState) -> GameState {
        var newState = gameState
        // Сбрасываем все активные способности
        newState.abilities = newState.abilities.map { ability in
            var newAbility = ability
            newAbility.isActive = false
            return newAbility
        }
        return newState
    }
    
    func getDisabledOptions(_ options: [String], correctAnswer: String) -> Set<String> {
        let wrongAnswers = options
            .filter { $0 != correctAnswer }
            .shuffled()
            .dropFirst() // Оставляем первый неверный ответ активным
        return Set(wrongAnswers)
    }
}
