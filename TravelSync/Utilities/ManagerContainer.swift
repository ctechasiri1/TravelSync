//
//  ManagerContainer.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/22/26.
//

import MapKit
import Foundation

@MainActor
final class ManagerContainer {
    private let services: ServiceContainer
    
    private(set) var authManager: TSUserAuthManger
    private(set) var locationSearchManager: LocationSearchManager
    
    init() {
        self.services = ServiceContainer()
        self.authManager = TSUserAuthManger(service: TSRemoteUserAuthService(networkService: services.networkService), keychainService: services.keychainService)
        self.locationSearchManager = LocationSearchManager(completer: MKLocalSearchCompleter())
    }
}
