//
//  View+Ext.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/27/26.
//

import SwiftUI

extension View {
    func subtleRoundedBorder() -> some View {
        self
            .background(content: {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        Color.secondaryText.opacity(0.2),
                        style: StrokeStyle(lineWidth: 1)
                    )
            })
    }
    
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
            .padding(.leading, 5)
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
    
    func removeListRowFormatting() -> some View {
        self
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
    }
}
