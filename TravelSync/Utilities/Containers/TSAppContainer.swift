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
    
    let overlayState: TSOverlayState = TSOverlayState()
    let authState: TSAuthState = TSAuthState()
    let appConfigState: TSAppConfigState = TSAppConfigState()
    
    let managerContainer: TSManagerContainer
    
    init(services: TSServiceContainer) {
        self.managerContainer = TSManagerContainer(services: services)
        self.authContainer = TSAuthContainer(overlayState: overlayState, authState: authState, managerContainer: managerContainer)
    }
}
