//
//  SettingsViewModel.swift
//  Hollywood
//
//  Created by Alex on 27.12.2024.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var isSoundOn: Bool {
        didSet {
            SettingsService.shared.isSoundOn = isSoundOn
            
            if isSoundOn {
                SoundService.shared.playSound()
            }
        }
    }
    
    @Published var isMusicOn: Bool {
        didSet {
            SettingsService.shared.isMusicOn = isMusicOn
            
            SoundService.shared.updateMusicState()
            if isSoundOn {
                SoundService.shared.playSound()
            }
        }
    }
    
    init() {
        self.isSoundOn = SettingsService.shared.isSoundOn
        self.isMusicOn = SettingsService.shared.isMusicOn
    }
    
    func toggleSound() {
        isSoundOn.toggle()
    }
    
    func toggleMusic() {
        isMusicOn.toggle()
    }
}
