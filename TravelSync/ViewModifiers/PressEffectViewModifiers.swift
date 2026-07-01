//
//  PressEffectViewModifiers.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/30/26.
//

import SwiftUI

struct PressEffectViewModifier: ViewModifier {
    
    @Binding var isPressed: Bool
    
    func body(content: Content) -> some View {
        content
            .onLongPressGesture(perform: {
                isPressed.toggle()
            }, onPressingChanged: { change in
                isPressed = change
            })
            .scaleEffect(isPressed ? 0.9 : 1.0)
            .animation(.smooth, value: isPressed)
    }
}

extension View {
    func pressEffect(isPressed: Binding<Bool>) -> some View {
        modifier(PressEffectViewModifier(isPressed: isPressed))
    }
}

