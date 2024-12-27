//
//  ContentViewModel.swift
//  Hollywood
//
//  Created by Alex on 27.12.2024.
//

import Foundation

@MainActor
final class ContentViewModel: ObservableObject {
    @Published private(set) var appState: AppState = .loading
    
    private let storageService: StorageServiceProtocol
    let networkService: NetworkService
    
    init(
        storageService: StorageServiceProtocol = StorageService(),
        networkService: NetworkService = NetworkService()
    ) {
        self.storageService = storageService
        self.networkService = networkService
    }
    
    func onAppear() {
        Task {
            if networkService.checkedURL != nil {
                appState = .webView
                return
            }
            
            do {
                if try await networkService.checkInitialURL() {
                    appState = .webView
                } else {
                    appState = .mainMenu
                }
            } catch {
                appState = .mainMenu
            }
        }
    }
}

// MARK: - AppState
enum AppState {
    case loading
    case webView
    case mainMenu
}
