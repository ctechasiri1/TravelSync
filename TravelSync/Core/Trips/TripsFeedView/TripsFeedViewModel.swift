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
    var isFavorite: Bool = false
    
    private let tripService: TripServiceProtocol
    
    init(tripService: TripServiceProtocol) {
        self.tripService = tripService
    }
    
    var upcomingTrips: [Trip] {
        let filteredTrip = trips.filter { $0.startDate > Date.now }
        return filteredTrip.sorted { $0.startDate < $1.startDate }
    }
    
    var pastTrips: [Trip] {
        trips.filter { $0.startDate < Date.now }
    }
    
    var isUpcomingSelected: Bool {
        selection == .upcoming
    }
    
    func toggleShowPlanNewTrip() {
        showPlanNewTrip = true
    }
    
    func getTrip() async -> Void {
        do {
            let trips = try await tripService.getTrips()
            
            await MainActor.run {
                self.trips = trips.compactMap {
                    Trip(
                        id: $0.id,
                        tripName: $0.tripName,
                        location: $0.location,
                        longitude: $0.longitude,
                        latitude: $0.latitude,
                        budget: $0.budget,
                        totalSpending: $0.totalSpending,
                        isFavorite: $0.isFavorite,
                        startDate: $0.startDate,
                        endDate: $0.endDate,
                        imageURLString: $0.imageURL
                    )
                }
            }
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
    
    func updateTrip(tripId: Int, isFavorite: Bool?, coverImage: UIImage?) async {
        do {
            let updatedTrip = TripUpdateRequest(
                id: tripId,
                isFavorite: isFavorite,
                coverImageData: coverImage?.convertImageToData
            )
            
            let _ = try await tripService.updateTrip(trip: updatedTrip)
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
}
