//
//  TextButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/18/26.
//

import SwiftUI

struct TextButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.system(.subheadline, weight: .semibold))
                .foregroundStyle(.accentPrimary)
        }
    }
}

#Preview {
    TextButton(text: "Test", action: { })
}
