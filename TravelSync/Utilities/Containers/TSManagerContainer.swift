//
//  TSManagerContainer.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/22/26.
//

import MapKit
import Foundation

@MainActor
struct TSManagerContainer {
    private let services: TSServiceContainer
    
    private(set) var authManager: TSUserAuthManger
    
    init(services: TSServiceContainer) {
        self.services = services
        
        self.authManager = TSUserAuthManger(
            service: services.userAuthService,
            keychainService: services.keychainService
        )
    }
}
