//
//  UserService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/2/26.
//

import Foundation

actor UserService: UserServiceProtocol {
    private let networkService: NetworkRequestManager
    private let keychainService: KeychainManager
    private var activeTask: Task<UserPrivateResponse, Error>?
    
    init(networkService: NetworkRequestManager, keychainService: KeychainManager) {
        self.networkService = networkService
        self.keychainService = keychainService
    }
    
    func getCurrentUser() async throws -> UserPrivateResponse {
        if let existing = activeTask {
            return try await existing.value
        }
        
        let task = Task<UserPrivateResponse, Error> {
            guard let endpoint = URL(string: "http://127.0.0.1:8000/api/users/me") else {
                throw APIError.invalidURL
            }
            
            var request = URLRequest(url: endpoint)
            request.httpMethod = "GET"
            
            if let token = keychainService.getToken() {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            return try await networkService.sendRequest(request: request, responseType: UserPrivateResponse.self)
        }
        
        activeTask = task
        
        defer { activeTask = nil }
        
        return try await task.value
    }
}
