//
//  AbilityShopView.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import SwiftUI

struct AbilityShopView: View {
    
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()
            
            HStack(alignment: .top) {
                BackButtonView()
                Spacer()
                StarUnderlayView(stars: "50")
            }
            .padding()
            
            VStack {
                Spacer()
                HStack(spacing: 20) {
                    ForEach(AbilityType.allCases, id: \.self) { ability in
                        AbilityItemView(
                            ability: ability,
                            purchasedCount: 1,
                            userCoins: 1,
                            action: {}
                        )
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AbilityShopView()
}
