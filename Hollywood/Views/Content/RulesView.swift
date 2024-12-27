//
//  RulesView.swift
//  Hollywood
//
//  Created by Alex on 27.12.2024.
//

import SwiftUI

struct RulesView: View {
    @StateObject private var ns = NetworkService()
    
    var body: some View {
        WebViewService(url: NetworkService.rulesURL, networkService: ns)
    }
}

#Preview {
    RulesView()
}
