//
//  Trip.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import Foundation
import PhotosUI
import SwiftUI

struct Trip: Identifiable, Equatable {
    let id: Int
    let tripName: String
    let location: String
    let longitude: Double
    let latitude: Double
    let budget: Int
    let totalSpending: Int
    let isFavorite: Bool
    let startDate: Date
    let endDate: Date
    let imageURLString: URL?
    
    @MainActor
    static var example: Trip {
        return Trip(
            id: 1,
            tripName: "Mango Sticky Rice Summer",
            location: "Bangkok, Thailand",
            longitude: 13.7563,
            latitude: 100.5018,
            budget: 5000,
            totalSpending: 30,
            isFavorite: true,
            startDate: Calendar.current.date(byAdding: .day, value: 2, to: Date.now) ?? .now,
            endDate: Calendar.current.date(byAdding: .day, value: 3, to: Date.now) ?? .now,
            imageURLString: nil
        )
    }
}

extension Trip {
    var dateRangeString: String {
        startDate.formattedDateRange(to: endDate)
    }
    
    var dateDifference: String {
        return startDate.relativeCalendarDescription()
    }
    
    var city: String {
        let cityCountryPairArray = location.split(separator: ",")

        return String(cityCountryPairArray[0]).trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    }
    
    var country: String {
        let cityCountryPairArray = location.split(separator: ",")

        return String(cityCountryPairArray[1]).trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    }
}
