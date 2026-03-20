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
    //MARK: Variables
    // this is for the Trips Screen
    var selection: TripOption = .upcoming
    var showPlanNewTrip: Bool = false
    var trips: [Trip] = [Trip.example]
    
    // this is for the Plan New Trips Screen
    var pushNotificationsIsOn: Bool = true
    var tripName: String = ""
    var locationName: String = ""
    var startDate: Date? = nil
    var endDate: Date? = nil
    var errorMessage: String? = nil
    var showErrorAlert: Bool = false
    
    // this is for handling the Cover Image
    // Holds the selection from the picker
    var selectedItem: PhotosPickerItem? = nil
    // Holds the actual image to display
    var coverUIImage: UIImage? = nil
    
    //MARK: Computed Variables
    // converts the selected UIImage from photos to Image
    var displayImage: Image {
        if let uiImage = coverUIImage {
            return Image(uiImage: uiImage)
        } else {
            return Image("Temp_Background")
        }
    }
    
    // checks if the user has all the information filled out when planning a new trip (locationName, startDate, endDate)
    var canCreateTrip: Bool {
        let hasLocation = !locationName.trimmingCharacters(in: .whitespaces).isEmpty
        let hasDates = startDate != nil && endDate != nil
        
        if let start = startDate, let end = endDate {
            return hasLocation && hasDates && (end > start)
        }
        return false
    }
    
    //MARK: Methods
    // adds the new trip to the trips list
    func addTrip() throws -> Void {
        guard let start = startDate, let end = endDate else {
            throw TripError.missingDates
        }
        
        let trimmedLocation = locationName.trimmingCharacters(in: .whitespaces)
        guard !trimmedLocation.isEmpty else {
            throw TripError.emptyLocation
        }
        
        let newTrip = Trip(tripName: tripName, location: locationName, startDate: start, endDate: end, coverImage: coverUIImage)
        trips.append(newTrip)
        
        resetForm()
    }
    
    // resets the information in the form
    func resetForm() -> Void {
        tripName = ""
        locationName = ""
        startDate = nil
        endDate = nil
        coverUIImage = nil
    }
}
