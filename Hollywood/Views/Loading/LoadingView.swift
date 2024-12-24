//
//  LoadingView.swift
//  Hollywood
//
//  Created by Alex on 23.12.2024.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Spacer()
                HStack(spacing: 20) {
                    ForEach(0..<3) { _ in
                        Image(.star)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaleEffect(isAnimating ? 1 : 0.95)
                            .shadow(color: .yellow, radius: isAnimating ? 10 : 0)
                            .animation(
                                .easeIn(duration: 0.5)
                                .repeatForever(autoreverses: true),
                                value: isAnimating
                            )
                    }
                }
                
                Spacer()
                Image(.loading)
                    .resizable()
                    .frame(width: 300, height: 50)
            }
            .padding()
        }
        .onAppear {
            isAnimating.toggle()
        }
    }
}

#Preview {
    LoadingView()
}
