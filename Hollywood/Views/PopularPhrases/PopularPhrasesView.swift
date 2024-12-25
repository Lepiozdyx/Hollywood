//
//  PopularPhrasesView.swift
//  Hollywood
//
//  Created by Alex on 24.12.2024.
//

import SwiftUI

struct PopularPhrasesView: View {
    let columns = Array(repeating: GridItem(), count: 2)
    
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
                
                Image(.textUnderlay)
                    .resizable()
                    .frame(maxWidth: 450, maxHeight: 180)
                    .overlay {
                        // Phrase
                        Text("MAY THE FORCE BE WITH YOU")
                            .customfont(18)
                    }
                    .overlay(alignment: .bottomTrailing) {
                        // Ability buttons
                        HStack {
                            AbilityButtonView(ability: Ability.init(type: .fiftyfifty, count: 3, isActive: false)) {}
                            
                            AbilityButtonView(ability: Ability.init(type: .righttomakeamistake, count: 0, isActive: true)) {}
                        }
                        .offset(x: -10, y: 16)
                    }
                
                Spacer()
                
                // Buttons Grid
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(0..<4) { _ in
                        Button {
                            // answer the question action
                        } label: {
                            ActionButtonView(
                                text: "ANSWER",
                                fontSize: 18,
                                width: 200,
                                height: 75
                            )
                        }
                    }
                }
                .frame(maxWidth: 450)
                .padding(.top)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PopularPhrasesView()
}
