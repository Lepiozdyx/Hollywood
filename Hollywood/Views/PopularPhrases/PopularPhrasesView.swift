//
//  PopularPhrasesView.swift
//  Hollywood
//
//  Created by Alex on 24.12.2024.
//

import SwiftUI

struct PopularPhrasesView: View {
    @StateObject private var vm = PopularPhrasesViewModel()
    
    private let buttonAnimation = Animation.easeInOut(duration: 0.3)
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 10),
        count: 2
    )
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()
            
            // MARK: Top Bar with Back Button and Stars
            HStack(alignment: .top) {
                BackButtonView()
                Spacer()
                StarUnderlayView(stars: "\(vm.gameState.stars)")
            }
            .padding()
            
            VStack {
                Spacer()
                
                Image(.textUnderlay)
                    .resizable()
                    .frame(maxWidth: 450, maxHeight: 180)
                    .overlay {
                        if let quote = vm.currentQuote {
                            Text(quote.text.uppercased())
                                .customfont(18)
                                .transition(.opacity)
                                .padding()
                        }
                    }
                    .overlay(alignment: .bottomTrailing) {
                        // MARK: Ability buttons
                        HStack {
                            ForEach(vm.gameState.abilities) { ability in
                                AbilityButtonView(ability: ability) {
                                    vm.useAbility(ability.type)
                                }
                            }
                        }
                        .offset(x: -10, y: 16)
                    }
                
                Spacer()
                
                // MARK: Buttons Grid
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(vm.currentOptions, id: \.self) { option in
                        Button {
                            withAnimation(buttonAnimation) {
                                vm.handleAnswer(option)
                            }
                        } label: {
                            ActionButtonView(
                                text: option.uppercased(),
                                fontSize: 18,
                                width: 200,
                                height: 75
                            )
                        }
                        .disabled(vm.disabledAnswerButtons.contains(option))
                        .opacity(vm.disabledAnswerButtons.contains(option) ? 0.6 : 1)
                        .modifier(AnswerButtonModifier(
                            option: option,
                            correctAnswer: vm.currentQuote?.correctAnswer,
                            selectedAnswer: vm.selectedAnswer,
                            showWrongAnimation: vm.showWrongAnswerAnimation,
                            showCorrectAnimation: vm.showCorrectAnswerAnimation
                        ))
                    }
                }
                .frame(maxWidth: 450)
                .padding(.top)
                
                Spacer()
            }
            .padding()
            
            // MARK: Game Over view
            if vm.isGameOver {
                GameOverView { vm.resetGame() }
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            vm.onAppear()
        }
    }
}

#Preview {
    PopularPhrasesView()
}

// MARK: Custom modifier for answer button animations
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
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.red, lineWidth: 2)
                            .scaleEffect(1.05)
                    } else if showCorrectAnimation {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.green, lineWidth: 2)
                            .scaleEffect(1.05)
                    }
                }
            }
    }
}
