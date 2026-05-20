//
//  LoadingModifier.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/25/26.
//

import Lottie
import SwiftUI

struct LoadingModifier: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 4 : 0)
            
            if isLoading {
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
        .animation(.easeInOut(duration: 0.2), value: isLoading)
    }
}

extension View {
    func showLoading(isLoading: Bool) -> some View {
        modifier(LoadingModifier(isLoading: isLoading))
    }
}
