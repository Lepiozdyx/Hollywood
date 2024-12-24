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
                Text("LETS'S GO")
                    .customfont(28)
                
                Spacer()
                // MARK: PopularPhrasesView()
                NavigationLink(destination: EmptyView()) {
                    ActionButtonView(
                        text: "POPULAR PHRASES",
                        fontSize: 20,
                        width: 240,
                        height: 100
                    )
                }
                
                // MARK: MoviesPicturesView()
                NavigationLink(destination: EmptyView()) {
                    ActionButtonView(
                        text: "MOVIE PICTURES DESCRIPTION",
                        fontSize: 20,
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