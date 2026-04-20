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
        Group {
            switch appState.currentAuthScreen {
            case .loading:
                LoadingScreen()
            case .signUp:
                SignUpScreen(viewModel: appState.makeSignUpViewModel())
            case .login:
                LoginScreen(viewModel: appState.makeLoginViewModel())
            case .home:
                HomeScreen()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: appState.currentAuthScreen)
    }
}

#Preview {
    ContentView()
        .environment(AppState())
}
