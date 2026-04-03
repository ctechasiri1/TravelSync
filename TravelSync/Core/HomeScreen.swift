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
            NavigationStack {
                TripsScreen()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            NavigationStack {
                ProfileScreen()
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
    }
}

#Preview {
    HomeScreen()
        .environment(AppState())
}
