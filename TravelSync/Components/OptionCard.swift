//
//  OptionsCard.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/3/26.
//

import SwiftUI

// This creates a 'group' for multiples views to be passed into
struct OptionsCard<Content: View>: View {
    let title: String?
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(spacing: 10) {
            if let title = title, !title.isEmpty {
                Text(title)
                    .sectionTitleStyle()
            }
            VStack {
                content
            }
            .createCardBackgroud()
        }
    }
}

// This creates the option that can navigate to another screen
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
                    .foregroundColor(Color.textColor.primaryText)
        
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.footnote)
                    .foregroundColor(.secondary)
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
                .foregroundStyle(Color.secondary)
        }
    }
}

// This creates the option with a toggle button built-in
struct ToggleOptionRow: View {
    let title: String
    let iconName: String
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            HStack {
                Image(systemName: iconName)
                    .foregroundStyle(Color.secondary)
                    .padding(.horizontal, 10)
                
                Text(title)
                    .foregroundStyle(Color.textColor.primaryText)
                    .font(.system(size: 16, weight: .regular))
            }
        }
        .padding(.horizontal)
    }
}


#Preview {
    OptionsCard(title: "ACCOUNT") {
        NavigationOptionRow(title: "Favorite Places", iconName: "person.fill", iconColor: Color.red, destination: EmptyView(), useCircleIcon: true)
            .padding(.top, 20)
            .padding(.bottom, 10)
        
        Divider()
        
        ToggleOptionRow(title: "Favorite Places", iconName: "person.fill", isOn: .constant(false))
            .padding(.vertical, 5)
        
        Divider()
        
        NavigationOptionRow(title: "Favorite Places", iconName: "person.fill", iconColor: Color.orange, destination: EmptyView(), useCircleIcon: false)
            .padding(.top, 10)
            .padding(.bottom, 20)
    }
}
