//
//  LoadingScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import Combine
import SwiftUI

struct LoadingScreen: View {
    @Environment(AppState.self) private var appState
    let dotColor = Color.gray.opacity(0.2)
    let dotSize: CGFloat = 3
    let spacing: CGFloat = 20
    let progressTotal: Float = 100
    
    var body: some View {
        @Bindable var loginViewModel = appState.login
        
        ZStack {
            Color.primaryBackground.opacity(0.1).edgesIgnoringSafeArea(.all)
                    
            VStack {
                Image("travel_sync_icon")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaledToFit()
                        
                VStack {
                    Text("TravelSync")
                        .font(.system(.largeTitle, weight: .bold))
                            
                    Text("Plan. Track. Explore.")
                        .font(.system(.headline, weight: .semibold))
                        .foregroundStyle(.secondaryText.opacity(0.6))
                }
                .padding(.bottom, 40)
                        
                LinearProgressBar(value: loginViewModel.loadingValue, shape: RoundedRectangle(cornerRadius: 20))
                    .tint(.accentPrimary)
                    .frame(height: 10)
                    .padding(.horizontal, 110)
                
                Text("LOADING YOUR JOURNEY...")
                    .font(.system(.caption2))
                    .foregroundStyle(.secondaryText.opacity(0.6))
            }
        }
        .onAppear {
            loginViewModel.startLoading()
        }
    }
}

#Preview {
    LoadingScreen()
        .environment(AppState())
}
