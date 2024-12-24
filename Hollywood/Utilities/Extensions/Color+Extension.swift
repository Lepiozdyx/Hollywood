//
//  Color+Extension.swift
//  Hollywood
//
//  Created by Alex on 23.12.2024.
//

import SwiftUI

extension Color {
    static let radialBlue = RadialGradient(
        colors: [.blue, .blue1, .blue2],
        center: .center,
        startRadius: 0,
        endRadius: 400
    )
}

struct Color_Extension: View {
    var body: some View {
        ZStack {
            Image(.banner)
                .resizable()
                .ignoresSafeArea()
            
            Color.radialBlue
                .opacity(0.8)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    Color_Extension()
}
