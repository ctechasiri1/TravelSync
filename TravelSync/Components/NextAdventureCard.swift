//
//  NextAdventureCard.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/31/25.
//

import SwiftUI

struct NextAdventureCard: View {
    let urlString: String
    let imageHeight: CGFloat
    let travelDestination: String
    let travelDate: String
    
    var body: some View {
        VStack {
            ImageWithPlaceHolder(urlString: urlString, imageHeight: imageHeight)
            
            VStack {
                TravelInformation(travelDestination: travelDestination, travelDate: travelDate)
                    .padding()
                
                Divider()
                
                TravelItinerary()
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.secondaryBackground)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5)
    }
}

private struct TravelInformation: View {
    let travelDestination: String
    let travelDate: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(travelDestination)
                    .font(.system(.title, weight: .bold))
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(Color.accentBlue)
                    Text(travelDate)
                        .foregroundStyle(Color.secondaryText)
                }
            }
            
            Spacer()
            
            CircleIcon(iconName: "airplane.departure")
        }
    }
}

// TODO: Need to add link to navigate to the itinerary
private struct TravelItinerary: View {
    var body: some View {
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
}

#Preview {
    NextAdventureCard(urlString: "https://example.com/image.png", imageHeight: 300, travelDestination: "Tokyo, Japan", travelDate: "Jan 15 - 25 2026")
}
