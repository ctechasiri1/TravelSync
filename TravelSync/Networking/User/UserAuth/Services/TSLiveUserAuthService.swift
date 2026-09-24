//
//  TSLiveUserAuthService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/24/26.
//

import Foundation

struct TSLiveUserAuthService: TSUserAuthService {
    private let networkService: TSNetworkRequestService
    
    init(networkService: TSNetworkRequestService) {
        self.networkService = networkService
    }
    
    func signUp(requestBody: UserCreateRequest) async throws -> UserPrivateResponse {
        // TODO: This is local development right now, so removed once its deployed
        guard let endpoint = URL(string: "http://127.0.0.1:8000/api/users") else {
            throw APIError.invalidURL
        }
        
        let request = try networkService.createRequest(url: endpoint, httpMethod: .post, valueType: .applicationJson, httpField: .contentType, body: requestBody)
        
        return try await networkService.sendRequest(request: request, responseType: UserPrivateResponse.self)
    }
    
    // TODO: This endpoint should provide us with the token and current user information
    func login(requestBody: UserLoginRequest) async throws -> TokenResponse {
        guard let endpoint = URL(string: "http://127.0.0.1:8000/api/users/token") else {
            throw APIError.invalidURL
        }

        /// encodes the DTO (UserLoginRequest) components to form data
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "username", value: requestBody.username),
            URLQueryItem(name: "password", value: requestBody.password)
        ]
            
        /// converts the string to raw bytes
        /// from the form data it to a formatted string (e.g., "username=hello%40test.com&password=abc")
        /// from the string it converts it to raw bytes
        guard let formDataString = components.query, let bodyData = formDataString.data(using: .utf8) else {
            throw APIError.invalidPayload
        }
        
        let request = try networkService.createRequest(url: endpoint, httpMethod: .post, valueType: .formUrlencoded, httpField: .contentType, body: bodyData)
            
        /// sends the request to FastAPI
        let tokenResponse = try await networkService.sendRequest(request: request, responseType: TokenResponse.self)
            
        return tokenResponse
    }
}
