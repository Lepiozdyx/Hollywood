//
//  AnswerButtonModifier.swift
//  Hollywood
//
//  Created by Alex on 26.12.2024.
//

import SwiftUI

struct AnswerButtonModifier: ViewModifier {
    let option: String
    let correctAnswer: String?
    let selectedAnswer: String?
    let showWrongAnimation: Bool
    let showCorrectAnimation: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(
                (showWrongAnimation || showCorrectAnimation) &&
                selectedAnswer == option ? 0.95 : 1.0
            )
            .overlay {
                if selectedAnswer == option {
                    if showWrongAnimation {
                        Capsule()
                            .foregroundStyle(.red)
                            .opacity(0.4)
                            .shadow(color: .red, radius: 10)
                    } else if showCorrectAnimation {
                        Capsule()
                            .foregroundStyle(.green)
                            .opacity(0.3)
                            .shadow(color: .green, radius: 10)
                    }
                }
            }
    }
}
extension View {
    func answerButtonStyle(
        option: String,
        correctAnswer: String?,
        selectedAnswer: String?,
        showWrongAnimation: Bool,
        showCorrectAnimation: Bool
    ) -> some View {
        modifier(
            AnswerButtonModifier(
                option: option,
                correctAnswer: correctAnswer,
                selectedAnswer: selectedAnswer,
                showWrongAnimation: showWrongAnimation,
                showCorrectAnimation: showCorrectAnimation
            )
        )
    }
}
