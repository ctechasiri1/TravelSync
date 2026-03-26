//
//  LoadingStateScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/26/26.
//

import SwiftUI

struct LoadingStateScreen: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        let loginViewModel = appState.login
        
        Group {
            switch loginViewModel.loginAppState {
            case .loading:
                LoadingScreen()
            case .unauthenticated:
                LoginScreen()
            case .authenticated:
                HomeScreen()
            }
        }
        .task {
            await loginViewModel.checkUserAuthentication()
        }
    }
}

#Preview {
    LoadingStateScreen()
}
