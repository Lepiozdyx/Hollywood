//
//  StarUnderlayView.swift
//  Hollywood
//
//  Created by Alex on 24.12.2024.
//

import SwiftUI

struct StarUnderlayView: View {
    let stars: String
    
    var body: some View {
        Image(.starUnderlay)
            .resizable()
            .frame(width: 110, height: 50)
            .overlay {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .shadow(color:.black, radius: 2, x: 2, y: 2)
                        .font(.system(size: 18))
                        .foregroundStyle(.yellow)
                    
                    Text("+\(stars)")
                        .customfont(18)
                }
            }
    }
}

#Preview {
    StarUnderlayView(stars: "50")
}
