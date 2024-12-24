//
//  BackgroundView.swift
//  Hollywood
//
//  Created by Alex on 23.12.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image(.banner)
            .resizable()
            .ignoresSafeArea()
            .overlay {
                Color.radialBlue.opacity(0.8).ignoresSafeArea()
            }
            .blur(radius: 1)
    }
}

#Preview {
    BackgroundView()
}
