//
//  GroupCard.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/3/26.
//

import SwiftUI

// TODO: All of this needs to be seperated out too, i can rethink to make this simplier
// This creates a 'group' for multiples views to be passed into
struct GroupCard<T: View>: View {
    let title: String?
    @ViewBuilder let content: () -> T
    
    init(title: String? = nil, @ViewBuilder content: @escaping () -> T) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 10) {
            if let unwrappedTitle = title {
                Text(unwrappedTitle)
                    .sectionTitle()
                    .padding(.leading, 5)
            }
            
            VStack {
                content()
            }
            .cardBackground()
        }
    }
}

#Preview {
    GroupCard(title: "ACCOUNT") {
        NavigationOptionRow(title: "Favorite Places", iconName: "person.fill", iconColor: Color.red, destination: EmptyView(), useCircleIcon: true)
            .padding(.top, 20)
            .padding(.bottom, 10)
        
        Divider()
        
        ToggleOptionRow(isOn: .constant(false), title: "Favorite Places", iconName: "person.fill")
            .padding(.vertical, 5)
        
        Divider()
        
        NavigationOptionRow(title: "Favorite Places", iconName: "person.fill", iconColor: Color.orange, destination: EmptyView(), useCircleIcon: false)
            .padding(.top, 10)
            .padding(.bottom, 20)
    }
}
