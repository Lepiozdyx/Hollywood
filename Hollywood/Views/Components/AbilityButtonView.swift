//
//  AbilityButtonView.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import SwiftUI

struct AbilityButtonView: View {
    let ability: Ability
    let action: () -> ()
    
    var body: some View {
        Button {
            if ability.count > 0 && !ability.isActive {
                action()
                SoundService.shared.playSound()
            }
        } label: {
            Image(.circle)
                .resizable()
                .frame(width: 50, height: 50)
                .overlay {
                    Text(ability.type.abilityName)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue2)
                        .font(.system(size: 12))
                }
                .opacity(ability.count > 0 && !ability.isActive ? 1 : 0.6)
        }
        .disabled(ability.count == 0 || ability.isActive)
        .overlay(alignment: .bottomTrailing) {
            if ability.count > 0 {
                Text("\(ability.count)")
                    .customfont(14)
                    .padding(4)
                    .background(
                        Circle()
                            .foregroundStyle(.red.opacity(0.5))
                    )
                    .offset(x: 10, y: 10)
            }
        }
    }
}

#Preview {
    AbilityButtonView(ability: Ability(type: .fiftyfifty, count: 1, isActive: false), action: {})
}
