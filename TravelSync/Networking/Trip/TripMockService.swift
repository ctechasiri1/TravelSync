//
//  TripMockService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/31/26.
//

import Foundation

struct TripMockService: TripServiceProtocol {
    func getTrip(tripId: Int) async throws -> TripPrivateResponse {
        return
            TripPrivateResponse(
                id: 1,
                tripName: "Mango Sticky Rice Summer",
                location: "Bangkok, Thailand",
                longitude: 13.7563,
                latitude: 100.5018,
                totalSpending: 10,
                budget: 1_000,
                isFavorite: true,
                startDateString: "\(Calendar.current.date(byAdding: .day, value: 2, to: Date.now) ?? .now)",
                endDateString: "\(Calendar.current.date(byAdding: .day, value: 3, to: Date.now) ?? .now)",
                imageURLString: ""
            )
    }
    
    func createTrip(trip: TripCreateRequest) async throws -> TripPrivateResponse {
        return TripPrivateResponse(
            id: 1,
            tripName: "Mango Sticky Rice Summer",
            location: "Bangkok, Thailand",
            longitude: 13.7563,
            latitude: 100.5018,
            totalSpending: 10,
            budget: 5000,
            isFavorite: false,
            startDateString: "\(Calendar.current.date(byAdding: .day, value: 2, to: Date.now) ?? .now)",
            endDateString: "\(Calendar.current.date(byAdding: .day, value: 3, to: Date.now) ?? .now)",
            imageURLString: ""
        )
    }
    
    func getTrips() async throws -> [TripPrivateResponse] {
        return [
            TripPrivateResponse(
                id: 1,
                tripName: "Mango Sticky Rice Summer",
                location: "Bangkok, Thailand",
                longitude: 13.7563,
                latitude: 100.5018,
                totalSpending: 10,
                budget: 1_000,
                isFavorite: true,
                startDateString: "\(Calendar.current.date(byAdding: .day, value: 2, to: Date.now) ?? .now)",
                endDateString: "\(Calendar.current.date(byAdding: .day, value: 3, to: Date.now) ?? .now)",
                imageURLString: ""
            ),
            TripPrivateResponse(
                id: 2,
                tripName: "Eating Pho in Vietnam",
                location: "Saigon, Vietnam",
                longitude: 10.8231,
                latitude: 106.6297,
                totalSpending: 10,
                budget: 2_000,
                isFavorite: false,
                startDateString: "\(Calendar.current.date(byAdding: .day, value: -7, to: Date.now) ?? .now)",
                endDateString: "\(Calendar.current.date(byAdding: .day, value: -5, to: Date.now) ?? .now)",
                imageURLString: ""
            ),
            TripPrivateResponse(
                id: 3,
                tripName: "Bubble Tea in Taiwan",
                location: "Taipei, Taiwan",
                longitude: 25.0330,
                latitude: 121.5654,
                totalSpending: 10,
                budget: 3_000,
                isFavorite: true,
                startDateString: "\(Calendar.current.date(byAdding: .day, value: 5, to: Date.now) ?? .now)",
                endDateString: "\(Calendar.current.date(byAdding: .day, value: 7, to: Date.now) ?? .now)",
                imageURLString: ""
            )
        ]
    }
    
    func updateTrip(trip: TripUpdateRequest) async throws -> EmptyResponse {
        return EmptyResponse()
    }
    
    func deleteTrip(tripId: Int) async throws -> EmptyResponse {
        return EmptyResponse()
    }
}
