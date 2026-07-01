//
//  ToolBarDeleteButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/3/26.
//

import SwiftUI

struct ToolBarDeleteButton: View {
    let action: () -> Void
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "trash.fill")
                .foregroundStyle(.accentPrimary)
                .imageScale(.large)
        }
        .pressEffect(isPressed: $isPressed)
    }
}

#Preview {
    ToolBarDeleteButton(action: { })
}
