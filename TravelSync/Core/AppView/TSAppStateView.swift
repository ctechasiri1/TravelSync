//
//  TSAppStateView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/26/26.
//

import SwiftUI

struct TSAppStateView: View {
    @Environment(TSAuthState.self) private var authState
    @Environment(TSOverlayState.self) private var overlayState
    
    var body: some View {
        Group {
            switch authState.currentAuthScreen {
            case .loading:
                LoadingView()
                    .transition(.blurReplace)
            case .signUp:
                TSSignUpView(viewModel: viewModelFactory.makeSignUpViewModel())
                    .transition(.move(edge: authState.prevAuthScreen == .login ? .leading : .trailing))
            case .login:
                TSLoginView(viewModel: viewModelFactory.makeLoginViewModel())
                    .transition(.move(edge: authState.prevAuthScreen == .loading ? .leading : (authState.hasBooted ? .leading : .trailing)))
                    .onAppear {
                        authState.setHasBooted(to: true)
                    }
            case .home:
                TSTabBarView()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.smooth, value: authState.currentAuthScreen)
        .showToast(for:
                    Binding(
                        get: { overlayState.toastOption },
                        set: { _ in overlayState.hideToast() }
                    )
        )
        .showLoading(for: overlayState.isLoading)
    }
}

#Preview {
    TSAppStateView()
        .environment(appState)
        .environment(viewModelFactory)
}
