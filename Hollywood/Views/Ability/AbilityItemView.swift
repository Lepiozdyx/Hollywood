//
//  AbilityItemView.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import SwiftUI

struct AbilityItemView: View {
    let ability: AbilityType
    let purchasedCount: Int
    let userCoins: Int
    let action: () -> Void
    
    private var canPurchase: Bool {
        userCoins >= ability.price
    }
    
    var body: some View {
        Image(.textUnderlay)
            .resizable()
            .frame(maxWidth: 220, maxHeight: 210)
            .overlay(alignment: .topTrailing) {
                // Purchased Count
                if purchasedCount > 0 {
                    Text("x\(purchasedCount)")
                        .customfont(16)
                        .padding(6)
                        .background(
                            Capsule()
                                .foregroundStyle(.red)
                                .frame(width: 60)
                        )
                        .offset(y: -5)
                }
            }
            .overlay {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        HStack {
                            Text(ability.abilityName)
                                .customfont(20)
                            
                            Image(systemName: "star.fill")
                                .shadow(color:.black, radius: 2, x: 2, y: 2)
                                .font(.system(size: 16))
                                .foregroundStyle(.yellow)
                            
                            Text("\(ability.price)")
                                .customfont(14)
                        }
                        
                        Text(ability.abilityDescription)
                            .customfont(12)
                    }
                    
                    // Buy Button
                    Button {
                        action()
                    } label: {
                        ActionButtonView(
                            text: "BUY",
                            fontSize: 18,
                            width: 160,
                            height: 60
                        )
                    }
                    .disabled(!canPurchase)
                    .opacity(canPurchase ? 1 : 0.6)
                }
            }
    }
}

#Preview {
    AbilityItemView(ability: .fiftyfifty, purchasedCount: 1, userCoins: 10, action: {})
}
