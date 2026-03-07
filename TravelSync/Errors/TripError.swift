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
    
    var errorDescription: String? {
        switch self {
        case .missingDates:
            return "Please select both start and end dates"
        case .emptyLocation:
            return "Where are you going? Location cannot be empty."
        }
    }
}
