//
//  TSToggleRow.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 8/18/26.
//

import SwiftUI

struct TSToggleRow: View {
    
    @Binding var isOn: Bool
    
    let title: String
    let iconName: String
    
    init(isOn: Binding<Bool>, title: String, iconName: String) {
        self.title = title
        self.iconName = iconName
        self._isOn = isOn
    }
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Label {
                Text(title)
                    .foregroundColor(.primaryText)
            } icon: {
                Image(systemName: iconName)
                    .foregroundStyle(.secondaryText)
            }
        }
    }
}

#Preview("Toggle Row") {
    
    @State @Previewable var isOn: Bool = false
    
    NavigationStack {
        List {
            Section("Personal Information") {
                TSToggleRow(isOn: $isOn, title: "Dark Mode", iconName: "moon.fill")
                    .padding()
            }
        }
    }
}
