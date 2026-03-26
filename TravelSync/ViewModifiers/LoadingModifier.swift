//
//  LoadingModifier.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/25/26.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 3 : 0)
            
            if isLoading {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2.0)
                        .padding(40)
                        .background(Color.secondary.colorInvert())
                        .foregroundStyle(Color.primary)
                        .cornerRadius(16)
                        .shadow(radius: 10)
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isLoading)
    }
}

//#Preview {
//    LoadingModifier(isLoading: true)
//}
