//
//  UserService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/2/26.
//

import Foundation

final class UserService: UserServiceProtocol {
    func getCurrentUser() async throws -> UserPrivateResponse {
        guard let endpoint = URL(string: "http://127.0.0.1:8000/api/users/me") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        
        if let token = KeychainManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return try await NetworkRequestManager.shared.sendRequest(request: request, responseType: UserPrivateResponse.self)
    }
}
