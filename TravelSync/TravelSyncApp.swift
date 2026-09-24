//
//  TravelSyncApp.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/29/25.
//

import SwiftUI
import UIKit

@main
struct TravelSyncApp: App {

    @State private var container = TSAppContainer(
        services: ProcessInfo.processInfo.arguments.contains("-mock") ? .mock() : .live()
    )
    
    var body: some Scene {
        WindowGroup {
            TSAppStateView()
                .environment(container.authState)
                .environment(container.overlayState)
        }
    }
}

extension EnvironmentValues {
    @Entry var authContainer: TSAuthContainer? = nil
}
