//
//  TripsViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import Observation
import PhotosUI
import Foundation
import SwiftUI

@Observable
class TripsViewModel {
    var trips: [Trip] = []
    
    var selection: TripOption = .upcoming
    
    var tripName: String = ""
    var locationName: String = ""
    var budget: String = ""
    var startDate: Date? = nil
    var endDate: Date? = nil

    var pushNotificationsIsOn: Bool = true
    var showErrorAlert: Bool = false
    var showPlanNewTrip: Bool = false

    var selectedItem: PhotosPickerItem? = nil
    var coverUIImage: UIImage? = nil
    
    private let tripService: TripServiceProtocol
    
    init(tripService: TripServiceProtocol = TripService()) {
        self.tripService = tripService
    }
    
    var displayImage: Image {
        if let uiImage = coverUIImage {
            return Image(uiImage: uiImage)
        } else {
            return Image("default_cover")
        }
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
    
    var convertImageToData: Data? {
        return coverUIImage?.jpegData(compressionQuality: 0.8)
    }

    var canCreateTrip: Bool {
        let hasLocation = !locationName.trimmingCharacters(in: .whitespaces).isEmpty
        let hasDates = startDate != nil && endDate != nil
        
        if let start = startDate, let end = endDate {
            return hasLocation && hasDates && (end > start)
        }
        return false
    }

    func addTrip() async throws {
        guard let start = startDate, let end = endDate else {
            throw TripError.missingDates
        }
        
        let trimmedLocation = locationName.trimmingCharacters(in: .whitespaces)
        guard !trimmedLocation.isEmpty else {
            throw TripError.emptyLocation
        }
        
        let newTrip = TripCreateRequest(
            tripName: tripName,
            location: locationName,
            budget: budget,
            startDate: start,
            endDate: end,
            coverImageData: convertImageToData
        )
        
        do {
            let _ = try await tripService.createTrip(trip: newTrip)
            resetForm()
        } catch {
            print(error.localizedDescription)
        }
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
    
    func resetForm() -> Void {
        tripName = ""
        locationName = ""
        budget = ""
        startDate = nil
        endDate = nil
        coverUIImage = nil
    }
}
