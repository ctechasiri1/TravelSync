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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            TSAppStateView()
                .environment(delegate.dependencies.appState)
                .environment(delegate.dependencies.viewModelFactory)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: Dependencies!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        dependencies = Dependencies()
        
        return true
    }
}

struct Dependencies {
    var viewModelFactory: TSViewModelFactory
    var appState: TSAppState
    
    init() {
        self.appState = TSAppState()
        self.viewModelFactory = TSViewModelFactory(appState: appState)
    }
}
