//
//  ButtonStyle.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/18/26.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    let foregroundColor: Color
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(.subheadline, weight: .semibold))
            .padding()
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

extension View {
    func applyButtonStyle(foregroundColor: Color, backgroundColor: Color) -> some View {
        modifier(ButtonStyle(foregroundColor: foregroundColor, backgroundColor: backgroundColor))
    }
}
