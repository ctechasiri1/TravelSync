//
//  ToastViewModifier.swift
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
    
    func body(content: Content) -> some View {
        content
            .overlay {
                Group {
                    VStack {
                        switch toastOption {
                        case .success:
                            SuccessView(text: text)
                                .transition(.move(edge: .top))
                        case .failure:
                            FailureView(text: text)
                                .transition(.move(edge: .top))
                        case .idle:
                            EmptyView()
                                .transition(.opacity)
                        }
                        
                        Spacer()
                    }
                }
                .animation(.easeInOut, value: toastOption)
            }
            .task(id: toastOption) {
                // don't run the timer if the option is .idle
                if toastOption == .idle { return }
                
                // run the timer for 1.5 seconds
                try? await Task.sleep(for: .seconds(1.5))
                
                // if the task is not cancelled then set it back to .idle
                if !Task.isCancelled {
                    withAnimation(.smooth) {
                        self.toastOption = .idle
                    }
                }
            }
    }
}

private struct SuccessView: View {

    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.accentConfirmation)
            
            Text("Success: " + text)
                .foregroundStyle(.black)
        }
        .padding()
        .font(.system(size: 12, weight: .semibold))
        .toastStyle()
    }
}

private struct FailureView: View {

    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "x.circle.fill")
                .foregroundStyle(.accentWarning)
            
            Text("Error: " + text)
                .foregroundStyle(.black.opacity(0.8))
        }
        .toastStyle()
    }
}

extension View {
    func toastStyle() -> some View {
        self
            .padding(4)
            .font(.system(size: 12, weight: .semibold))
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.white)
                    .stroke(
                        Color.secondaryText.opacity(0.2),
                        style: StrokeStyle(lineWidth: 0.5)
                    )
            )
    }
    
    func showToast(toastOption: Binding<ToastOption>, text: String) -> some View {
        modifier(Toast(toastOption: toastOption, text: text))
    }
}
