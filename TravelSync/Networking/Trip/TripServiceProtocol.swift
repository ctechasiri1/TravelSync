//
//  TripServiceProtocol.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/29/26.
//

import Foundation
//
protocol TripServiceProtocol {
    func createTrip(trip: TripCreateRequest) async throws -> TripPrivateResponse
    func getTrips() async throws -> [TripPrivateResponse]
    func getTrip(tripId: Int) async throws -> TripPrivateResponse
    func updateTrip(trip: TripUpdateRequest) async throws -> EmptyResponse
    func deleteTrip(tripId: Int) async throws -> EmptyResponse
}
