//
//  DeleteConfirmationViewModifier.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/3/26.
//

import SwiftUI

enum ModalOption {
    case deleteConfirmation
    
    var title: String {
        switch self {
        case .deleteConfirmation:
            ""
        }
    }
    
    var description: String {
        switch self {
        case .deleteConfirmation:
            ""
        }
    }
    
    var button1Title: String {
        switch self {
        case .deleteConfirmation:
            "Cancel"
        }
    }
    
    var button2Title: String {
        switch self {
        case .deleteConfirmation:
            "Delete"
        }
    }
}

struct TSModal: ViewModifier {
    
    @Binding var isPresented: Bool
    let modalOption: ModalOption
    let button1Action: () -> Void
    let button2Action: () -> Void
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isPresented)
                .blur(radius: isPresented ? 4 : 0)
            
            if isPresented {
                ZStack {
                    BackdropView {
                        dismissModal()
                    }
                    
                    VStack {
                        VStack(spacing: 10) {
                            Text(modalOption.title)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.accentPrimary)
                            
                            Text(modalOption.description)
                                .multilineTextAlignment(.center)
                                .frame(width: 300)
                                .font(.system(size: 14))
                        }
                        .padding(.bottom, 20)
                        
                        HStack {
                            TSFillButton(title: modalOption.button1Title, foregroundColor: .accentPrimary, backgroundColor: .secondaryBackground.opacity(0.8)) {
                                button1Action()
                            }
                            
                            TSFillButton(title: modalOption.button2Title) {
                                button2Action()
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
        .animation(.easeInOut(duration: 0.2), value: isPresented)
    }
    
    func dismissModal() {
        isPresented = false
    }
}

extension View {
    func showModal(isPresented: Binding<Bool>, modalOption: ModalOption, button1Action: @escaping () -> Void, button2Action: @escaping () -> Void) -> some View {
        modifier(TSModal(isPresented: isPresented, modalOption: modalOption, button1Action: button1Action, button2Action: button2Action))
    }
}

