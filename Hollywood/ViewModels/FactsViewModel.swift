//
//  FactsViewModel.swift
//  Hollywood
//
//  Created by Alex on 27.12.2024.
//

import SwiftUI

@MainActor
final class FactsViewModel: ObservableObject {
    // MARK: - Properties
    private let factsService: FactsServiceProtocol
    
    @Published var facts: [Fact] = []
    @Published var currentIndex: Int = 0
    
    var currentFact: Fact? {
        guard !facts.isEmpty, currentIndex >= 0, currentIndex < facts.count else { return nil }
        return facts[currentIndex]
    }
    
    var canGoNext: Bool {
        guard !facts.isEmpty else { return false }
        return currentIndex < facts.count - 1
    }
    
    var canGoPrevious: Bool {
        guard !facts.isEmpty else { return false }
        return currentIndex > 0
    }
    
    // MARK: - Initialization
    init(factsService: FactsServiceProtocol = FactsService()) {
        self.factsService = factsService
    }
    
    // MARK: - Public Methods
    func onAppear() {
        Task {
            do {
                facts = try await factsService.loadFacts()
            } catch {
                print("Error loading facts: \(error)")
            }
        }
    }
    
    func nextFact() {
        guard canGoNext else { return }
        withAnimation {
            currentIndex += 1
        }
    }
    
    func previousFact() {
        guard canGoPrevious else { return }
        withAnimation {
            currentIndex -= 1
        }
    }
}
