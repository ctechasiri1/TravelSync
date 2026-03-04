//
//  TravelSyncApp.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/29/25.
//

import SwiftUI

@main
struct TravelSyncApp: App {
    @State private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(appState)
        }
    }
}
