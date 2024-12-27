//
//  RootView.swift
//  Hollywood
//
//  Created by Alex on 24.12.2024.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()
            
            HStack {
                BackButtonView()
                Spacer()
            }
            .padding()
            
            VStack(spacing: 14) {
                Text("GAME SELECTION")
                    .customfont(22)
                
                Spacer()
                
                NavigationLink(destination: PopularPhrasesView()) {
                    ActionButtonView(
                        text: "POPULAR PHRASES",
                        fontSize: 18,
                        width: 240,
                        height: 100
                    )
                }
                
                NavigationLink(destination: MoviePicturesView()) {
                    ActionButtonView(
                        text: "MOVIE PICTURES",
                        fontSize: 18,
                        width: 240,
                        height: 100
                    )
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RootView()
}
