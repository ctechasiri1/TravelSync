//
//  Toast.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/23/26.
//

import SwiftUI

enum ToastOption {
    case success, failure, idle
}

struct Toast: ViewModifier {
    let toastOption: ToastOption
    let text: String

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                switch toastOption {
                case .success:
                    HStack {
                        Image(systemName: "checkmark.circle")
                        
                        Text(text + " successful")
                    }
                    .padding()
                    .foregroundStyle(.accentConfirmation.opacity(0.5))
                    .background(.accentConfirmation.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                case .failure:
                    HStack {
                        Image(systemName: "x.circle")
                        
                        Text("Error " + text)
                    }
                    .padding()
                    .foregroundStyle(.accentWarning)
                    .background(.accentWarning.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                case .idle:
                    EmptyView()
                }
            }
    }
}

extension View {
    func showToast(toastOption: ToastOption, text: String) -> some View {
        modifier(Toast(toastOption: toastOption, text: text))
    }
}
