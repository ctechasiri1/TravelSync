//
//  TripError.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/6/26.
//

import Foundation

enum TripError: Error, LocalizedError {
    case missingDates
    case emptyLocation
    case missingCoordinates
    
    var errorDescription: String {
        switch self {
        case .missingDates:
            return "Please select the dates you are planning for your trip."
        case .emptyLocation:
            return "Where are you going? Location cannot be empty."
        case .missingCoordinates:
            return "No coordinates where generated for this location."
        }
    }
}
