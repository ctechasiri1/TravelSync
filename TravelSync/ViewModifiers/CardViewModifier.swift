//
//  CardViewModifier.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/3/26.
//

import SwiftUI

struct CardViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color.backgroundColor.secondaryBackground)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 5)
    }
}

extension View {
    func createCardBackgroud() -> some View {
        modifier(CardViewModifier())
    }
}
