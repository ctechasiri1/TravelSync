//
//  ScrollViewBackgroundModifier.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/3/26.
//

import SwiftUI

struct ScrollViewBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            .background(Color.backgroundColor.primaryBackground)
    }
}

extension View {
    func setScrollViewBackground() -> some View {
        modifier(ScrollViewBackgroundModifier())
    }
}
