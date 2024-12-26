//
//  AbilityShopView.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import SwiftUI

struct AbilityShopView: View {
    @StateObject private var vm = AbilityShopViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()
            
            HStack(alignment: .top) {
                BackButtonView()
                Spacer()
                StarUnderlayView(stars: "\(vm.gameState.stars)")
            }
            .padding()
            
            VStack {
                Spacer()
                HStack(spacing: 20) {
                    ForEach(AbilityType.allCases, id: \.self) { ability in
                        AbilityItemView(
                            ability: ability,
                            purchasedCount: vm.getAbilityCount(ability),
                            userCoins: vm.gameState.stars,
                            action: { vm.buyAbility(ability) }
                        )
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
        .alert("WELCOME!", isPresented: $vm.showWelcomeAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Here's a gift of 50 stars to get you started!")
                .customfont(14)
        }
        .onAppear {
            vm.onAppear()
        }
    }
}

#Preview {
    AbilityShopView()
}
