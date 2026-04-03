//
//  ToolbarButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/31/25.
//

import SwiftUI

struct ToolbarButton: View {
    let imageName: String
    let foregroundColor: Color
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageName)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(foregroundColor)
                .padding(8)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
