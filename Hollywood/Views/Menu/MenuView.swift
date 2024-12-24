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
                        // MARK: ShopView()
                        NavigationLink(destination: EmptyView()) {
                            ActionButtonView(
                                text: "SHOP",
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
                        NavigationLink(destination: EmptyView()) {
                            ActionButtonView(
                                text: "INTRESTING FACTS",
                                fontSize: 20,
                                width: 220,
                                height: 90
                            )
                        }
                        // MARK: SettingsView()
                        NavigationLink(destination: EmptyView()) {
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
    }
}

#Preview {
    MenuView()
}
