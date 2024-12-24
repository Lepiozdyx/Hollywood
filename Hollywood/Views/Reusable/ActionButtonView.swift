//
//  ActionButtonView.swift
//  Hollywood
//
//  Created by Alex on 23.12.2024.
//

import SwiftUI

struct ActionButtonView: View {
    let text: String
    let fontSize: CGFloat
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Image(.button)
            .resizable()
            .frame(maxWidth: width, maxHeight: height)
            .overlay {
                Text(text)
                    .customfont(fontSize)
                    .multilineTextAlignment(.center)
                    .padding()
            }
    }
}

#Preview {
    ActionButtonView(text: "SETTINGS", fontSize: 34, width: 240, height: 90)
}
