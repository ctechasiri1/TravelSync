//
//  AppStateView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/26/26.
//

import SwiftUI

struct AppStateView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        Group {
            switch appState.currentAuthScreen {
            case .loading:
                LoadingView()
            case .signUp:
                SignUpView(viewModel: appState.makeSignUpViewModel())
                    .transition(.move(edge: .trailing))
            case .login:
                LoginView(viewModel: appState.makeLoginViewModel())
                    .transition(.move(edge: appState.prevAuthScreen == nil ? .leading : .trailing))
            case .home:
                TabBarView()
                    .transition(.blurReplace)
            }
        }
        .animation(.smooth, value: appState.currentAuthScreen)
    }
}

#Preview {
    AppStateView()
        .environment(AppState())
}
