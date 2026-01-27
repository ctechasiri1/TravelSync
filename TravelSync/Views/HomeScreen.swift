//
//  HomeScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/29/25.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        TabView {
            Tab("Trips", systemImage: "circle.dashed") {
                TripsScreen()
            }
            Tab("Profile", systemImage: "person.fill") {
                ProfileScreen()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
