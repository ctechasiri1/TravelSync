//
//  TextButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/18/26.
//

import SwiftUI

struct TextButton: View {
    
    let text: String
    let foregroundColor: Color
    let backgroundColor: Color
    let action: () -> Void
    
    init(
        text: String,
        foregroundColor: Color = .accentPrimary,
        backgroundColor: Color = .clear,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    var body: some View {
        Text(text)
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
