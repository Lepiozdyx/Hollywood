//
//  SwitchButtonView.swift
//  Hollywood
//
//  Created by Alex on 27.12.2024.
//

import SwiftUI

struct SwitchButtonView: View {
    let image: ImageResource
    let isOn: Bool
    let size: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Image(image)
                    .resizable()
                    .frame(width: size, height: size)
                    .opacity(isOn ? 1 : 0.5)
                
                Text(isOn ? "ON" : "OFF")
                    .customfont(14)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SwitchButtonView(
        image: .music,
        isOn: true,
        size: 50,
        action: {}
    )
}
