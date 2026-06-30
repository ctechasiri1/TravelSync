//
//  ButtonViewModifiers.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/25/26.
//

import SwiftUI

enum ButtonStyleOption {
    case filled, text
}

struct FilledButtonStyle: ButtonStyle {
    
    let foregroundColor: Color
    let backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor)
            .font(.system(.subheadline, weight: .semibold))
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.smooth, value: configuration.isPressed)
    }
}

struct TextButtonStyle: ButtonStyle {
    
    let foregroundColor: Color
    let backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.subheadline, weight: .semibold))
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .underline()
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.smooth, value: configuration.isPressed)
    }
}

extension View {
    @ViewBuilder
    func styledButton(buttonStyle: ButtonStyleOption, foregroundColor: Color = .black, backgroundColor: Color = .clear, action: @escaping () -> Void) -> some View {
        switch buttonStyle {
        case .filled:
            filledButton(
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
                action: action
            )
        case .text:
            textButton(
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
                action: action
            )
        }
    }
    
    private func filledButton(foregroundColor: Color, backgroundColor: Color, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(
            FilledButtonStyle(
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor
            )
        )
    }
    
    private func textButton(foregroundColor: Color, backgroundColor: Color, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(
            TextButtonStyle(
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor
            )
        )
    }
}



#Preview {
    HStack {
        Image(systemName: "star")
        
        Text("Hello world!")
    }.styledButton(buttonStyle: .text, action: {
        
    })
    .padding()
}
