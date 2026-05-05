//
//  TripService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/29/26.
//

import Foundation

actor TripService: TripServiceProtocol {
    private let networkService: NetworkRequestService
    private let keychainService: KeychainService
    private var activeTask: Task<[TripPrivateResponse], Error>?
    
    init(networkService: NetworkRequestService, keychainService: KeychainService) {
        self.networkService = networkService
        self.keychainService = keychainService
    }
    
    func createTrip(trip: TripCreateRequest) async throws -> TripPrivateResponse {
        guard let urlEndpoint = URL(string: "http://127.0.0.1:8000/api/trips") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: urlEndpoint)
        request.httpMethod = "POST"
        
        /// 1. creates a umique seperator for the data being passed so the backend can split it up
        let boundary = "Boundary-\(UUID().uuidString)"
        let isoFormatter = ISO8601DateFormatter()
        
        /// 2. tells FastAPI this is a multipart form, and give it a boundary key
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        /// 3. check if the user is authorized to access the endpoint with the token
        if let token = keychainService.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        /// 2. generate the request body
        var body = Data()
        
        let fields: [(String, String)] = [
            ("title", trip.tripName),
            ("location", trip.location),
            ("start_date", isoFormatter.string(from: trip.startDate)),
            ("end_date", isoFormatter.string(from: trip.endDate)),
            ("budget", String(trip.budget)),
            ("is_favorite", String(trip.isFavorite))
        ]
        
        for (name, value) in fields {
            body.append(Data("--\(boundary)\r\n".utf8))
            body.append(Data("Content-Disposition: form-data;".utf8))
            body.append(Data(" name=\"\(name)\"\r\n\r\n".utf8))
            body.append(Data("\(value)\r\n".utf8))
        }
        
        if let imageData = trip.coverImageData {
            body.append(Data("--\(boundary)\r\n".utf8))
            body.append(Data("Content-Disposition: form-data;".utf8))
            body.append(Data(" name=\"cover_image_file\"; filename=\"cover.jpg\"\r\n".utf8))
            body.append(Data("Content-Type: image/jpeg\r\n\r\n".utf8))
            body.append(imageData)
            body.append(Data("\r\n".utf8))
        }
        
        body.append(Data("--\(boundary)--\r\n".utf8))
        
        request.httpBody = body
        
        let response = try await networkService.sendRequest(
            request: request,
            responseType: TripPrivateResponse.self
        )
        
        return response
    }
    
    func getTrips() async throws -> [TripPrivateResponse] {
        defer { activeTask = nil }
        
        if let existing = activeTask {
            return try await existing.value
        }
        
        let task = Task<[TripPrivateResponse], Error> {
            guard let url = URL(string: "http://127.0.0.1:8000/api/trips") else {
                throw APIError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            if let token = keychainService.getToken() {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            return try await networkService.sendRequest(request: request, responseType: [TripPrivateResponse].self)
        }
        
        activeTask = task
        
        return try await task.value
    }
    
    func updateTrip(trip: TripUpdateRequest) async throws -> EmptyResponse {
        guard let url = URL(string: "http://127.0.0.1:8000/api/trips/\(trip.id)") else {
            throw APIError.invalidURL
        }
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if let token = keychainService.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        var body = Data()
        
        if let updateIsFavorite = trip.isFavorite {
            body.append(Data("--\(boundary)\r\n".utf8))
            body.append(Data("Content-Disposition: form-data; name=\"is_favorite\"\r\n\r\n".utf8))
            body.append(Data("\(updateIsFavorite)\r\n".utf8))
        }
        
        if let updateCoverImage = trip.coverImageData {
            body.append(Data("--\(boundary)\r\n".utf8))
            body.append(Data("Content-Disposition: form-data; name=\"cover_image_file\"; filename=\"cover.jpg\"\r\n".utf8))
            body.append(Data("Content-Type: image/jpeg\r\n\r\n".utf8))
            body.append(updateCoverImage)
            body.append(Data("\r\n".utf8))
        }
        
        body.append(Data("--\(boundary)--\r\n".utf8))
        
        request.httpBody = body
                
        return try await networkService.sendRequest(request: request, responseType: EmptyResponse.self)
    }
    
    func deleteTrip(tripId: Int) async throws -> EmptyResponse {
        guard let url = URL(string: "http://127.0.0.1:8000/api/trips/\(tripId)") else {
            throw APIError.invalidURL
        }
            
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
            
        if let token = keychainService.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
            
        return try await networkService.sendRequest(request: request, responseType: EmptyResponse.self)
    }
}
