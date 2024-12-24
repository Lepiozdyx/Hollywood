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
            
            HStack {
                BackButtonView()
                Spacer()
            }
            .padding()
            
            VStack {
                Text("POPULAR PHRASES")
                    .customfont(28)
                
                Spacer()
                
                Image(.textUnderlay)
                    .resizable()
                    .frame(maxWidth: 450, maxHeight: 200)
                    .overlay(alignment: .topTrailing) {
                        // Stars counter
                        StarUnderlayView(stars: "50")
                            .offset(x: 5, y: -5)
                    }
                    .overlay {
                        // Phrase
                        Text("MAY THE FORCE BE WITH YOU")
                            .customfont(20)
                            .padding(.top)
                    }
                
                // Buttons Grid
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(0..<4) { _ in
                        Button {
                            // answer the question action
                        } label: {
                            ActionButtonView(
                                text: "ANSWER",
                                fontSize: 26,
                                width: 220,
                                height: 90
                            )
                        }
                    }
                }
                .frame(maxWidth: 450)
                
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
