//
//  ServiceContainer.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/15/26.
//

import MapKit
import Foundation

final class ServiceContainer {
    let netowrkService: NetworkRequestService
    let keychainService: KeychainService
    
    let authService: UserAuthServiceProtocol
    let userService: UserServiceProtocol
    let tripService: TripServiceProtocol
    let expenseService: ExpenseServiceProtocol
    
    init(netowrkService: NetworkRequestService = NetworkRequestService(), keychainService: KeychainService = KeychainService()) {
        self.netowrkService = netowrkService
        self.keychainService = keychainService
        
        self.authService = UserAuthService(networkService: netowrkService, keychainService: keychainService)
        self.userService = UserService(networkService: netowrkService, keychainService: keychainService)
        self.tripService = TripService(networkService: netowrkService, keychainService: keychainService)
        self.expenseService = ExpenseService(networkService: netowrkService, keychainService: keychainService)
    }
}
