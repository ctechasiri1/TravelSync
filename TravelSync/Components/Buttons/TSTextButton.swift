//
//  TSTextButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/18/26.
//

import SwiftUI

struct TSTextButton: View {
    
    let title: String
    let fontStyle: Font.TextStyle
    let foregroundColor: Color
    let backgroundColor: Color
    let action: () -> Void
    
    init(title: String, fontStyle: Font.TextStyle = .subheadline, foregroundColor: Color = .accentPrimary, backgroundColor: Color = .clear, action: @escaping () -> Void) {
        self.title = title
        self.fontStyle = fontStyle
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    var body: some View {
        Text(title)
            .font(.system(fontStyle, weight: .semibold))
            .styledButton(buttonStyle: .text, foregroundColor: foregroundColor, backgroundColor: backgroundColor) {
                action()
            }
    }
}

#Preview("Login Button") {
    TSTextButton(title: "Login", foregroundColor: .accentPrimary, backgroundColor: .clear) { }
}
