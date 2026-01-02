//
//  FuturePlansCard.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/1/26.
//

import SwiftUI

struct FuturePlansCard: View {
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
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(travelDestination)
                        .font(.system(.title, weight: .bold))
                    
                    Spacer()
                    
                    Text("45 days")
                        .padding(10)
                        .foregroundStyle(Color.accentConfirmation)
                        .background(Color.green.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                }
                
                Text(travelDate)
                    .foregroundStyle(Color.secondaryText)
                
                Text("5 days till trip")
                    .font(.system(.subheadline, weight: .regular))
                    .foregroundStyle(Color.accentBlue)
            }
        }
    }
}

#Preview {
    FuturePlansCard(urlString: "https://example.com/image.png", imageHeight: 300, travelDestination: "Tokyo, Japan", travelDate: "Jan 15 - 25 2026")
}
