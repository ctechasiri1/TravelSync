//
//  LoadingViewModifier.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/25/26.
//

import Lottie
import SwiftUI

struct LoadingViewModifier: ViewModifier {
    
    @Environment(TSAppState.self) private var appState
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(appState.isLoading)
                .blur(radius: appState.isLoading ? 4 : 0)
                
            if appState.isLoading {
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
        .animation(.easeInOut(duration: 0.2), value: appState.isLoading)
    }
}

extension View {
    func showLoading() -> some View {
        modifier(LoadingViewModifier())
    }
}
