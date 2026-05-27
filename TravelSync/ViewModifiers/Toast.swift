//
//  Toast.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/23/26.
//

import Combine
import SwiftUI

enum ToastOption {
    case success, failure, idle
}

struct Toast: ViewModifier {
    @Binding var toastOption: ToastOption
    let text: String

    @State private var remaining = 3.0
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                VStack {
                    switch toastOption {
                    case .success:
                        HStack {
                            Image(systemName: "checkmark.circle")
                            
                            Text(text + " successful")
                        }
                        .padding()
                        .foregroundStyle(.white)
                        .font(.system(size: 12, weight: .semibold))
                        .background(.accentConfirmation.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .onReceive(
                            Timer
                                .publish(every: 0.2, on: .main, in: .default)
                                .autoconnect()
                        ) { _ in
                            self.remaining -= 0.2
                            if self.remaining <= 0 {
                                withAnimation(.easeInOut) {
                                    toastOption = .idle
                                }
                                self.remaining = 3.0
                            }
                        }
                    case .failure:
                        HStack {
                            Image(systemName: "x.circle.fill")
                            
                            Text(text)
                        }
                        .padding()
                        .foregroundStyle(.white)
                        .font(.system(size: 12, weight: .semibold))
                        .background(.accentWarning.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .onReceive(
                            Timer
                                .publish(every: 0.2, on: .main, in: .default)
                                .autoconnect()
                        ) { _ in
                            self.remaining -= 0.2
                            if self.remaining <= 0 {
                                withAnimation(.easeInOut) {
                                    toastOption = .idle
                                }
                                self.remaining = 3.0
                            }
                        }
                    case .idle:
                        EmptyView()
                    }
                    Spacer()
                }
            }
    }
}

extension View {
    func showToast(toastOption: Binding<ToastOption>, text: String) -> some View {
        modifier(Toast(toastOption: toastOption, text: text))
    }
}
