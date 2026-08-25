//
//  TSAppStateView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/26/26.
//

import SwiftUI

struct TSAppStateView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        Group {
            switch appState.currentAuthScreen {
            case .loading:
                LoadingView()
                    .transition(.blurReplace)
            case .signUp:
                SignUpView(viewModel: appState.makeSignUpViewModel())
                    .transition(.move(edge: appState.prevAuthScreen == .login ? .leading : .trailing))
            case .login:
                LoginView(viewModel: appState.makeLoginViewModel())
                    .transition(.move(edge: appState.prevAuthScreen == .loading ? .leading : (appState.hasBooted ? .leading : .trailing)))
                    .onAppear {
                        appState.hasBooted = true
                    }
            case .home:
                TabBarView()
                    .transition(.blurReplace)
            }
        }
        .animation(.smooth, value: appState.currentAuthScreen)
    }
}

#Preview {
    TSAppStateView()
        .environment(AppState())
}
