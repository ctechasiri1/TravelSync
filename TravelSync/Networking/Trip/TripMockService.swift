//
//  TripMockService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/31/26.
//

import Foundation

struct TripMockService: TripServiceProtocol {
    func getTrip(tripId: Int) async throws -> TripResponse {
        return TripResponse.mock
    }
    
    func createTrip(trip: TripCreateRequest) async throws -> TripResponse {
        return TripResponse.mock
    }
    
    func getTrips() async throws -> [TripResponse] {
        return TripResponse.mocks
    }
    
    func updateTrip(trip: TripUpdateRequest) async throws -> EmptyResponse {
        return EmptyResponse()
    }
    
    func deleteTrip(tripId: Int) async throws -> EmptyResponse {
        return EmptyResponse()
    }
}
