//
//  LoadingView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import Combine
import Lottie
import SwiftUI

struct LoadingView: View {
    @Environment(TSAppState.self) private var appState
    @State private var progress: Double = 0.0
    
    var body: some View {
        ZStack {
            Color.primaryBackground.opacity(0.1).edgesIgnoringSafeArea(.all)
                    
            VStack {
                Image(.travelSyncIcon)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaledToFit()
                        
                VStack {
                    Text(L10n.TSLoadingView.title)
                        .font(.system(.largeTitle, weight: .bold))
                            
                    Text(L10n.TSLoadingView.subtitle)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.secondaryText.opacity(0.6))
                }
                .padding(.bottom, 40)
                
                TSLinearProgressBar(progressValue: progress, barShape: RoundedRectangle(cornerRadius: 20))
                    .tint(.accentPrimary)
                    .frame(height: 10)
                    .padding(.horizontal, 110)
                
                Text(L10n.TSLoadingView.loadingText)
                    .font(.system(size: 10, weight: .semibold))
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
    LoadingView()
        .environment(TSAppState())
}
