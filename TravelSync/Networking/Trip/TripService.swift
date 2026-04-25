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
    
    private var cachedTrips: [TripPrivateResponse]?
    private var lastFetch: Date?
    private let cacheLifetime: TimeInterval = 60
    
    private var activeFetchTask: Task<[TripPrivateResponse], Error>?
    
    init(networkService: NetworkRequestService, keychainService: KeychainService) {
        self.networkService = networkService
        self.keychainService = keychainService
    }
    
    private func buildTripBody(trip: TripCreateRequest, boundary: String) -> Data {
        /// 1. convert the Swift Data objects to ISO8601 strings so Python understands it
        let isoFormatter = ISO8601DateFormatter()
        
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
        
        /// 3. helper to pack standard text fields
        for (name, value) in fields {
            body.append(Data("--\(boundary)\r\n".utf8))
            body.append(Data("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".utf8))
            body.append(Data("\(value)\r\n".utf8))
        }
        
        /// 7. pack the image bytes
        if let imageData = trip.coverImageData {
            body.append(Data("--\(boundary)\r\n".utf8))
            body.append(Data("Content-Disposition: form-data; name=\"cover_image_file\"; filename=\"cover.jpg\"\r\n".utf8))
            body.append(Data("Content-Type: image/jpeg\r\n\r\n".utf8))
            body.append(imageData)
            body.append(Data("\r\n".utf8))
        }
        
        body.append(Data("--\(boundary)--\r\n".utf8))
        
        return body
    }
    
    func createTrip(trip: TripCreateRequest) async throws -> TripPrivateResponse {
        guard let urlEndpoint = URL(string: "http://127.0.0.1:8000/api/trips") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: urlEndpoint)
        request.httpMethod = "POST"
        
        /// 1. creates a umique seperator for the data being passed so the backend can split it up
        let boundary = "Boundary-\(UUID().uuidString)"
        
        /// 2. tells FastAPI this is a multipart form, and give it a boundary key
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        /// 3. check if the user is authorized to access the endpoint with the token
        if let token = await keychainService.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpBody = buildTripBody(trip: trip, boundary: boundary)
        
        let response = try await networkService.sendRequest(
            request: request,
            responseType: TripPrivateResponse.self
        )
        
        return response
    }
    
    func getTrip() async throws -> [TripPrivateResponse] {
        if let cached = cachedTrips, let last = lastFetch, Date().timeIntervalSince(last) < cacheLifetime {
            return cached
        }
        
        if let existing = activeFetchTask {
            return try await existing.value
        }
        
        let task = Task<[TripPrivateResponse], Error> {
            guard let urlEndpoint = URL(string: "http://127.0.0.1:8000/api/trips") else {
                throw APIError.invalidURL
            }
            
            var request = URLRequest(url: urlEndpoint)
            request.httpMethod = "GET"
                
            if let token = await keychainService.getToken() {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            return try await networkService.sendRequest(request: request, responseType: [TripPrivateResponse].self)
        }
        
        activeFetchTask = task
        let trips = try await task.value
        
        cachedTrips = trips
        lastFetch = Date()
        activeFetchTask = nil
        
        return trips
    }
}
