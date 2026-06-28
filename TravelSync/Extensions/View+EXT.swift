//
//  View+EXT.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/27/26.
//

import SwiftUI

extension View {
    func cardBackground() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.secondaryBackground)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 5, y: 2)
    }
    
    func sectionTitle() -> some View {
        self
            .font(.system(size: 15, weight: .bold))
            .foregroundStyle(.placeholderText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func scrollViewBackground() -> some View {
        self
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            .background(.primaryBackground)
    }
}
