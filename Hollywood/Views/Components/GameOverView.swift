//
//  GameOverView.swift
//  Hollywood
//
//  Created by Alex on 25.12.2024.
//

import SwiftUI

struct GameOverView: View {
    @Environment(\.dismiss) private var dismiss
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            
            Image(.textUnderlay)
                .resizable()
                .frame(maxWidth: 350, maxHeight: 300)
                .overlay {
                    VStack(spacing: 20) {
                        Text("GAME OVER")
                            .customfont(20)
                        
                        Text("GOOD JOB, BUDDY!")
                            .customfont(14)
                        
                        Button {
                            onTap()
                            dismiss()
                        } label: {
                            ActionButtonView(
                                text: "MENU",
                                fontSize: 20,
                                width: 200,
                                height: 75
                            )
                        }
                    }
                }
        }
    }
}

#Preview {
    GameOverView(onTap: {})
}
