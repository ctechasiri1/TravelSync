//
//  TripsFeedViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import Observation
import Foundation
import PhotosUI

@Observable
class TripsFeedViewModel {
    var trips: [Trip] = []
    
    var selection: TripOption = .upcoming
    
    var showErrorAlert: Bool = false
    var showPlanNewTrip: Bool = false
    
    private let tripService: TripServiceProtocol
    
    init(tripService: TripServiceProtocol) {
        self.tripService = tripService
    }
    
    var upcomingTrips: [Trip] {
        return trips.filter { $0.startDate >= Date.now}
    }
    
    var pastTrips: [Trip] {
        return trips.filter { $0.startDate < Date.now}
    }
    
    var isUpcomingTrip: Bool {
        return selection == .upcoming
    }
    
    func getTrip() async -> Void {
        do {
            let trips = try await tripService.getTrip()
            await MainActor.run {
                self.trips = trips.compactMap {
                    Trip(
                        id: $0.id,
                        tripName: $0.tripName,
                        location: $0.location,
                        budget: $0.budget,
                        isFavorite: $0.isFavorite,
                        startDate: $0.startDate,
                        endDate: $0.endDate,
                        imageURLString: $0.imageURL
                    )
                }
            }
        } catch {
            print("There was an error get your trips: \(error.localizedDescription)")
        }
    }
}
