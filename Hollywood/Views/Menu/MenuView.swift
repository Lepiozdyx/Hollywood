//
//  MenuView.swift
//  Hollywood
//
//  Created by Alex on 23.12.2024.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack(spacing: 14) {
                    // MARK: RootView()
                    NavigationLink(destination: RootView()) {
                        ActionButtonView(
                            text: "LET'S GO",
                            fontSize: 26,
                            width: 220,
                            height: 90
                        )
                    }
                    
                    HStack {
                        // MARK: AbilityShopView()
                        NavigationLink(destination: AbilityShopView()) {
                            ActionButtonView(
                                text: "ABILITIES",
                                fontSize: 26,
                                width: 220,
                                height: 90
                            )
                        }
                        // MARK: RulesView()
                        NavigationLink(destination: EmptyView()) {
                            ActionButtonView(
                                text: "RULES",
                                fontSize: 26,
                                width: 220,
                                height: 90
                            )
                        }
                    }
                    
                    HStack {
                        // MARK: FactsView()
                        NavigationLink(destination: FactsView()) {
                            ActionButtonView(
                                text: "INTRESTING FACTS",
                                fontSize: 20,
                                width: 220,
                                height: 90
                            )
                        }
                        // MARK: SettingsView()
                        NavigationLink(destination: SettingsView()) {
                            ActionButtonView(
                                text: "SETTINGS",
                                fontSize: 26,
                                width: 220,
                                height: 90
                            )
                        }
                    }
                }
                .padding()
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            SoundService.shared.updateMusicState()
        }
    }
}

#Preview {
    MenuView()
}
