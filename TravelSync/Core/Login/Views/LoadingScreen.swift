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
    @State private var progress: Double = 0.0
    
    var body: some View {
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
                        
                LinearProgressBar(value: progress, shape: RoundedRectangle(cornerRadius: 20))
                    .tint(.accentPrimary)
                    .frame(height: 10)
                    .padding(.horizontal, 110)
                
                Text("LOADING YOUR JOURNEY...")
                    .font(.system(.caption2))
                    .foregroundStyle(.secondaryText.opacity(0.6))
            }
        }
        .task {
            await runLoadingSequence()
        }
    }
    
    private func runLoadingSequence() async {
        while progress < 1.0 {
            try? await Task.sleep(for: .milliseconds(500))
            progress += 0.1
        }
        appState.navigate(to: .login)
    }
}

#Preview {
    LoadingScreen()
        .environment(AppState())
}
