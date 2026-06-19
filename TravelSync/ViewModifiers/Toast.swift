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

    @State private var remainingTime = 3.0
    func body(content: Content) -> some View {
        content
            .overlay {
                Group {
                    VStack {
                        switch toastOption {
                        case .success:
                            SuccessView(remainingTime: $remainingTime, toastOption: $toastOption, text: text)
                                .transition(.move(edge: .top))
                        case .failure:
                            FailureView(remainingTime: $remainingTime, toastOption: $toastOption, text: text)
                                .transition(.move(edge: .top))
                        case .idle:
                            EmptyView()
                                .transition(.move(edge: .bottom))
                        }
                        
                        Spacer()
                    }
                }
                .animation(.smooth, value: toastOption)
            }
    }
}

private struct SuccessView: View {
    @Binding var remainingTime: Double
    @Binding var toastOption: ToastOption
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.accentConfirmation)
            
            Text(text + " successful")
                .foregroundStyle(.black)
        }
        .padding()
        .font(.system(size: 12, weight: .semibold))
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
                .stroke(
                    Color.secondaryText.opacity(0.2),
                    style: StrokeStyle(lineWidth: 0.5)
                )
        )
        .onReceive(
            Timer
                .publish(every: 0.2, on: .main, in: .default)
                .autoconnect()
        ) { _ in
            remainingTime -= 0.2
            if remainingTime <= 0 {
                withAnimation(.easeInOut) {
                    toastOption = .idle
                }
                remainingTime = 3.0
            }
        }
    }
}

private struct FailureView: View {
    @Binding var remainingTime: Double
    @Binding var toastOption: ToastOption
    let text: String
    var body: some View {
        HStack {
            Image(systemName: "x.circle.fill")
                .foregroundStyle(.accentWarning)
            
            Text(text)
                .foregroundStyle(.black.opacity(0.8))
        }
        .padding()
        .font(.system(size: 12, weight: .semibold))
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
                .stroke(
                    Color.secondaryText.opacity(0.2),
                    style: StrokeStyle(lineWidth: 0.5)
                )
        )
        .onReceive(
            Timer
                .publish(every: 0.2, on: .main, in: .default)
                .autoconnect()
        ) { _ in
            remainingTime -= 0.2
            if remainingTime <= 0 {
                withAnimation(.easeInOut) {
                    toastOption = .idle
                }
                remainingTime = 3.0
            }
        }
    }
}

extension View {
    func showToast(toastOption: Binding<ToastOption>, text: String) -> some View {
        modifier(Toast(toastOption: toastOption, text: text))
    }
}
