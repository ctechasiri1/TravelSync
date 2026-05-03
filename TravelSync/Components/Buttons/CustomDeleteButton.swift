//
//  CustomDeleteButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/3/26.
//

import SwiftUI

struct CustomDeleteButton: View {
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "trash.fill")
                .foregroundStyle(.accentPrimary)
        }
    }
}

#Preview {
    CustomDeleteButton(action: { })
}
