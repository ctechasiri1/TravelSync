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
    var service: TSUserAuthService
    
    init(service: TSUserAuthService) {
        self.service = service
    }
    
    func login() async throws {
        try await service.login(requestBody: <#T##UserLoginRequest#>)
    }
    
    func signUp() async throws {
        try await service.signUp(requestBody: <#T##UserCreateRequest#>)
    }
}
