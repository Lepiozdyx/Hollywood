//
//  BackButtonView.swift
//  Hollywood
//
//  Created by Alex on 24.12.2024.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Button {
            dismiss()
            SoundService.shared.playSound()
        } label: {
            Image(.backArrow)
                .resizable()
                .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    BackButtonView()
}
