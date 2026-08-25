//
//  TSNavigationCard.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/8/26.
//

import SwiftUI

struct TSNavigationCard<Destination: View>: View {
    
    let title: String
    let subtitle: String
    let iconName: String
    let iconColor: Color
    
    @ViewBuilder let destination: () -> Destination
    
    var body: some View {
        NavigationLink {
            destination()
        } label: {
            GroupCard {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        TSIcon(iconShape: .square, iconName: iconName, iconColor: iconColor)
                        
                        Text(title)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.black)
                        
                        HStack {
                            Text(subtitle)
                                .font(.system(size: 12))
                            
                            Spacer()
                            
                            Image(systemName: TSSystemImageName.chevronRight)
                                .imageScale(.small)
                        }
                        .foregroundStyle(.secondaryText)
                    }
                    .padding()
                    
                }
                .padding()
            }
        }
    }
}

#Preview("TSNavigationCard") {
    NavigationStack {
        HStack {
            TSNavigationCard(title: "Documents", subtitle: "5 Documents", iconName: TSSystemImageName.bookPagesFill, iconColor: .accentPrimary) {
                EmptyView()
            }
            
            TSNavigationCard(title: "Events", subtitle: "10 Events", iconName: TSSystemImageName.mapFill, iconColor: .accentPrimary) {
                EmptyView()
            }
        }
        .padding()
    }
}
