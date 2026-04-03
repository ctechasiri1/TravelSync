//
//  LogOutButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import SwiftUI

struct AuthButton: View {
    @State private var isPressed: Bool = false
    let text: String
    let foregroundColor: Color
    let backgroundColor: Color
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.system(.subheadline, weight: .semibold))
                .padding()
                .foregroundStyle(foregroundColor)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .scaleEffect(isPressed ? 0.90 : 1.0)
                .onLongPressGesture {
                    isPressed.toggle()
                } onPressingChanged: { pressing in
                    isPressed = pressing
                }
        }
    }
}


