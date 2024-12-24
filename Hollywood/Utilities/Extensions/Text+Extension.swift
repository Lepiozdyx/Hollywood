//
//  Text+Extension.swift
//  Hollywood
//
//  Created by Alex on 23.12.2024.
//

import SwiftUI

extension Text {
    func customfont(_ size: CGFloat) -> some View {
        self
            .foregroundStyle(.text1)
            .font(.system(size: size, weight: .black, design: .default))
            .multilineTextAlignment(.center)
            .shadow(color: .black, radius: 2, x: 1, y: 2)
    }
}
