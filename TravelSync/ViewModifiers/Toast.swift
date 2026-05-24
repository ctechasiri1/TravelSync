//
//  Toast.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/23/26.
//

import SwiftUI

enum ToastOption {
    case success, failure
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
                    .createCardBackgroud()
                case .failure:
                    HStack {
                        Image(systemName: "x.circle")
                        
                        Text(text + " successful")
                    }
                }
            }
    }
}

extension View {
    func showToast(toastOption: ToastOption, text: String) -> some View {
        modifier(Toast(toastOption: toastOption, text: text))
    }
}
