//
//  TSTabBarView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/29/25.
//

import SwiftUI

// TODO: Implement a custom tab bar for the app
struct TSTabBarView: View {
    @Environment(TSAppState.self) private var appState
    @Environment(TSViewModelFactory.self) private var viewModelFactory
    
    var body: some View {
        TabView {
            NavigationStack {
//                TSTripsFeedView(viewModel: viewModelFactory.makeTripFeedViewModel())
//                    .onAppear {
//                        
//                    }
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
                CalendarScreen(viewModel: viewModelFactory.makeCalendarViewModel())
            }
            .tabItem {
                Label(L10n.TSTabBarView.calendar, systemImage: TSSystemImageName.calendar)
            }
            
            NavigationStack {
//                ProfileScreen(viewModel: viewModelFactory.makeUserSessionViewModel())
//                    .navigationTitle(L10n.TSTabBarView.profile)
            }
            .tabItem {
                Label(L10n.TSTabBarView.profile, systemImage: TSSystemImageName.personFill)
            }
        }
        .tint(.accentPrimary)
    }
}

#Preview {
    let appState: TSAppState = TSAppState()
    let viewModelFactory: TSViewModelFactory = TSViewModelFactory(appState: appState)

    TSTabBarView()
        .environment(appState)
        .environment(viewModelFactory)
}
