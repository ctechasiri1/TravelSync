//
//  ContentView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/29/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Trips", systemImage: "circle.dashed") {
                MyTripsScreen()
            }
            Tab("Profile", systemImage: "person.fill") {
                ProfileScreen()
            }
        }
    }
}

#Preview {
    ContentView()
}
