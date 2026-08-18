//
//  TSNavigationRow.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 8/18/26.
//

import SwiftUI

struct TSNavigationRow<Destination: View>: View {
    
    let title: String
    let iconName: String
    let iconColor: Color
    let destination: () -> Destination
    
    init(title: String, iconName: String, iconColor: Color = .secondary, @ViewBuilder destination: @escaping () -> Destination) {
        self.title = title
        self.iconName = iconName
        self.iconColor = iconColor
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink {
            destination()
        } label: {
            Label {
                Text(title)
                    .foregroundColor(.primaryText)
            } icon: {
                Image(systemName: iconName)
                    .foregroundStyle(iconColor)
            }
        }
    }
}

#Preview("Navigation Row") {
    NavigationStack {
        List {
            Section("Personal Information") {
                TSNavigationRow(title: "Personal Information", iconName: TSSystemImage.personFill) {
                    EmptyView()
                }
                    .padding()
            }
        }
    }
}
