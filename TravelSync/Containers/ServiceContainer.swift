//
//  ServiceContainer.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/15/26.
//

import Foundation

final class ServiceContainer {
    let networkManager: NetworkRequestManager
    let keychainManager: KeychainManager
    
    let authService: UserAuthServiceProtocol
    let userService: UserServiceProtocol
    let tripService: TripServiceProtocol
    let expenseService: ExpenseServiceProtocol
    
    init(networkManager: NetworkRequestManager = NetworkRequestManager(), keychainManager: KeychainManager = KeychainManager()) {
        self.networkManager = networkManager
        self.keychainManager = keychainManager
        
        self.authService = UserAuthService(networkService: networkManager, keychainService: keychainManager)
        self.userService = UserService(networkService: networkManager, keychainService: keychainManager)
        self.tripService = TripService(networkService: networkManager, keychainService: keychainManager)
        self.expenseService = ExpenseService(networkService: networkManager, keychainService: keychainManager)
    }
}
