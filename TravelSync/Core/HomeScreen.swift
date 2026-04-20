//
//  HomeScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/29/25.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        TabView {
            NavigationStack {
                TripsFeedScreen(viewModel: appState.makeTripFeedViewModel())
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            NavigationStack {
                CalendarScreen(viewModel: appState.makeCalendarViewModel())
            }
            .tabItem {
                Label("Calendar", systemImage: "calendar")
            }
            
            NavigationStack {
                ProfileScreen(viewModel: appState.makeUserSessionViewModel())
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
        .tint(.accentPrimary)
    }
}

#Preview {
    HomeScreen()
        .environment(AppState())
}
