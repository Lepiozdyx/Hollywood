//
//  FactsView.swift
//  Hollywood
//
//  Created by Alex on 27.12.2024.
//

import SwiftUI

struct FactsView: View {
    @StateObject private var vm = FactsViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()
            
            // Top bar with back button
            HStack {
                BackButtonView()
                Spacer()
            }
            .padding()
            
            VStack {
                Spacer()
                
                if let fact = vm.currentFact {
                    
                    VStack {
                        Image(fact.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 250)
                        
                        VStack(spacing: 10) {
                            Text(fact.title)
                                .customfont(22)
                            
                            Text(fact.description)
                                .customfont(18)
                        }
                        .frame(maxHeight: 150)
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Navigation buttons
                    HStack {
                        Button {
                            vm.previousFact()
                        } label: {
                            Image(.circle)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .overlay {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 30))
                                        .foregroundStyle(.blue2)
                                }
                        }
                        .disabled(!vm.canGoPrevious)
                        .opacity(vm.canGoPrevious ? 1 : 0.5)
                        
                        Spacer()
                        
                        Button {
                            vm.nextFact()
                        } label: {
                            Image(.circle)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .overlay {
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 30))
                                        .foregroundStyle(.blue2)
                                }
                        }
                        .disabled(!vm.canGoNext)
                        .opacity(vm.canGoNext ? 1 : 0.5)
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            vm.onAppear()
        }
    }
}

#Preview {
    FactsView()
}
