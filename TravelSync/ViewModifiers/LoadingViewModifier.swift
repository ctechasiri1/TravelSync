//
//  LoadingViewModifier.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/25/26.
//

import Lottie
import SwiftUI

struct LoadingViewModifier: ViewModifier {
    
    @Environment(AppState.self) private var appState
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(appState.loadingManager.isLoading)
                .blur(radius: appState.loadingManager.isLoading ? 4 : 0)
                
            if appState.loadingManager.isLoading {
                    ZStack {
                        Color.gray.opacity(0.09)
                            .ignoresSafeArea()
                        
                        LottieView(animation: .named("travelsync-loading"))
                            .playing(loopMode: .loop)
                            .resizable()
                            .foregroundStyle(.accentPrimary)
                            .frame(width: 150, height: 150)
                    }
                    .transition(.opacity)
                }
        }
        .animation(.easeInOut(duration: 0.2), value: appState.loadingManager.isLoading)
    }
}

extension View {
    func showLoading() -> some View {
        modifier(LoadingViewModifier())
    }
}
