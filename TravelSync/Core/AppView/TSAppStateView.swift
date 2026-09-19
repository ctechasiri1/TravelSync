//
//  TSAppStateView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/26/26.
//

import SwiftUI

struct TSAppStateView: View {
    @Environment(TSAppState.self) private var appState
    @Environment(TSViewModelFactory.self) private var viewModelFactory
    
    var body: some View {
        Group {
            switch appState.currentAuthScreen {
            case .loading:
                LoadingView()
                    .transition(.blurReplace)
            case .signUp:
                TSSignUpView(viewModel: viewModelFactory.makeSignUpViewModel())
                    .transition(.move(edge: appState.prevAuthScreen == .login ? .leading : .trailing))
            case .login:
                TSLoginView(viewModel: viewModelFactory.makeLoginViewModel())
                    .transition(.move(edge: appState.prevAuthScreen == .loading ? .leading : (appState.hasBooted ? .leading : .trailing)))
                    .onAppear {
                        appState.setHasBooted(to: true)
                    }
            case .home:
                TSTabBarView()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.smooth, value: appState.currentAuthScreen)
        .showToast(for:
                    Binding(
                        get: { appState.toastOption },
                        set: { _ in appState.hideToast() }
                    )
        )
        .showLoading(for: appState.isLoading)
    }
}

#Preview {
    let appState: TSAppState = TSAppState()
    let viewModelFactory: TSViewModelFactory = TSViewModelFactory(appState: appState)
    
    TSAppStateView()
        .environment(appState)
        .environment(viewModelFactory)
}
