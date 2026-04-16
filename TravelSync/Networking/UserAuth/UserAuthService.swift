//
//  UserAuthService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/24/26.
//

import Foundation

final class UserAuthService: UserAuthServiceProtocol {
    
    private let networkService: NetworkRequestService
    private let keychainService: KeychainService
    
    init(networkService: NetworkRequestService, keychainService: KeychainService) {
        self.networkService = networkService
        self.keychainService = keychainService
    }
    
    // MARK: Encode the DTO to JSON and decodes the JSON
    func signUp(requestBody: UserCreateRequest) async throws -> UserPrivateResponse {
        /// 1. checks if the urlString is valid
        guard let endpoint = URL(string: "http://127.0.0.1:8000/api/users") else {
            throw APIError.invalidURL
        }
        
        /// 2. add metadata to the HTTP Request line and headers
        /// in this we are making a POST request, sending JSON format data to FastAPI
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        /// 3. this encodes the DTO (UserCreateRequest) into a JSON for FastAPI to take
        request.httpBody = try JSONEncoder().encode(requestBody)

        return try await networkService.sendRequest(
            request: request,
            responseType: UserPrivateResponse.self
        )
    }
    
    // MARK: Encode the DTO to Form Data and decodes the JSON
    func login(requestBody: UserLoginRequest) async throws -> TokenResponse {
        /// 1. checks if the urlString is valid
        guard let endpoint = URL(string: "http://127.0.0.1:8000/api/users/token") else {
            throw APIError.invalidURL
        }
        
        /// 2. add metadata to the HTTP Request line and headers
        /// in this we are making a POST request, sending a form data to FastAPI
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        /// 3. encodes the DTO (UserLoginRequest) components to form data
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "username", value: requestBody.username),
            URLQueryItem(name: "password", value: requestBody.password)
        ]
        
        /// 4. converts the string to raw bytes
        /// from the form data it to a formatted string (e.g., "username=hello%40test.com&password=abc")
        /// from the string it converts it to raw bytes
        guard let formDataString = components.query, let bodyData = formDataString.data(using: .utf8) else {
            throw APIError.invalidURL // Or create a specific .encoding error
        }
        
        /// 5. set the requset body with the raw bytes
        request.httpBody = bodyData
        
        /// 6. sends the request to FastAPI
        let tokenResponse = try await networkService.sendRequest(
            request: request,
            responseType: TokenResponse.self
        )
            
        /// 7. store the token in the keychain
        keychainService.saveToken(tokenResponse.accessToken)
        
        return tokenResponse
    }
}
