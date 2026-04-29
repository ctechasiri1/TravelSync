//
//  PlanNewTripViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/12/26.
//

import Observation
import Foundation
import SwiftUI

@Observable
class PlanNewTripViewModel {
    var tripName: String = ""
    var locationName: String = ""
    var budget: Int? = nil
    var isFavorite: Bool = false
    var startDate: Date? = nil
    var endDate: Date? = nil
    var coverUIImage: UIImage? = nil
    
    var pushNotificationsIsOn: Bool = true
    
    private let tripService: TripServiceProtocol
    
    init(tripService: TripServiceProtocol) {
        self.tripService = tripService
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

    func addTrip() async {
        do {
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
                budget: budget ?? 0,
                isFavorite: false,
                startDate: start,
                endDate: end,
                coverImageData: convertImageToData
            )
            
            let _ = try await tripService.createTrip(trip: newTrip)
            
            resetForm()
        } catch TripError.missingDates {
            print(TripError.missingDates.errorDescription)
        } catch TripError.emptyLocation {
            print(TripError.emptyLocation.errorDescription)
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
    
    func resetForm() -> Void {
        tripName = ""
        locationName = ""
        budget = nil
        startDate = nil
        endDate = nil
        coverUIImage = nil
    }
}
