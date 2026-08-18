//
//  TSToggleRow.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 8/18/26.
//

import SwiftUI

struct TSToggleRow: View {
    
    let title: String
    let iconName: String
    
    @Binding var isOn: Bool
    
    init(title: String, iconName: String, isOn: Binding<Bool>) {
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
                TSToggleRow(title: "Dark Mode", iconName: "moon.fill", isOn: $isOn)
                    .padding()
            }
        }
    }
}
