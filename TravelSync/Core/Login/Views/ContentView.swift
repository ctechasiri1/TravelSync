//
//  ContentView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/26/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        let loginViewModel = appState.login
        
        Group {
            switch loginViewModel.loginAppState {
            case .loading:
                LoadingScreen()
            case .signUp:
                SignUpScreen()
            case .login:
                LoginScreen()
            case .home:
                HomeScreen()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AppState())
}
