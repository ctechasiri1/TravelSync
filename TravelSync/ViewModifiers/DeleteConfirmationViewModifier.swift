//
//  DeleteConfirmationViewModifier.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/3/26.
//

import SwiftUI

struct DeleteConfirmationViewModifier: ViewModifier {
    @Binding var showDeleteConfirmation: Bool
    let deleteAction: () -> Void
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(showDeleteConfirmation)
                .blur(radius: showDeleteConfirmation ? 3 : 0)
        
            if showDeleteConfirmation {
                ZStack {
                    Color.gray.opacity(0.1)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showDeleteConfirmation = false
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
                            MultipurposeButton(
                                text: "Cancel",
                                foregroundColor: .accentPrimary,
                                backgroundColor: .secondaryBackground.opacity(0.8)) {
                                    showDeleteConfirmation = false
                                }
                            
                            MultipurposeButton(
                                text: "Delete",
                                foregroundColor: .white,
                                backgroundColor: .accentPrimary) {
                                    deleteAction()
                                    showDeleteConfirmation = false
                                }
                        }
                        .font(.system(size: 12, weight: .semibold))
                    }
                    .padding(25)
                    .createCardBackgroud()
                    .padding()
                }
                .transition(.opacity)
            }
        }
    }
}

extension View {
    func confirmDelete(showDeleteConfirmation: Binding<Bool>, onDelete: @escaping () -> Void) -> some View {
        modifier(
            DeleteConfirmationViewModifier(
                showDeleteConfirmation: showDeleteConfirmation,
                deleteAction: onDelete
            )
        )
    }
}

