//
//  AddButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/20/26.
//

import SwiftUI

struct AddButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .padding(8)
                .background(.accentPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    AddButton(action: { })
}
