//
//  TSUserAuthManager.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/19/26.
//

import Observation
import Foundation

@MainActor
@Observable
class TSUserAuthManger {
    private let service: TSUserAuthService
    private let keychainService: KeychainService
    
    init(service: TSUserAuthService, keychainService: KeychainService) {
        self.service = service
        self.keychainService = keychainService
    }
    
    func login(username: String, password: String) async throws {
        let request = UserLoginRequest(username: username, password: password)
        let token = try await service.login(requestBody: request)
        keychainService.saveToken(token.accessToken)
    }
    
    func signUp(fullName: String, username: String, email: String, password: String) async throws {
        let request = UserCreateRequest(username: username, fullName: fullName, email: email, password: password)
        // TODO: I need to think how we can use this response when a user signs up
        try await service.signUp(requestBody: request)
    }
}
