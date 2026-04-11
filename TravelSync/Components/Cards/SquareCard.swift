//
//  SquareCard.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/8/26.
//

import SwiftUI

struct SquareCard<T:View>: View {
    let title: String
    let value: String
    let iconName: String
    let iconColor: Color
    let arrowColor: Color
    @ViewBuilder let content: T
    
    var body: some View {
        NavigationLink {
            content
        } label: {
            OptionsCard(title: "") {
                HStack {
                    VStack(alignment: .leading) {
                        SquareIcon(
                            iconName: iconName,
                            iconColor: iconColor,
                            width: 50,
                            height: 50
                        )
                        .padding(.leading, 10)
                        .padding([.top, .bottom], 10)
                        .imageScale(.large)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(title)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.black)
                                
                            Text(value)
                                .font(.system(size: 13))
                                .foregroundStyle(.secondaryText)
                            
                            HStack {
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .imageScale(.small)
                                    .foregroundStyle(arrowColor)
                            }
                        }
                        .padding([.top, .bottom, .trailing], 15)
                    }
                    .padding([.top, .leading], 20)
                    .padding(.trailing, 5)
                }
            }
        }
    }
}

#Preview {
    SquareCard(
        title: "Documents",
        value: "Left",
        iconName: "ticket.fill",
        iconColor: .accentBlue,
        arrowColor: .accentBlue
    ) {

    }
}
