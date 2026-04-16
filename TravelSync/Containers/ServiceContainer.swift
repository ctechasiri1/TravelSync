//
//  ServiceContainer.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/15/26.
//

import Foundation

final class ServiceContainer {
    let networkService: NetworkRequestService
    let keychainService: KeychainService
    
    let authService: UserAuthServiceProtocol
    let userService: UserServiceProtocol
    let tripService: TripServiceProtocol
    
    init(networkService: NetworkRequestService = NetworkRequestService(), keychainService: KeychainService = KeychainService()) {
        self.networkService = networkService
        self.keychainService = keychainService
        
        self.authService = UserAuthService(networkService: networkService, keychainService: keychainService)
        self.userService = UserService(networkService: networkService, keychainService: keychainService)
        self.tripService = TripService(networkService: networkService, keychainService: keychainService)
    }
}
