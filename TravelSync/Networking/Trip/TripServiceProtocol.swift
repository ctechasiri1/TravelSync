//
//  TripServiceProtocol.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/29/26.
//

import Foundation
//
protocol TripServiceProtocol {
    func getTrip(tripId: Int) async throws -> TripResponse
    func createTrip(trip: TripCreateRequest) async throws -> TripResponse
    func getTrips() async throws -> [TripResponse]
    func updateTrip(trip: TripUpdateRequest) async throws -> EmptyResponse
    func deleteTrip(tripId: Int) async throws -> EmptyResponse
}
