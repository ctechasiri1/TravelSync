//
//  DeleteConfirmationViewModifier.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/3/26.
//

import SwiftUI

struct DeleteConfirmationViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    let deleteAction: () -> Void
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                ZStack {
                    Rectangle()
                        .fill(.ultraThickMaterial.opacity(0.8))
                        .ignoresSafeArea()
                        .onTapGesture {
                            dismissDeleteConformation()
                        }
                        
                    VStack {
                        VStack(spacing: 10){
                            Text("delete_trip_title")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.accentPrimary)
                                
                            Text("delete_trip_description")
                                .multilineTextAlignment(.center)
                                .frame(width: 300)
                                .font(.system(size: 14))
                        }
                        .padding(.bottom, 20)
                            
                        HStack {
                            FillButton(
                                text: "Cancel",
                                foregroundColor: .accentPrimary,
                                backgroundColor: .secondaryBackground.opacity(0.8)) {
                                    dismissDeleteConformation()
                                }
                            
                            FillButton(
                                text: "Delete") {
                                    deleteAction()
                                    dismissDeleteConformation()
                                }
                        }
                        .font(.system(size: 12, weight: .semibold))
                    }
                    .padding(25)
                    .cardBackground()
                    .padding()
                }
                .presentationBackground(.clear)
            }
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
    }
    
    private func dismissDeleteConformation() {
        isPresented = false
    }
}

extension View {
    func deleteConfirmation(isPresented: Binding<Bool>, onDelete: @escaping () -> Void) -> some View {
        modifier(
            DeleteConfirmationViewModifier(
                isPresented: isPresented,
                deleteAction: onDelete
            )
        )
    }
}

