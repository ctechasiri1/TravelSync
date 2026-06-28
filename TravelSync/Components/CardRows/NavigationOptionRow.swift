//
//  NavigationOptionRow.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/27/26.
//

import SwiftUI

struct NavigationOptionRow<Destination: View>: View {
    let title: String
    let iconName: String
    let iconColor: Color
    let destination: Destination
    let useCircleIcon: Bool
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                iconView
                    .padding(.horizontal)
                
                Text(title)
                    .font(.system(size: 16, weight: useCircleIcon ? .semibold : .regular))
                    .foregroundColor(.primaryText)
        
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.footnote)
                    .foregroundColor(.secondaryText)
                    .padding(.trailing, 15)
            }
            .padding(.leading, useCircleIcon ? 15 : 8)
        }
        .padding(.vertical, useCircleIcon ? 15 : 0)
    }
    
    @ViewBuilder
    private var iconView: some View {
        if useCircleIcon {
            CircleIcon(iconName: iconName, iconColor: iconColor, width: 35, height: 35)
        } else {
            Image(systemName: iconName)
                .frame(width: 24)
                .foregroundStyle(.secondaryText)
        }
    }
}

#Preview {
    NavigationOptionRow(title: "Favorite Places", iconName: "person.fill", iconColor: Color.orange, destination: EmptyView(), useCircleIcon: false)
        .padding(.top, 10)
        .padding(.bottom, 20)
}
