//
//  MultipurposeButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import SwiftUI

struct MultipurposeButton: View {
    let buttonImageString: String?
    let buttonText: String
    let isLoading: Bool?
    let foregroundColor: Color
    let backgroundColor: Color
    let onButtonPressed: () -> Void
    
    @State private var isButtonPressed: Bool = false
    
    init(
        buttonImageString: String? = nil,
        buttonText: String,
        isLoading: Bool? = nil,
        foregroundColor: Color,
        backgroundColor: Color,
        onButtonPressed: @escaping () -> Void,
    ) {
        self.buttonImageString = buttonImageString
        self.buttonText = buttonText
        self.isLoading = isLoading
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.onButtonPressed = onButtonPressed
    }

    var body: some View {
        Button {
            onButtonPressed()
        } label: {
            HStack {
                if let isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    if let imageString = buttonImageString {
                        Image(systemName: imageString)
                            .foregroundStyle(foregroundColor)
                    }
                    
                    Text(buttonText)
                }
            }
            .applyButtonStyle(foregroundColor: foregroundColor, backgroundColor: backgroundColor)
            .scaleEffect(isButtonPressed ? 0.90 : 1.0)
            .onLongPressGesture {
                isButtonPressed.toggle()
            } onPressingChanged: { pressing in
                isButtonPressed = pressing
            }
            .shadow(color: .gray.opacity(0.2), radius: 5, x: 1, y: 2)
        }
    }
}

#Preview {
    MultipurposeButton(
        buttonText: "Login",
        foregroundColor: .accentPrimary,
        backgroundColor: .white,
        onButtonPressed: {
        })
}
