//
//  OptionsCard.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/3/26.
//

import SwiftUI

struct OptionsCard: View {
    let options: [CardOption]
    let useCircleIcon: Bool
    let padding: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(options.indices, id: \.self) { index in
                Button {
                    
                } label: {
                    CardOptionNavigation(title: options[index].title, iconName: options[index].iconName, useCircleIcon: useCircleIcon)
                }
                .padding(.vertical, padding)
                
                if index < options.count - 1 {
                    Divider()
                        .padding(0)
                }
            }
        }
        .createCardBackgroud()
        .padding(.horizontal)
    }
}

struct CardOptionNavigation: View {
    let title: String
    let iconName: String
    let useCircleIcon: Bool
    
    var body: some View {
        HStack {
            Group {
                if useCircleIcon {
                    CircleIcon(iconName: iconName, width: 40, height: 40)
                } else {
                    Image(systemName: iconName)
                        .foregroundStyle(Color.secondary)
                }
            }
            .padding(.horizontal)
            
            Text(title)
                .foregroundStyle(Color.textColor.primaryText)
                .font(.system(size: 16, weight: useCircleIcon ? .semibold : .regular))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

#Preview {
    OptionsCard(options: [CardOption(title: "Favorite Place", iconName: "heart.fill"), CardOption(title: "Favorite Place", iconName: "heart.fill")], useCircleIcon: true, padding: 30)
}
