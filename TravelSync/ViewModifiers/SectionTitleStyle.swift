//
//  SectionTitleStyle.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/3/26.
//

import SwiftUI

struct SectionTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .bold))
            .foregroundStyle(Color.textColor.placeholderText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 25)
    }
}

extension View {
    func sectionTitleStyle() -> some View {
        modifier(SectionTitleStyle())
    }
}

