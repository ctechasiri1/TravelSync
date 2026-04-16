//
//  UserService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/2/26.
//

import Foundation

struct UserService: UserServiceProtocol {
    private let networkService: NetworkRequestService
    private let keychainService: KeychainService
    
    private var cachedTrips: [TripPrivateResponse]?
    private var lastFetch: Date?
    private let cacheLifetime: TimeInterval = 60
    
    private var activeFetchTask: Task<[TripPrivateResponse], Error>?
    
    init(networkService: NetworkRequestService, keychainService: KeychainService) {
        self.networkService = networkService
        self.keychainService = keychainService
    }
    
    func getCurrentUser() async throws -> UserPrivateResponse {
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
}
