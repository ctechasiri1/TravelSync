//
//  ToggleOptionRow.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/27/26.
//

import SwiftUI

struct ToggleOptionRow: View {
    @Binding var isOn: Bool
    let title: String
    let iconName: String
    
    var body: some View {
        Toggle(isOn: $isOn) {
            HStack {
                Image(systemName: iconName)
                    .foregroundStyle(.secondaryText)
                    .padding(.horizontal, 10)
                
                Text(title)
                    .foregroundStyle(.primaryText)
                    .font(.system(size: 16, weight: .regular))
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ToggleOptionRow(isOn: .constant(false), title: "Favorite Places", iconName: "person.fill")
        .padding(.vertical, 5)
    
}
