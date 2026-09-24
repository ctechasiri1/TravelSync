//
//  TSAppContainer.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/23/26.
//

import Foundation

@MainActor
struct TSAppContainer {
    
    let authContainer: TSAuthContainer
    
    private let overlayState: TSOverlayState = TSOverlayState()
    private let authState: TSAuthState = TSAuthState()
    private let appConfigState: TSAppConfigState = TSAppConfigState()
    
    private let managerContainer: TSManagerContainer
    
    init(services: TSServiceContainer) {
        self.managerContainer = TSManagerContainer(services: services)
        self.authContainer = TSAuthContainer(overlayState: overlayState, authState: authState, managerContainer: managerContainer)
    }
}
