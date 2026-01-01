//
//  NextAdventureCard.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/31/25.
//

import SwiftUI

struct NextAdventureCard: View {
    var body: some View {
        VStack {
            Color.backgroundColor.tertiaryBackground
                .frame(maxWidth: .infinity)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Tokyo, Japan")
                        .font(.system(.title, weight: .bold))
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(Color.accentBlue)
                        Text("Jan 15 - Jan 22, 2026")
                            .foregroundStyle(Color.secondaryText)
                    }
                }
                
                Spacer()
                
                Image(systemName: "airplane.departure")
                    .bold()
                    .foregroundStyle(Color.accentBlue)
                    .background(
                        Circle()
                            .fill(Color.accentBlue.opacity(0.1))
                            .strokeBorder(Color.accentBlue.opacity(0.5), lineWidth: 0.2)
                            .frame(width: 50, height: 50)
                    )
            }
            .padding()
            
            Divider()
            
            HStack {
                Image(systemName: "circle.fill")
                
                Spacer()
                
                Text("View Itinerary")
                Image(systemName: "arrow.forward")
            }
            .bold()
            .foregroundStyle(Color.accentBlue)
            .padding()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.secondaryBackground)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 10)
    }
}
