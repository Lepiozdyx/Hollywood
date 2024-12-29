//
//  RulesView.swift
//  Hollywood
//
//  Created by Alex on 27.12.2024.
//

import SwiftUI

struct RulesView: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()
            
            HStack {
                BackButtonView()
                Spacer()
            }
            .padding()
           
            ScrollView(.vertical) {
                Text("In this game, players must guess movies based on popular phrases and descriptions of the films. The game also features interesting facts about Hollywood's film industry. \nThe goal of the game is to score as many points as possible by answering questions correctly and learning more about cinema. \nDuring the game, correctly answering the questions, you will earn Hollywood stars. Stars will be taken away for each wrong answer.\nIn the abilities menu, you can purchase abilities that will give you an advantage during the game.")
                    .customfont(16)
            }
            .padding(.top, 60)
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RulesView()
}
