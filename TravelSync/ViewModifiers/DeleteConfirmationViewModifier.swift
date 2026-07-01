//
//  DeleteConfirmationViewModifier.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/3/26.
//

import SwiftUI

struct DeleteConfirmationViewModifier: ViewModifier {
    
    @Environment(AppState.self) var appState
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(appState.loadingManager.isLoading)
                .blur(radius: appState.loadingManager.isLoading ? 4 : 0)
            
            if appState.deleteConfirmationManager.isPresented {
                ZStack {
                    Color.gray.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            appState.deleteConfirmationManager.hide()
                        }
                    
                    VStack {
                        VStack(spacing: 10){
                            if let title = appState.deleteConfirmationManager.title {
                                Text(title)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(.accentPrimary)
                            }
                            
                            if let description = appState.deleteConfirmationManager.description {
                                Text(description)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 300)
                                    .font(.system(size: 14))
                            }
                        }
                        .padding(.bottom, 20)
                        
                        HStack {
                            FillButton(
                                text: "Cancel",
                                foregroundColor: .accentPrimary,
                                backgroundColor: .secondaryBackground
                                    .opacity(0.8)) {
                                        appState.deleteConfirmationManager.hide()
                                    }
                            
                            FillButton(
                                text: "Delete") {
                                    appState.deleteConfirmationManager.deleteAction()
                                    appState.deleteConfirmationManager.hide()
                                }
                        }
                        .font(.system(size: 12, weight: .semibold))
                    }
                    .padding(25)
                    .cardBackground()
                    .padding()
                    
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: appState.loadingManager.isLoading)
    }
}

extension View {
    func deleteConfirmation() -> some View {
        modifier(DeleteConfirmationViewModifier())
    }
}

