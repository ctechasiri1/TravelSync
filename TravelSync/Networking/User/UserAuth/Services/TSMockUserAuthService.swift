//
//  TSMockUserAuthService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/19/26.
//

import Foundation

struct TSMockUserAuthService: TSUserAuthService {
    func signUp(requestBody: UserCreateRequest) async throws -> UserPrivateResponse {
        UserPrivateResponse.mock
    }
//    
//    func login(requestBody: UserLoginRequest) async throws -> TokenResponse {
//    
//    }
}
