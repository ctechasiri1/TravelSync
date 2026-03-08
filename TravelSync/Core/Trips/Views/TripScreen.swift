//
//  TripScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/7/26.
//

import SwiftUI

struct TripScreen: View {
    let trip: Trip
    
    var body: some View {
        if let image = trip.coverImage {
            Image(uiImage: image)
        } else {
            Image("Temp_Background")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

//#Preview {
//    TripScreen()
//        .environment(AppState())
//}
