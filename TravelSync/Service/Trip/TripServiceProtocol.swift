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
}
