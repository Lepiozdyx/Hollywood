//
//  ContentView.swift
//  Hollywood
//
//  Created by Alex on 23.12.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        Group {
            switch vm.appState {
            case .loading:
                LoadingView()
            case .webView:
                if let url = vm.networkService.checkedURL {
                    WebViewService(url: url, networkService: vm.networkService)
                } else {
                    WebViewService(url: NetworkService.initialURL, networkService: vm.networkService)
                }
            case .mainMenu:
                MenuView()
            }
        }
        .onAppear {
            vm.onAppear()
        }
    }
}

#Preview {
    ContentView()
}
