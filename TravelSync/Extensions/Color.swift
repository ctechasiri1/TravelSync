//
//  Color.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/31/25.
//

import SwiftUI

extension Color {
    static let backgroundColor = BackgroundColor()
    static let textColor = TextColor()
    static let accentColor = AccentColor()
    
}

struct BackgroundColor {
    let primaryBackground = Color("primaryBackground")
    let secondaryBackground = Color("secondaryBackground")
    let tertiaryBackground = Color("tertiaryBackground")
}

struct TextColor {
    let primaryText = Color("primaryText")
    let secondaryText = Color("secondaryText")
    let placeholderText: Color = Color("placeholderText")
}

struct AccentColor {
    let accentBlue = Color("accentBlue")
    let accentConfirmation = Color("accentConfirmation")
    let accentWarning: Color = Color("accentWarning")
}
