//
//  TextButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/18/26.
//

import SwiftUI

struct TextButton: View {
    
    let text: String
    let fontStyle: Font.TextStyle
    let foregroundColor: Color
    let backgroundColor: Color
    let action: () -> Void
    
    init(
        text: String,
        fontStyle: Font.TextStyle = .subheadline,
        foregroundColor: Color = .accentPrimary,
        backgroundColor: Color = .clear,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.fontStyle = fontStyle
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    var body: some View {
        Text(text)
            .font(.system(fontStyle, weight: .semibold))
            .styledButton(
                buttonStyle: .text,
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor) {
                    action()
                }
    }
}

#Preview {
    TextButton(
        text: "Login",
        foregroundColor: .accentPrimary,
        backgroundColor: .clear
    ) {
 
    }
}
