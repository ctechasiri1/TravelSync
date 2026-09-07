//
//  TSTabBarView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/29/25.
//

import SwiftUI

struct TSTabBarView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        TabView {
            NavigationStack {
                TripsFeedView(viewModel: appState.makeTripFeedViewModel())
            }
            .tabItem {
                Label(L10n.TSTabBarView.home, systemImage: TSSystemImageName.houseFill)
            }
            
            // TODO: Implement the search for friends feature
            NavigationStack {
                EmptyView()
            }
            .tabItem {
                Label(L10n.TSTabBarView.search, systemImage: TSSystemImageName.magnifyingglass)
            }
            
            NavigationStack {
                CalendarScreen(viewModel: appState.makeCalendarViewModel())
            }
            .tabItem {
                Label(L10n.TSTabBarView.calendar, systemImage: TSSystemImageName.calendar)
            }
            
            NavigationStack {
                ProfileScreen(viewModel: appState.makeUserSessionViewModel())
                    .navigationTitle(L10n.TSTabBarView.profile)
            }
            .tabItem {
                Label(L10n.TSTabBarView.profile, systemImage: TSSystemImageName.personFill)
            }
        }
        .tint(.accentPrimary)
        .showLoading()
        .deleteConfirmation()
    }
}

#Preview {
    TSTabBarView()
        .environment(AppState())
}
