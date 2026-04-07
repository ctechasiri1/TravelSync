//
//  UserAuthServiceProtocol.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/25/26.
//

import Foundation

protocol UserAuthServiceProtocol {
    func signUp(requestBody: UserCreateRequest) async throws -> UserPrivateResponse
    func login(requestBody: UserLoginRequest) async throws -> TokenResponse
}
