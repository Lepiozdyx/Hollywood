//
//  MoviePicturesView.swift
//  Hollywood
//
//  Created by Alex on 26.12.2024.
//

import SwiftUI

struct MoviePicturesView: View {
    @StateObject private var vm = GameViewModel(dataService: PicturesService())
    
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
                    .frame(maxWidth: 450, maxHeight: 340)
                    .overlay {
                        if let item = vm.currentItem {
                            Image(item.displayContent)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .transition(.opacity)
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
                                fontSize: 14,
                                width: 200,
                                height: 75
                            )
                        }
                        .disabled(vm.isButtonDisabled(option))
                        .opacity(vm.getButtonOpacity(option))
                        .answerButtonStyle(
                            option: option,
                            correctAnswer: vm.currentItem?.correctAnswer,
                            selectedAnswer: vm.selectedAnswer,
                            showWrongAnimation: vm.showWrongAnswerAnimation,
                            showCorrectAnimation: vm.showCorrectAnswerAnimation
                        )
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
    MoviePicturesView()
}
