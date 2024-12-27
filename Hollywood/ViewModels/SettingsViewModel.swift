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
    
    @Published var isHapticsOn: Bool {
        didSet {
            SettingsService.shared.isHapticsOn = isHapticsOn
            
            if isHapticsOn {
                HapticService.shared.play(.selection)
            }
        }
    }
    
    init() {
        self.isSoundOn = SettingsService.shared.isSoundOn
        self.isMusicOn = SettingsService.shared.isMusicOn
        self.isHapticsOn = SettingsService.shared.isHapticsOn
    }
    
    func toggleSound() {
        isSoundOn.toggle()
    }
    
    func toggleMusic() {
        isMusicOn.toggle()
    }
    
    func toggleHaptics() {
        isHapticsOn.toggle()
    }
}
