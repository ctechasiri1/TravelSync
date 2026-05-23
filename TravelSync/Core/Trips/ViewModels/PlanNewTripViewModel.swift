//
//  PlanNewTripViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/12/26.
//

import MapKit
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
    var coordinate: CLLocationCoordinate2D? = nil
    var coverUIImage: UIImage? = nil
    
    var pushNotificationsIsOn: Bool = true
    var isNetworkActive: Bool = false
    
    private let locationSearchManager: LocationSearchManager
    private let tripService: TripServiceProtocol
    
    init(tripService: TripServiceProtocol, locationSearchManager: LocationSearchManager) {
        self.tripService = tripService
        self.locationSearchManager = locationSearchManager
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
        defer { isNetworkActive = false }
        
        isNetworkActive = true
        
        await searchLocationCoordinates(locationName)
        
        do {
            guard let start = startDate, let end = endDate else {
                throw TripError.missingDates
            }
            
            let trimmedLocation = locationName.trimmingCharacters(in: .whitespaces)
            guard !trimmedLocation.isEmpty else {
                throw TripError.emptyLocation
            }
            
            guard let longtitude = coordinate?.longitude, let latitude = coordinate?.latitude else {
                throw TripError.missingCoordinates
            }
            
            let newTrip = TripCreateRequest(
                tripName: tripName,
                location: locationName,
                longitude: longtitude,
                latitude: latitude,
                budget: budget ?? 0,
                isFavorite: false,
                startDate: start,
                endDate: end,
                coverImageData: coverUIImage?.convertImageToData
            )
            
            let _ = try await (Task.sleep(nanoseconds: 500_000_000), tripService.createTrip(trip: newTrip))
            
            resetForm()
        } catch TripError.missingDates {
            print(TripError.missingDates.errorDescription)
        } catch TripError.emptyLocation {
            print(TripError.emptyLocation.errorDescription)
        } catch TripError.missingCoordinates {
            print(TripError.missingCoordinates.errorDescription)
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
    
    func getCompletions() -> [SearchCompletions] {
        return locationSearchManager.completions
    }
    
    func updateLocationSearchResults() {
        locationSearchManager.update(queryFragement: locationName)
    }
    
    func searchLocationCoordinates(_ location: String) async {
        do {
            let coordinates = try await locationSearchManager.search(with: locationName)
            coordinate = coordinates.first?.location
        } catch {
            print("There was an error starting the MKLocalSearch Engine.")
        }
    }
    
    func resetCompletions() {
        locationSearchManager.completions = []
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
