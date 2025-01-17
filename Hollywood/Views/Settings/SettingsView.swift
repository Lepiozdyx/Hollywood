//
//  SettingsView.swift
//  Hollywood
//
//  Created by Alex on 27.12.2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var vm = SettingsViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()
            
            // Top bar with back button
            HStack {
                BackButtonView()
                Spacer()
            }
            .padding()
            
            VStack {
                Spacer()
                
                HStack(spacing: 30) {
                    SwitchButtonView(
                        image: .sound,
                        isOn: vm.isSoundOn,
                        size: 100,
                        action: vm.toggleSound
                    )
                    
                    SwitchButtonView(
                        image: .music,
                        isOn: vm.isMusicOn,
                        size: 100,
                        action: vm.toggleMusic
                    )
                }
                
                SwitchButtonView(
                    image: .vibro,
                    isOn: vm.isHapticsOn,
                    size: 100,
                    action: vm.toggleHaptics
                )
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SettingsView()
}
